//
//  EvaluatorProtocol.swift
//  Roshi
//
//  Created by Sofía Jimémez Martínez on 16/03/24.
//

import Foundation
import SwiftOpenAI

protocol EvaluatorProtocol {
    func attachCallbacks(onClick: @escaping (Int) async -> String, onView: @escaping () async -> String)
    func retrieveAssistant() async throws -> AssistantObject
    func createThread() async throws -> ThreadObject
    func callTool(_ tool: String?, arguments: String?) async -> String
    func trigger(challenge: String) async
}
