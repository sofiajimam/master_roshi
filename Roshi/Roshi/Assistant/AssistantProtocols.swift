//
//  AssistantProtocols.swift
//  Roshi
//
//  Created by Sofía Jimémez Martínez on 15/03/24.
//

import Foundation
import SwiftOpenAI


protocol AssistantProtocol {
    func commandAssistant(message: String) async -> String
    func mentorAssistant(message: String)
    func retrieveAssistant() async throws -> AssistantObject
    func createThread() async throws -> ThreadObject
    func createAssistant() async throws
} 
