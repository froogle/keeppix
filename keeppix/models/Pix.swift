//
//  Pix.swift
//  keeppix
//
//  Created by Peter Wright on 15/01/2024.
//

import Foundation
import SwiftData

@Model
class Pix {
    @Attribute(.unique) var id: String
    @Attribute(.externalStorage) var imageData: Data?
    var pixDescription: String
    var tags: [String]
    var createdAt: Date
    var updatedAt: Date
    var viewCount = 0
    
    init(id: String? = nil, createdAt: Date = Date.now, updatedAt: Date = Date.now, pixDescription: String, tags: [String]) {
        self.id = id ?? UUID().uuidString
        self.pixDescription = pixDescription
        self.tags = []
        self.createdAt = createdAt
        self.updatedAt = updatedAt
        
        for tag in tags {
            self.tags.append(tag.lowercased())
        }
    }
}
