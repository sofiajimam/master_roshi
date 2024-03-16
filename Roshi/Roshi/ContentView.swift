//
//  ContentView.swift
//  Roshi
//
//  Created by Pablo Salas on 15/03/24.
//

import SwiftUI

struct ContentView: View {
    // Add an instance of Brain
    @StateObject private var fool = Fool()
    @StateObject private var assistant = Assistant()
    @StateObject private var brain = Brain()

    init() {
        brain.setAssistant(assistant: assistant)
        brain.setFool(fool: fool)
    }


    var body: some View {
        VStack {
            Image(systemName: "globe")
                .imageScale(.large)
                .foregroundStyle(.tint)
            Text("Hello, world!")
            Button(action: {
                Task {
                    await brain.startChallenge()
                }
            }) {
                Text("Start Challenge")
            }
        }
        .padding()
    }
}
#Preview {
    ContentView()
}
