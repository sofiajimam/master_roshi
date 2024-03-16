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
    var outputMarkdown: String?
    var outputMentor: String?

    init() {
        self.fool = Fool()
        self.assistant = Assistant()
    }
    


    func startChallenge(outputGpt: String) async {
        // Start the challenge

        // Step 1
        // Get the part of the visual content in the UI
        // Mark down        
        var challenge = outputGpt

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

    func getChallenge() async -> String {
        outputMarkdown = await sendMessageToChallengeAssistant(message: "I need a challenge")
        await startChallenge(outputGpt: outputMarkdown ?? "")
        return outputMarkdown ?? ""
        print("Challenge from challenge assistant: \(output ?? "")")
    }

    func help(message: String) async  -> String{
        // Get help from the assistant
        output = await sendMessageToMentorAssistant(message: message)
        return output ?? ""
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

    private func sendMessageToChallengeAssistant(message: String) async -> String {
        do {
            output = try await assistant.askGPT3(message: "Give me the description, title, results of what i am expecting of a basic todo-app react app, give me the general description, what technologies i will use. Everything in Markdown Style")
            print("sent message to command assistant: \(message)")
            return output ?? ""
        } catch {
            print("Failed to send message to command assistant: \(error)")
        }
        
        return output ?? ""
    }

    private func sendMessageToMentorAssistant(message: String) async -> String {
        do {
            outputMentor = try await assistant.mentorAssistant(message: message)
            print("sent message to command assistant: \(outputMentor)")
            return outputMentor ?? ""
        } catch {
            print("Failed to send message to command assistant: \(error)")
        }
    }
}
