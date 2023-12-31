//
//  Item.swift
//  keeppix
//
//  Created by Peter Wright on 31/12/2023.
//

import Foundation
import SwiftData

@Model
final class Item {
    var timestamp: Date
    
    init(timestamp: Date) {
        self.timestamp = timestamp
    }
}
