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


//
//  Vision.swift
//  Roshi
//
//  Created by Sofía Jimémez Martínez on 16/03/24.
//

import Foundation
import SwiftOpenAI

class Vision: VisionProtocol, ObservableObject {

    private let apiKey = "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"
    private var selectedImageURL: URL?

    func startVision() async {
        do {
            // Assuming you have a valid image URL
            guard let imagePath = Bundle.main.path(forResource: "~/Documents/todo-app/images/imagen.png", ofType: "jpg") else { return }
            guard let base64Image = encodeImage(imagePath: imagePath) else { return }

            let headers = [
                "Content-Type": "application/json",
                "Authorization": "Bearer \(apiKey)"
            ]
            
            let payload: [String: Any] = [
                "model": "gpt-4-vision-preview",
                "messages": [
                    [
                        "role": "user",
                        "content": [
                            [
                                "type": "text",
                                "text": "What’s in this image?"
                            ],
                            [
                                "type": "image_url",
                                "image_url": [
                                    "url": "data:image/jpeg;base64,\(base64Image)"
                                ]
                            ]
                        ]
                    ]
                ],
                "max_tokens": 300
            ]

            guard let url = URL(string: "https://api.openai.com/v1/chat/completions") else {
                print("Invalid URL")
                return
            }
            
            var request = URLRequest(url: url)
            request.httpMethod = "POST"
            request.allHTTPHeaderFields = headers
            request.httpBody = try? JSONSerialization.data(withJSONObject: payload, options: [])
            
            let (data, _) = try await URLSession.shared.data(for: request)
            
            if let jsonObject = try JSONSerialization.jsonObject(with: data, options: []) as? [String: Any] {
                print(jsonObject)
            } else {
                print("Failed to parse JSON response")
            }
        } catch {
            print("Error: \(error)")
        }
    }

    func encodeImage(imagePath: String) -> String? {
        guard let imageData = FileManager.default.contents(atPath: imagePath) else {
            return nil
        }
        return imageData.base64EncodedString()
    }

}

