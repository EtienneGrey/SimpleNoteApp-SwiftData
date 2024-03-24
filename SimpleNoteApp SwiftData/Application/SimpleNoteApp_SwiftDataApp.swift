//
//  SimpleNoteApp_SwiftDataApp.swift
//  SimpleNoteApp SwiftData
//
//  Created by Etienne Grey on 3/24/24 @ 12:16 PM.
//  Copyright (c) 2024 Etienne Grey. All rights reserved.
//
//  Github: https://github.com/etiennegrey
//  BuyMeACoffee: https://buymeacoffee.com/etiennegrey
//


import SwiftUI
import SwiftData

@main
struct SimpleNoteApp_SwiftDataApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
                .modelContainer(for: [
                    Note.self,
                    Tag.self
                ])
                .preferredColorScheme(.dark)
        }
    }
}
