//
//  Bulma.swift
//  Roshi
//
//  Created by Omar Sánchez on 15/03/24.
//

import SwiftUI
import CoreML
import Foundation

class Bulma {
    private let model: Bulma___Iteration_18900
    
    init() {
        self.model = Bulma___Iteration_18900()
    }
    
    func predict(_ image: NSImage) -> MLMultiArray {
        var rect = CGRect(x: 0, y: 0, width: image.size.width, height: image.size.height)
        if let cgImage = image.cgImage(forProposedRect: &rect, context: nil, hints: nil) {
            do {
                let prediction = try self.model.prediction(input: .init(imagePathWith: cgImage))
                // this is a multidimensional array of doubles with 4 values (x, y, height, width)
                return prediction.coordinates
            } catch {
                print("Error predicting: \(error)")
                return MLMultiArray.init()
            }
        }
        
        return MLMultiArray.init()
    }

    func viewToImage(from view: NSView) -> NSImage {
        let image = NSImage(size: view.bounds.size)
        let bitmapRep = NSBitmapImageRep(bitmapDataPlanes: nil, pixelsWide: Int(view.bounds.width), pixelsHigh: Int(view.bounds.height), bitsPerSample: 8, samplesPerPixel: 4, hasAlpha: true, isPlanar: false, colorSpaceName: .calibratedRGB, bytesPerRow: 0, bitsPerPixel: 0)!
        image.addRepresentation(bitmapRep)
        view.layoutSubtreeIfNeeded()
        view.cacheDisplay(in: view.bounds, to: bitmapRep)
        return image
    }

    func mergePredict(image: NSImage, boxes: MLMultiArray) async -> NSImage {
        var boxArray = [[Double]]()
        let count = boxes.shape[0].intValue
        let featurePointer = boxes.dataPointer.bindMemory(to: Double.self, capacity: boxes.count)
        let stride = boxes.strides[0].intValue
        for i in 0..<count {
            let x = featurePointer[i * stride]
            let y = featurePointer[i * stride + 1]
            let width = featurePointer[i * stride + 2]
            let height = featurePointer[i * stride + 3]
            boxArray.append([x, y, width, height])
        }

        return await withCheckedContinuation { continuation in
            let imageViewWithBoxes = SegmentedView(image: image, boxes: boxArray)
            DispatchQueue.main.async {
                let hostingView = NSHostingView(rootView: imageViewWithBoxes)
                hostingView.frame = CGRect(x: 0, y: 0, width: image.size.width, height: image.size.height)
                let viewImage = self.viewToImage(from: hostingView)
                continuation.resume(returning: viewImage)
            }
        }
    }
}



