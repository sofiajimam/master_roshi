//
//  Assistant.swift
//  Roshi
//
//  Created by Sofía Jimémez Martínez on 15/03/24.
//

import Foundation
import SwiftOpenAI

class Assistant: AssistantProtocol, ObservableObject {
    private let service: OpenAIService
    var assistant: AssistantObject?
    let assistantID = "asst_wPKWvQlsnjtzqajk8gQIhFlu"
    var thread: ThreadObject?


    
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
    
    func createAssistant() async throws {
        let parameters = AssistantParameters(
            action: .create(model: "gpt-3.5-turbo"),
            name: "My Assistant",
            description: "This is my assistant",
            tools: [AssistantObject.Tool(type: .codeInterpreter)]
        )

        do {
            assistant = try await service.createAssistant(parameters: parameters)
        } catch {
            debugPrint("\(error)")
        }
    }
    

    func commandAssistant(message: String) async -> String {
        var challenge: String = message
        var message: MessageObject?
        var run: RunObject?
        
        
        print("Assistant received command: \(challenge)")
        // Process the command as needed

        // Step 4
        // retrieve the assistant -> this is done in the init
/*         do {
            try await retrieveAssistant()
        } catch {
            debugPrint("\(error)")
            return "Error retrieving assistant"
        } */

        // Step 5
        // create thread
        do {
            try thread = await createThread()
        } catch {
            debugPrint("\(error)")
            return "Error creating thread"
        }
        
        // Step 6
        // create a message
        // TODO: change the prompt with the description or the challenge
        let prompt = challenge + " .Run the command to create a react app."
        let threadID = thread?.id
        let parametersMessage = MessageParameter(role: .user, content: prompt)
        
        do {
            message = try await service.createMessage(threadID: threadID!, parameters: parametersMessage)
            // Continue processing the message
        } catch {
            print("Failed to create message: \(error)")
        }
        
        // Step 7
        // create a run
        let parametersRun = RunParameter(assistantID: assistantID)
        do {
            run = try await service.createRun(threadID: threadID!, parameters: parametersRun)
        } catch {
            print("Failed to create run: \(error)")
        }

        // Step 8
        // monitor the run
        while run?.status == "queued" || run?.status == "in_progress" || run?.status == "cancelling" {
            do {
                // Sleep for 1 second
                try await Task.sleep(nanoseconds: 1_000_000_000 / 3) // 1 second = 1_000_000_000 nanoseconds
                run = try await service.retrieveRun(threadID: thread?.id ?? "nil", runID: run?.id ?? "nil")
            } catch {
                print("Failed to retrieve run: \(error)")
            }
        }

        // Step 9
        // return the output to the brain, when the run is completed
        if run?.status == "completed" {
            do {
                let messages = try await service.listMessages(threadID: threadID!, limit: nil, order: nil, after: nil, before: nil)
                // TODO: Test if these goes
                print(messages)
            } catch {
                print("Failed to list messages: \(error)")
            }
        } else if run?.status == "requires_action" && run?.requiredAction?.type == "submit_tool_outputs" {
            // TODO: sends that it needs action and it asks the brain for the success
            print(run?.status)
        }

        // Step 6
        // return the output to the brain
        return "Assistant received command: \(message)"

    }

    func mentorAssistant(message: String) {
        print("Assistant received mentor message: \(message)")
        // Process the mentor message as needed
    }
}
