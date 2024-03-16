//
//  BrainProtocols.swift
//  Roshi
//
//  Created by Sofía Jimémez Martínez on 15/03/24.
//

import Foundation


protocol BrainProtocol {
    func startChallenge() async
    func help(message: String) async
    func testProject()
    func setFool(fool: FoolProtocol)
    func setAssistant(assistant: AssistantProtocol)
}
