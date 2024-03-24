//
//  ContentView.swift
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

struct ContentView: View {
    
    @State private var noteSearchText: String = ""
    
    @State private var noteSortBy = NoteSortBy.timeStamp
    @State private var noteOrderBy = OrderBy.descending
    
    @State private var tagSearchText = ""
    @State private var tagOrderBy = OrderBy.ascending
    
    var noteListQuery: Query<Note, [Note]> {
        let sortOrder: SortOrder = noteOrderBy == .ascending ? .forward : .reverse
        var predicate: Predicate<Note>?
        if !noteSearchText.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty {
            predicate = .init(#Predicate { $0.content.contains(noteSearchText) })
        }
        if noteSortBy == .content {
            return Query(filter: predicate, sort: \.content, order: sortOrder)
        } else {
            return Query(filter: predicate, sort: \.timeStamp, order: sortOrder)
        }
    }
    
    var tagListQuery: Query<Tag, [Tag]> {
        let sortOrder: SortOrder = tagOrderBy == .ascending ? .forward : .reverse
        var predicate: Predicate<Tag>?
        if !tagSearchText.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty {
            predicate = .init(#Predicate { $0.name.contains(tagSearchText) })
        }
        return Query(filter: predicate, sort: \.name, order: sortOrder)
    }
    
    var body: some View {
        TabView {
            NavigationStack {
                NoteListView(_notes: noteListQuery)
                    .searchable(text: $noteSearchText, prompt: "Search")
                    .textInputAutocapitalization(.never)
                    .navigationTitle("Notes")
                    .toolbar {
                        
                        ToolbarItem(placement: .topBarLeading) {
                            Menu {
                                Picker("Sort by", selection: $noteSortBy) {
                                    ForEach(NoteSortBy.allCases) {
                                        Text($0.text).id($0)
                                    }
                                }
                            } label: {
                                Label(noteSortBy.text, systemImage: "line.horizontal.3.decrease.circle")
                            }
                        }
                        
                        ToolbarItem(placement: .topBarTrailing) {
                            Menu {
                                Picker("Order By", selection: $noteOrderBy) {
                                    ForEach(OrderBy.allCases) {
                                        Text($0.text).id($0)
                                    }
                                }
                            } label: {
                                Label(noteOrderBy.text, systemImage: "arrow.up.arrow.down")
                            }
                        }
                    }
                
            }
            .tabItem {
                Label("Notes", systemImage: "note")
            }
            
            NavigationStack {
                TagListView(_tags: tagListQuery)
                    .searchable(text: $tagSearchText, prompt: "Search")
                    .textInputAutocapitalization(.never)
                    .navigationTitle("Tags")
                    .toolbar {
                        
                        ToolbarItem(placement: .topBarTrailing) {
                            Menu {
                                Picker("Order By", selection: $tagOrderBy) {
                                    ForEach(OrderBy.allCases) {
                                        Text($0.text).id($0)
                                    }
                                }
                            } label: {
                                Label(tagOrderBy.text, systemImage: "arrow.up.arrow.down")
                            }
                        }
                    }
                
                
            }
            .tabItem {
                Label("Tags", systemImage: "tag")
            }
        }
    }
    
}

#Preview {
    ContentView()
}
