//
//  Assistant.swift
//  Roshi
//
//  Created by Sofía Jimémez Martínez on 15/03/24.
//

import Foundation
import SwiftOpenAI
import SwiftUI

class Assistant: AssistantProtocol, ObservableObject {
    private let service: OpenAIService
    var assistant: AssistantObject?
    let assistantID = "asst_wPKWvQlsnjtzqajk8gQIhFlu"
    var threadCommand: ThreadObject?
    var threadMentor: ThreadObject?

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
        
        // Step 5
        // create thread
        do {
            try threadCommand = await createThread()
        } catch {
            debugPrint("\(error)")
            return "Error creating thread"
        }
        
        // Step 6
        // create a message
        // TODO: change the prompt with the description or the challenge
        let prompt = challenge + " .Run the command to create a react app."
        let threadID = threadCommand?.id
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
                run = try await service.retrieveRun(threadID: threadCommand?.id ?? "nil", runID: run?.id ?? "nil")
                print("RUNNNNNN")
                print(run?.requiredAction?.submitToolsOutputs.toolCalls.first?.function.arguments)
                
            } catch {
                print("Failed to retrieve run: \(error)")
            }
        }

        // Step 9
        // return the output to the brain, when the run is completed
        if run?.status == "completed" {
            do {
                let messages = try await service.listMessages(threadID: threadID!, limit: nil, order: nil, after: nil, before: nil)
                print(messages)
            } catch {
                print("Failed to list messages: \(error)")
            }
        } else if run?.status == "requires_action" && run?.requiredAction?.type == "submit_tool_outputs" {
            // TODO: sends that it needs action and it asks the brain for the success
            if let arguments = run?.requiredAction?.submitToolsOutputs.toolCalls.first?.function.arguments,
               let data = arguments.data(using: .utf8),
               let jsonObject = try? JSONSerialization.jsonObject(with: data, options: []),
               let dictionary = jsonObject as? [String: Any],
               let command = dictionary["command"] as? String {
                print("Command: \(command)")
                return command
            }
        } else {
            print("Run status: \(run?.status ?? "nil")")
        }

        // Step 6
        // return the output to the brain
        return "Assistant received command: \(message)"

    }

    func mentorAssistant(message: String) async -> String {
        let response: String = message
        var mentorMessage: MessageObject?
        var mentorRun: RunObject?
        var filesPrompt: String = ""

        print("Assistant received mentor message: \(message)")
        // Check if threadMentor exists, if not, create a new one
        if threadMentor == nil {
            do {
                // Read all the files in the folder
                let fileManager = FileManager.default

                let folderPath = (("~/Documents/todo-app/src") as NSString).expandingTildeInPath
                let folderURL = URL(fileURLWithPath: folderPath, isDirectory: true)
                
                let fileURLs = try fileManager.contentsOfDirectory(at: folderURL, includingPropertiesForKeys: nil)
            

                // Convert the files to strings
                var allFileContents: String = ""
                for fileURL in fileURLs {
                    let fileContent = try String(contentsOf: fileURL)
                    allFileContents += "\n\nFile: \(fileURL.lastPathComponent)\n\n\(fileContent)"
                }

                // Create the thread with the file contents as message
                filesPrompt = "This is my entire code: \(allFileContents)\nAnd I want you to answer: "
                threadMentor = try await createThread()
            } catch {
                debugPrint("Error creating mentor thread: \(error)")
                return "Error creating mentor thread"
            }
        }
        
        // Assuming mentor message processing is similar to command
        // Create a mentor message
        let mentorPrompt = filesPrompt + " " + response + " .Process this mentorship advice."
        //let mentorPrompt = response + " .Process this mentorship advice."
        let threadID = threadMentor?.id
        let parametersMentorMessage = MessageParameter(role: .user, content: mentorPrompt)
        
        do {
            mentorMessage = try await service.createMessage(threadID: threadID!, parameters: parametersMentorMessage)
            // Continue processing the message
        } catch {
            print("Failed to create mentor message: \(error)")
        }
        
        // Create a mentor run if needed
        // This is assuming that a run might be required for processing mentor messages, similar to commandAssistant
        let parametersMentorRun = RunParameter(assistantID: assistantID)
        do {
            mentorRun = try await service.createRun(threadID: threadID!, parameters: parametersMentorRun)
        } catch {
            print("Failed to create mentor run: \(error)")
        }
        
        // Monitor the run (if applicable)
        // Similar logic as in commandAssistant for monitoring and processing the run
        while mentorRun?.status == "queued" || mentorRun?.status == "in_progress" || mentorRun?.status == "cancelling" {
            do {
                // Sleep for a short duration before retrying
                try await Task.sleep(nanoseconds: 1_000_000_000 / 3) // Adjust the sleep duration as needed
                mentorRun = try await service.retrieveRun(threadID: threadMentor?.id ?? "nil", runID: mentorRun?.id ?? "nil")
            } catch {
                print("Failed to retrieve mentor run: \(error)")
            }
        }

        if mentorRun?.status == "completed" {
            do {
                var firstAssistantMessage: String = ""
                
                if let messages = try? await service.listMessages(threadID: threadID!, limit: nil, order: nil, after: nil, before: nil) {
                    for message in messages.data {
                        if message.role == "assistant" {
                            if let content = message.content.first, case let .text(textContent) = content {
                                firstAssistantMessage = textContent.text.value
                                break
                            }
                        }
                    }
                }
                
                print("First assistant message: \(firstAssistantMessage)")
            } catch {
                print("Failed to list messages: \(error)")
            }
        } else {
            print("Mentor run is not completed")
        }
        
        // Process the completion of the run
        // This part would include handling the output from the run and formatting it into a response
        
        return "Processed mentor message: \(response)"
    }

}
