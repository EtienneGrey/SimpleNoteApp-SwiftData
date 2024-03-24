//
//  TagListView.swift
//  SimpleNoteApp SwiftData
//
//  Created by Etienne Grey on 3/24/24 @ 12:44 PM.
//  Copyright (c) 2024 Etienne Grey. All rights reserved.
//
//  Github: https://github.com/etiennegrey
//  BuyMeACoffee: https://buymeacoffee.com/etiennegrey
//


import SwiftUI
import SwiftData


struct TagListView: View {
    
    @Environment(\.modelContext) private var context
    @Query(sort: \Tag.name, order: .reverse) var tags: [Tag]
    
    @State private var tagText = ""
    
    var body: some View {
        List {
            Section {
                DisclosureGroup("Create a tag") {
                    TextField("Enter text", text: $tagText, axis: .vertical)
                        .lineLimit(1...4)
                    Button("Save") {
                       createTag()
                    }
                    .disabled(tagText.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty)
                }
            }
            
            Section {
                if tags.isEmpty {
                    ContentUnavailableView("No tags created", systemImage: "tag")
                } else {
                    ForEach(tags) { tag in
                        if tag.notes?.count ?? 0 > 0 {
                            DisclosureGroup("\(tag.name) (\(tag.notes!.count))") {
                                ForEach(tag.notes!) { note in
                                    Text(note.content)
                                }
                                .onDelete { indexSet in
                                    indexSet.forEach { index in
                                        context.delete(tag.notes![index])
                                    }
                                    try? context.save()
                                }
                               
                            }
                        } else {
                            Text(tag.name)
                        }
                    
                    }
                    .onDelete(perform: { indexSet in
                        indexSet.forEach { index in
                            context.delete(tags[index])
                        }
                    })
                }
            }
            
        }
    }
}

extension TagListView {
    func createTag() {
        let tag = Tag(id: UUID().uuidString, name: tagText, notes: [])
        context.insert(tag)
        tagText = ""
    }
}

#Preview {
    TagListView()
}
