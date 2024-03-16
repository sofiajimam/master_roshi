//
//  ChatRoshiView.swift
//  Roshi
//
//  Created by Pablo Salas on 16/03/24.
//

import SwiftUI
import Combine

struct Message: Identifiable {
    let id = UUID()
    let text: String
    let sender: Sender

    enum Sender {
        case user
        case assistant
    }
}

struct ChatRoshiView: View {
    @State private var userInput: String = ""
    @State var messages: [Message] = []
    let brain: Brain

    
    var body: some View {
        VStack {
            HStack(spacing: 10) {
                  Text("Mentor y Evaluador")
                    .font(Font.custom("SF Pro Display", size: 16).weight(.medium))
                    .foregroundColor(Color(red: 0.56, green: 0.56, blue: 0.58))
                Spacer()
                }
                .padding(EdgeInsets(top: 12, leading: 20, bottom: 12, trailing: 20))
                .frame(width: 400, height: 43)
                .background(Color(red: 0.56, green: 0.56, blue: 0.58).opacity(0.20));
            ScrollView{
                ForEach(messages, id: \.id) { message in
                HStack {
                    if message.sender == .assistant {
                        Text(message.text)
                            .foregroundColor(.black)
                            .padding()
                            .background(Color.gray.opacity(0.2))
                            .cornerRadius(10)
                        Spacer()
                    } else {
                        Spacer()
                        Text(message.text)
                            .foregroundColor(.white)
                            .padding()
                            .background(Color.blue)
                            .cornerRadius(10)
                    }
                }.padding(.horizontal)
            }
            }
            Spacer()
            HStack {
                TextField("Enter message", text: $userInput)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .foregroundColor(.black)
                Button(action: {
                    Task {
                        let response = await brain.help(message: userInput)
                        DispatchQueue.main.async {
                            messages.append(Message(text: response, sender: .assistant))
                            messages.append(Message(text: userInput, sender: .user))
                            userInput = ""
                        }
                    }
                }) {
                    Text("Send")
                    .foregroundColor(.black)
                }
            }.padding(16)
                .frame(width: 400, height: 74)
                .background(Color(red: 1, green: 1, blue: 1).opacity(0.80))
                .overlay(
                  Rectangle()
                    .inset(by: 0.50)
                    .stroke(
                      Color(red: 0.56, green: 0.56, blue: 0.58).opacity(0.20), lineWidth: 0.50))
            
        }
        .frame(width: 400, height: .infinity)
        .background(Image("BG2").resizable())
            .cornerRadius(14)
    }
}

#Preview {
    ChatRoshiView(brain: Brain())
}
