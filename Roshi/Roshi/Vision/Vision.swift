//
//  Vision.swift
//  Roshi
//
//  Created by Sofía Jimémez Martínez on 16/03/24.
//

import Foundation
import SwiftOpenAI

class Vision: VisionProtocol, ObservableObject {

    private let service: OpenAIService
   
    private var selectedImageURL: URL?
    
    init() {
        let apiKey = "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"
        self.service = OpenAIServiceFactory.service(apiKey: apiKey)
    }
    
    func startVision() async {
        do {
            /* let fileManager = FileManager.default
            let folderURL = URL(fileURLWithPath: "~/Documents/todo-app/images", isDirectory: true).resolvingSymlinksInPath()
 */
            /* print("folderURL")
            print(folderURL) */
            
            // Get the image
            /* let fileURLs = try? fileManager.contentsOfDirectory(at: folderURL, includingPropertiesForKeys: nil)
            guard let selectedImageURL = fileURLs?.first else { return }
 */

            /* let imagePath = ("~/Documents/todo-app/images/imagen.png" as NSString).expandingTildeInPath            
            let selectedImageURL = URL(fileURLWithPath: imagePath)
            print("selectedImageURL")
            print(selectedImageURL)
            
            // encode it base 64
            let encodedImage = encodeImage(imagePath: selectedImageURL.path)
            guard let base64Image = encodedImage else { return }

            print("encodedImage")
            print(encodedImage) */

            // send request
            let prompt = "What is this?"
            //guard let imageURL = URL(string: "data:image/jpeg;base64,\(base64Image)") else { return }
            guard let imageURL = URL(string: "https://upload.wikimedia.org/wikipedia/commons/thumb/d/dd/Gfp-wisconsin-madison-the-nature-boardwalk.jpg/2560px-Gfp-wisconsin-madison-the-nature-boardwalk.jpg") else { return }
            let messageContent: [ChatCompletionParameters.Message.ContentType.MessageContent] = [.text(prompt), .imageUrl(imageURL)]
            
            let parameters = ChatCompletionParameters(messages: [.init(role: .user, content: .contentArray(messageContent))], model: .gpt4VisionPreview)
            let chatCompletionObject = try await service.startStreamedChat(
                parameters: parameters)
            
            print("chatCompletionObject")
            print(chatCompletionObject)
        } catch {
            print(error)
        }
    }

    func encodeImage(imagePath: String) -> String? {
        guard let imageData = FileManager.default.contents(atPath: imagePath) else {
            return nil
        }
        return imageData.base64EncodedString()
    }

}
