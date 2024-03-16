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
    //let vision = Vision()
    
    func screenshot() async {
        guard let image = await webView.takeScreenshot() else {
            print("Couldn't get image from webbrowser")
            return
        }
        saveScreenshot(image)
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
    
    func predict() async {
        guard let image = await webView.takeScreenshot() else {
            print("Couldn't get image from webbrowser")
            return
        }
        
        print(bulma.predict(image))
    }
    
    func outlinePredict() async {
        guard let image = await webView.takeScreenshot() else {
            print("Couldn't get image from webbrowser")
            return
        }
        let prediction = bulma.predict(image)
        let outline = await bulma.mergePredict(image: image, boxes: prediction)
        saveScreenshot(outline)
    }
    
    
    var body: some View {
        VStack {
            VStack {
                webView
                HStack {
                    Button("Take screenshot") {
                        Task {
                            await screenshot()
                        }
                    }
                    Button("Predict screenshot") {
                        Task {
                            await predict()
                        }
                    }
                    Button("Outline screenshot") {
                        Task {
                            await outlinePredict()
                        }
                    }
                }
            }
            .padding()
            
            HStack(spacing: 10) {
                Spacer()
                SidebarMenuView()
                //RetoScreenView()
                NewChallengeView()
                Spacer()
            }
            .padding(10)
        }
        .frame(minWidth: 0,
               maxWidth: .infinity,
               minHeight: 0,
               maxHeight: .infinity,
               alignment: .topLeading)
    }
    
}

#Preview {
    ContentView()
}
