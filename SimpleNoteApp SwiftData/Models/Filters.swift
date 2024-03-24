//
//  Filters.swift
//  SimpleNoteApp SwiftData
//
//  Created by Etienne Grey on 3/24/24 @ 2:12 PM.
//  Copyright (c) 2024 Etienne Grey. All rights reserved.
//
//  Github: https://github.com/etiennegrey
//  BuyMeACoffee: https://buymeacoffee.com/etiennegrey
//


import Foundation


enum NoteSortBy: Identifiable, CaseIterable {
    
    var id: Self { self }
    case timeStamp
    case content
    
    var text: String {
        switch self {
        case .timeStamp: return "Created at"
        case .content: return "Content"
        }
    }
}

enum OrderBy: Identifiable, CaseIterable {
    
    var id: Self { self }
    case ascending
    case descending
    
    var text: String {
        switch self {
        case .ascending: return "Ascending"
        case .descending: return "descending"
        }
    }
    
}
