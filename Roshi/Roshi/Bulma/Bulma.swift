//
//  Bulma.swift
//  Roshi
//
//  Created by Omar Sánchez on 15/03/24.
//

import SwiftUI
import Foundation

class Bulma {
    private let model: Bulma___Iteration_18900
    
    init() {
        self.model = Bulma___Iteration_18900()
    }
    
    func see(_ image: NSImage) {
        var rect = CGRect(x: 0, y: 0, width: image.size.width, height: image.size.height)
        if let cgImage = image.cgImage(forProposedRect: &rect, context: nil, hints: nil) {
            do {
                let prediction = try self.model.prediction(input: .init(imagePathWith: cgImage))
                print(prediction)
            } catch {
                print("Error predicting: \(error)")
            }        
        }
    }
}



