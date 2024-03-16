//
//  Brain.swift
//  Roshi
//
//  Created by Sofía Jimémez Martínez on 15/03/24.
//

import Foundation

class Brain: BrainProtocol {
    private var fool: FoolProtocol?
    private var assistant: AssistantProtocol?

    var output: String?
    

    func startChallenge() {
        // Start the challenge

        // Step 1
        // Get the part of the visual content in the UI
        // Mark down

        // Step 2
       // send message to asssitant commands
        output = sendMessageToCommandAssistant(message: "Start the challenge")

        // Step 3
        // tell the fool to run the command
        fool?.executeCommand(output)
    }

    func help() {
        // Get help from the assistant
        sendMessageToMentorAssistant("I need help")
    }

    func setFool(fool: FoolProtocol) {
        self.fool = fool
    }

    func setAssistant(assistant: AssistantProtocol) {
        self.assistant = assistant
    }

    func testProject() {
        fool?.testProject()
    }

    private func sendMessageToCommandAssistant(message: String) {
        assistant?.commandAssistant(message)
    }

    private func sendMessageToMentorAssistant(message: String) {
        assistant?.mentorAssistant(message)
    }
}
