//
//  RoshiApp.swift
//  Roshi
//
//  Created by Pablo Salas on 15/03/24.
//

import SwiftUI

@main
struct RoshiApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView().background(VisualEffectView().ignoresSafeArea())
        }.windowStyle(.hiddenTitleBar)
    }
}


struct VisualEffectView: NSViewRepresentable {
    func makeNSView(context: Context) -> NSVisualEffectView {
        let effectView = NSVisualEffectView()
        effectView.state = .active
        return effectView
    }

    func updateNSView(_ nsView: NSVisualEffectView, context: Context) {
    }
}
