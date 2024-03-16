//
//  AssistantProtocols.swift
//  Roshi
//
//  Created by Sofía Jimémez Martínez on 15/03/24.
//

import Foundation


protocol AssistantProtocol {
    func commandAssistant(message: String) -> String
    func mentorAssistant(message: String)
} 