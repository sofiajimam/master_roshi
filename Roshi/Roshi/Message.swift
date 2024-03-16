//
//  Message.swift
//  Roshi
//
//  Created by Pablo Salas on 16/03/24.
//

import Foundation

struct Message: Identifiable {
    let id = UUID()
    let text: String
    let isFromUser: Bool // Determina si el mensaje es del usuario o del bot
}
