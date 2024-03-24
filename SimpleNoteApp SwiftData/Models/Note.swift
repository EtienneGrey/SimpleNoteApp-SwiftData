//
//  Note.swift
//  SimpleNoteApp SwiftData
//
//  Created by Etienne Grey on 3/24/24 @ 12:16 PM.
//  Copyright (c) 2024 Etienne Grey. All rights reserved.
//
//  Github: https://github.com/etiennegrey
//  BuyMeACoffee: https://buymeacoffee.com/etiennegrey
//


import Foundation
import SwiftData

@Model
class Note {
    
    var id: String?
    var content: String
    var timeStamp: Date = Date()
    
    @Relationship(inverse: \Tag.notes) var tags: [Tag]?
    
    init(id: String, content: String, timeStamp: Date, tags: [Tag]) {
        self.id = id
        self.content = content
        self.timeStamp = timeStamp
        self.tags = tags
    }
    
}
