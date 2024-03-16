//
//  Evaluator.swift
//  Roshi
//
//  Created by Omar Eduardo Sánchez on 16/03/24.
//

import Foundation
import SwiftOpenAI
import SwiftUI
//import SwiftDotEnv

class Evaluator: EvaluatorProtocol, ObservableObject {
    
    private let service: OpenAIService
    var assistant: AssistantObject?
    let assistantID = "asst_XBgZikZTGS26RKiv3BoCz2zg"
    var threadCommand: ThreadObject?
    var threadMentor: ThreadObject?
    
    struct OnClickArgs: Codable {
        let number: Int
    }
    
    // callbacks
    var onClick: (Int) async -> String = { _ in return "" }
    var onView: () async -> String = { return "" }

    init() {
        let apiKey = "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"
        self.service = OpenAIServiceFactory.service(apiKey: apiKey)
        Task.init {
            do {
                self.assistant = try await self.retrieveAssistant()
            } catch {
                print("Failed to retrieve assistant: \(error)")
            }
        }
    }
    
    func attachCallbacks(onClick: @escaping (Int) async-> String, onView: @escaping () async -> String) {
        self.onClick = onClick
        self.onView = onView
    }
    

    func retrieveAssistant() async throws -> AssistantObject {
        do {
            assistant = try await service.retrieveAssistant(id: assistantID)
            return assistant!
        } catch {
            debugPrint("\(error)")
            throw error
        }
    }
    

    func createThread() async throws -> ThreadObject {
        let parameters = CreateThreadParameters()

        do {
            let thread = try await service.createThread(parameters: parameters)
            return thread
        } catch {
            debugPrint("\(error)")
            throw error
        }
    }
    
    func callTool(_ tool: String?, arguments: String?) async -> String {
        do {
            switch tool {
            case "view_page":
                return "{ \"description\": \"\(await self.onView())\", \"success\": true }"
            case "click_element":
                let onClickArgs = try JSONDecoder().decode(OnClickArgs.self, from: arguments!.data(using: .utf8)!)
                return "{ \"description\": \"\(await self.onClick(onClickArgs.number))\", \"success\": true }"
            default:
                return "{ \"success\": true }"
            }
        } catch {
            print(error)
            return "{ \"success\": false }"
        }
    }
    
    func trigger(challenge: String) async {
        do {
            let thread = try await createThread()
            var run = try await service.createRun(threadID: thread.id, parameters: .init(assistantID: self.assistantID, additionalInstructions: ""))
            
            while run.status == "queued" || run.status == "in_progress" {
                // Sleep for a short duration before retrying
                try await Task.sleep(nanoseconds: 1_000_000_000 / 3) // Adjust the sleep duration as needed
                run = try await service.retrieveRun(threadID: threadMentor?.id ?? "nil", runID: run.id)
                
                if run.status == "requires_action" {
                    var toolOutputs: [RunToolsOutputParameter.ToolOutput] = []

                    if let toolCalls = run.requiredAction?.submitToolsOutputs.toolCalls {
                        await withTaskGroup(of: RunToolsOutputParameter.ToolOutput.self) { group in
                            for call in toolCalls {
                                group.addTask {
                                    let functionName = call.function.name
                                    let functionArgs = call.function.arguments
                                    let functionId = call.id
                                    
                                    return await RunToolsOutputParameter.ToolOutput(toolCallId: functionId, output: self.callTool(functionName, arguments: functionArgs))
                                }
                            }

                            for await output in group {
                                toolOutputs.append(output)
                            }
                        }
                    }
                    
                    try await service.submitToolOutputsToRun(threadID: thread.id, runID: run.id, parameters: .init( toolOutputs: toolOutputs))
                }
                
                if run.status == "cancelled" || run.status == "cancelling" || run.status == "expired" || run.status == "failed" {
                    print("There was a problem while evaluating this excersice")
                    break
                }
                
                if run.status == "completed" {
                    print("The evaluation has completed")
                    break
                }
            }
        } catch {
            print(error)
        }
    }
}
