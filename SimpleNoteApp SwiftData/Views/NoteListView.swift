//
//  NoteListView.swift
//  SimpleNoteApp SwiftData
//
//  Created by Etienne Grey on 3/24/24 @ 12:23 PM.
//  Copyright (c) 2024 Etienne Grey. All rights reserved.
//
//  Github: https://github.com/etiennegrey
//  BuyMeACoffee: https://buymeacoffee.com/etiennegrey
//


import SwiftUI
import SwiftData

struct NoteListView: View {
    
    @Environment(\.modelContext) private var context
    @Query(sort: \Note.timeStamp, order: .reverse) var notes: [Note]
    @Query(sort: \Tag.name, order: .forward) var tags: [Tag]

    @State private var noteText = ""

    var body: some View {
        List {
            
            Section {
                DisclosureGroup("Create A Note") {
                    TextField("Enter Text", text: $noteText, axis: .vertical)
                        .lineLimit(2...5)
                    
                    DisclosureGroup("Tag With") {
                        if tags.isEmpty {
                            Text("No tags created")
                                .foregroundStyle(.secondary)
                        } else {
                            ForEach(tags) { tag in
                                    
                                HStack {
                                    Text(tag.name)
                                    if tag.isChecked {
                                        Spacer()
                                        Image(systemName: "checkmark.circle")
                                            .symbolRenderingMode(.multicolor)
                                        
                                    }
                                }
                                .frame(maxWidth: .infinity, alignment: .leading)
                                .contentShape(Rectangle())
                                .onTapGesture {
                                    tag.isChecked.toggle()
                                }
                            }
                        }
                    }
                    
                    Button("Save") {
                        withAnimation {
                            createNote()
                        }
                    }
                    .disabled(noteText.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty)
                }
            }

            
            Section {
                if notes.isEmpty {
                    ContentUnavailableView("No notes created", systemImage: "note")
                } else {
                    ForEach(notes) { note in
                        
                        VStack(alignment: .leading) {
                            Text(note.content)
                            if let tags = note.tags {
                                if tags.count > 0 {
                                    Text("Tags: " + tags.map { $0.name }.joined(separator: ", "))
                                        .font(.caption)
                                }
                            }
                            Text(note.timeStamp, style: .time)
                                .font(.caption)
                                .foregroundStyle(.secondary)
                        }
                        .swipeActions {
                            Button(role: .destructive) {
                                    context.delete(note)
                            } label: {
                                Image(systemName: "trash.fill")
                            }
                        }
                    }
                }
            }
        }
    }
}

extension NoteListView {
    func createNote() {
        var tempTags: [Tag] = []

        tags.forEach { tag in
            if tag.isChecked {
                tempTags.append(tag)
                tag.isChecked = false
            }
        }
        
        let note = Note(id: UUID().uuidString, content: noteText, timeStamp: .now, tags: tempTags)
        context.insert(note)
        noteText = ""
        
        //MARK: context.save() is not needed as SwiftData is reactive
        do {
            try context.save()
        }
        catch {
            print("Error while creating note: \(error)")
        }
    }
}


#Preview {
    NoteListView()
}
