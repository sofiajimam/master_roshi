//
//  BrainProtocols.swift
//  Roshi
//
//  Created by Sofía Jimémez Martínez on 15/03/24.
//

import Foundation


protocol BrainProtocol {
    func startChallenge(outputGpt: String) async
    func help(message: String) async -> String
    func testProject()
    func getChallenge() async -> String
    func setFool(fool: FoolProtocol)
    func setAssistant(assistant: AssistantProtocol)
}
