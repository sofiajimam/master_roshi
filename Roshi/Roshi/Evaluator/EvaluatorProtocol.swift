//
//  EvaluatorProtocol.swift
//  Roshi
//
//  Created by Sofía Jimémez Martínez on 16/03/24.
//

import Foundation
import SwiftOpenAI

protocol EvaluatorProtocol {
    func commandAssistant(message: String) async -> String
    func mentorAssistant(message: String) async -> String
    func retrieveAssistant() async throws -> AssistantObject
    func createThread() async throws -> ThreadObject
}
