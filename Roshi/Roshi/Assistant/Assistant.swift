//
//  Assistant.swift
//  Roshi
//
//  Created by Sofía Jimémez Martínez on 15/03/24.
//

import Foundation
import SwiftOpenAI

class Assistant: AssistantProtocol {
    private let service: OpenAIService
    var assistant: AssistantObject

    
    init(service: OpenAIService) {
          self.service = service
    }
    
    /*
        let assistantID = "asst_abc123"
let assistant = try await service.retrieveAssistant(id: assistantID)
    */


    func retrieveAssistant() async throws {
        let assistantID = "asst_wPKWvQlsnjtzqajk8gQIhFlu"
        do {
            assistant = try await service.retrieveAssistant(id: assistantID)
        } catch {
            debugPrint("\(error)")
        }
    }
    

    func createThread() async throws -> ThreadObject {
        let parameters = CreateThreadParameters()

        do {
            let thread = try await service.createThread(parameters: parameters)
            return thread
        } catch {
            debugPrint("\(error)")
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
        var thread: ThreadObject
        var message: MessageObject
        var run: RunObject
        
        print("Assistant received command: \(message)")
        // Process the command as needed

        // Step 4
        // retrieve the assistant
        do {
            try await retrieveAssistant()
        } catch {
            debugPrint("\(error)")
            return "Error retrieving assistant"
        }

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
        let prompt = "run the command to create a react app"
        let threadID = thread.id
        let parametersMessage = MessageParameter(role: .user, content: prompt)
        
        do {
            message = try await service.createMessage(threadID: threadID, parameters: parametersMessage)
            // Continue processing the message
        } catch {
            print("Failed to create message: \(error)")
        }
        
        // Step 7
        // create a run
        let assistantID = assistant.id
        let parametersRun = RunParameter(assistantID: assistantID)
        do {
            run = try await service.createRun(threadID: threadID, parameters: parametersRun)
        } catch {
            print("Failed to create run: \(error)")
        }

        // Step 8
        // monitor the run
        while run.status == "queued" || run.status == "in_progress" || run.status == "cancelling" {
            do {
                // Sleep for 1 second
                try await Task.sleep(nanoseconds: 1_000_000_000 / 3) // 1 second = 1_000_000_000 nanoseconds
                run = try await service.retrieveRun(threadID: thread.id, runID: run.id)
            } catch {
                print("Failed to retrieve run: \(error)")
            }
        }

        // Step 9
        // return the output to the brain, when the run is completed
        if run.status == "completed" {
            do {
                let messages = try await service.listMessages(threadID: threadID, limit: nil, order: nil, after: nil, before: nil)
                print(messages)
            } catch {
                print("Failed to list messages: \(error)")
            }
        } else if run.status == "require" {
            print(run.status)
        }

        // TODO: check if it requires action

        // Step 6
        // return the output to the brain
        return "Assistant received command: \(message)"

    }

    func mentorAssistant(message: String) {
        print("Assistant received mentor message: \(message)")
        // Process the mentor message as needed
    }
}
