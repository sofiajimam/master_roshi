//
//  BrainProtocols.swift
//  Roshi
//
//  Created by Sofía Jimémez Martínez on 15/03/24.
//

import Foundation


protocol BrainProtocol {
    func startChallenge()
    func help()

    func testProject()
    
    func setFool(fool: FoolProtocol)
    func setAssistant(assistant: AssistantProtocol)

}
