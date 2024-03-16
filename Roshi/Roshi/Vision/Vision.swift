//
//  Vision.swift
//  Roshi
//
//  Created by Sofía Jimémez Martínez on 16/03/24.
//

import Foundation
import SwiftOpenAI
import SwiftUI

class Vision: VisionProtocol, ObservableObject {
    private let service: OpenAIService
   
    private var selectedImageURL: URL?
    
    init() {
        let apiKey = "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"
        self.service = OpenAIServiceFactory.service(apiKey: apiKey)
    }
    
    func startVision(highlightedImage: NSImage, plainImage: NSImage) async {
        do {
            guard let base64HighlightedImage = imageToBase64(highlightedImage) else { return }
            guard let base64PlainImage = imageToBase64(highlightedImage) else { return }

            guard let highlightedImageURL = URL(string: "data:image/jpeg;base64,\(base64HighlightedImage)") else { return }
            guard let plainImageURL = URL(string: "data:image/jpeg;base64,\(base64PlainImage)") else { return }
            let messageContent: [ChatCompletionParameters.Message.ContentType.MessageContent] = [.imageUrl(highlightedImageURL), .imageUrl(plainImageURL)]
            
            let parameters = ChatCompletionParameters(messages: [
                .init(role: .system, content: .text("You are an AI that sees the segmented screenshots the user sends you and makes numbered lists describing the content of each segment highlighted with a red box and a number. \n IMPORTANT: You are receiving 2 images, one of them is the plain and the other one is the same interface but with the segments highlighted. Also give a general explanation or aproximation of the content of the screen.")),
                .init(role: .user, content: .contentArray(messageContent)),
            ], model: .gpt4VisionPreview, maxTokens: 1400)
            let chatCompletionObject = try await service.startChat(
                parameters: parameters)
            
            print("chatCompletionObject")
            print(chatCompletionObject)
        } catch {
            print(error)
        }
    }

    func imageToBase64(_ image: NSImage) -> String? {
        guard let imageData = image.tiffRepresentation else {
            return nil
        }
        
        guard let bitmap = NSBitmapImageRep(data: imageData) else {
            return nil
        }
        
        let properties: [NSBitmapImageRep.PropertyKey: Any] = [.compressionFactor: 1.0]
        guard let pngData = bitmap.representation(using: .png, properties: properties) else {
            return nil
        }
        let base64String = pngData.base64EncodedString(options: [])
        
        return base64String
    }

}
