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
    let webView = WebView(viewModel: .init(link: "https://arc.net/"))
    let bulma = Bulma()
    
    func screenshot() async -> Void {
        guard let image = await webView.takeScreenshot() else {
            print("Couldn't get image from webbrowser")
            return
        }
        saveScreenshot(image)
    }
    
    func predict() {
        
    }
    
    func saveScreenshot(_ image: NSImage) {
        DispatchQueue.main.async {
            let panel = NSSavePanel()
            panel.allowedContentTypes = [.png]
            panel.nameFieldStringValue = "screenshot.png"
            panel.begin { (result) in
                if result == NSApplication.ModalResponse.OK {
                    if let url = panel.url {
                        if let data = image.tiffRepresentation, let bitmapImage = NSBitmapImageRep(data: data) {
                            let pngData = bitmapImage.representation(using: .png, properties: [:])
                            try? pngData?.write(to: url)
                        }
                    }
                }
            }
        }
    }


    var body: some View {
        VStack {
            webView
            Button("Take screenshot") {
                Task {
                    await screenshot()
                }
            }
        }
        .padding()
    }
}
#Preview {
    ContentView()
}
