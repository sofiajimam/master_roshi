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
    
    func screenshot() async {
        guard let image = await webView.takeScreenshot() else {
            print("Couldn't get image from webbrowser")
            return
        }
        saveScreenshot(image)
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
    }
}
#Preview {
    ContentView()
}
