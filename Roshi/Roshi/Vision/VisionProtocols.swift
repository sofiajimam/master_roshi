//
//  VisionProtocols.swift
//  Roshi
//
//  Created by Sofía Jimémez Martínez on 16/03/24.
//

import Foundation
import SwiftUI

protocol VisionProtocol {
    func startVision(highlightedImage: NSImage, plainImage: NSImage) async -> String?
}
