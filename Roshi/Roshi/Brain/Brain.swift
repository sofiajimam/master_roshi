//
//  Brain.swift
//  Roshi
//
//  Created by Sofía Jimémez Martínez on 15/03/24.
//

import Foundation

class Brain: BrainProtocol, ObservableObject {
    private var fool: FoolProtocol
    private var assistant: AssistantProtocol

    var output: String?

    init() {
        self.fool = Fool()
        self.assistant = Assistant()
    }
    

    func startChallenge() async {
        // Start the challenge

        // Step 1
        // Get the part of the visual content in the UI
        // Mark down
        
        // TODO: Modify this with more prompt -> add the results or what is expected
        var challenge = "the challenge is about a basic todo list react web application for beginners."

        // Step 2
        // send message to asssitant commands
        // Step 2
        // send message to assistant commands
        do {
            output = try await sendMessageToCommandAssistant(message: challenge)
        } catch {
            print("Failed to send message to command assistant: \(error)")
        }

        // Step 3
        // tell the fool to run the command
        if let command = output {
            fool.executeCommand(command: command)
        } else {
            print("Output is nil")
        }
    }

    func help(message: String) async {
        // Get help from the assistant
        output = await sendMessageToMentorAssistant(message: message)
        print("Help from mentor assistant: \(output ?? "")")
    }

    func setFool(fool: FoolProtocol) {
        self.fool = fool
    }

    func setAssistant(assistant: AssistantProtocol) {
        self.assistant = assistant
    }

    func testProject() {
        fool.testProject()
    }

    private func sendMessageToCommandAssistant(message: String) async -> String {
        do {
            output = try await assistant.commandAssistant(message: message)
            print("sent message to command assistant: \(message)")
            return output ?? ""
        } catch {
            print("Failed to send message to command assistant: \(error)")
        }
    }

    private func sendMessageToMentorAssistant(message: String) async -> String {
        do {
            output = try await assistant.mentorAssistant(message: message)
            print("sent message to command assistant: \(message)")
            return output ?? ""
        } catch {
            print("Failed to send message to command assistant: \(error)")
        }
    }
}
