//
//  ContentView.swift
//  Roshi
//
//  Created by Pablo Salas on 15/03/24.
//

import SwiftUI
import WebKit
import AppKit

struct ContentView: View {
    //let webView = WebView(viewModel: .init(link: "https://arc.net/"))
    let bulma = Bulma()
    let vision = Vision()
    
    func screenshot() async -> Void {

    }
    
    func predict() {
        
    }


    var body: some View {
        VStack {
            
            Button("Start Vision") {
                Task {
                    await vision.startVision()
                }
            }
        }
        .padding()
    }
}
#Preview {
    ContentView()
}
