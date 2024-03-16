//
//  ContentView.swift
//  Roshi
//
//  Created by Pablo Salas on 15/03/24.
//

import SwiftUI

struct ContentView: View {
    @StateObject private var fool = Fool()
    @StateObject private var assistant = Assistant()
    @StateObject private var brain = Brain()
    @State private var helpInput: String = ""

    var body: some View {
        VStack {
            Image(systemName: "globe")
                .imageScale(.large)
                .foregroundStyle(.tint)
            Text("Hello, world!")
            TextField("Enter help input", text: $helpInput)
                .textFieldStyle(.roundedBorder)
                .padding()
            Button(action: {
                Task {
                    await brain.help(message: helpInput)
                }
            }) {
                Text("Get Help")
            }
            Button(action: {
                Task {
                    await brain.startChallenge()
                }
            }) {
                Text("Start Challenge")
            }
        }
        .padding()
        .onAppear {
            brain.setAssistant(assistant: assistant)
            brain.setFool(fool: fool)
        }
    }
}
#Preview {
    ContentView()
}
