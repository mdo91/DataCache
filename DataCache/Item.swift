//
//  Item.swift
//  DataCache
//
//  Created by Mahmoud Aoata on 26/05/2025.
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
