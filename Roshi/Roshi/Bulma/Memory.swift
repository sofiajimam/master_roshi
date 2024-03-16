//
//  Memory.swift
//  Roshi
//
//  Created by Omar Sánchez on 16/03/24.
//

import Foundation
import SwiftUI

struct CachedMemory: Identifiable {
    let id: UUID
    let image: NSImage
    let boxes: [[Double]]
    
    init(image: NSImage, boxes: [[Double]]) {
        self.id = UUID()
        self.image = image
        self.boxes = boxes
    }
}

class Memory {
    var memories: [CachedMemory] = []
    
    static var shared: Memory {
        let instance = Memory()
        
        return instance
    }
    
    private init() {}
    
    func add(memory: CachedMemory) -> CachedMemory {
        self.memories.append(memory)
        return memory
    }

    func remove(memory: CachedMemory) -> CachedMemory {
        if let index = self.memories.firstIndex(where: { $0.id == memory.id }) {
            self.memories.remove(at: index)
        }
        return memory
    }

    func clear() {
        self.memories.removeAll()
    }

    func getMemory(id: UUID) -> CachedMemory? {
        return self.memories.first(where: { $0.id == id })
    }
}
