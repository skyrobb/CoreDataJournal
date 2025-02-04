//
//  ContentView.swift
//  CoreDataJournal
//
//  Created by Skyler Robbins on 1/30/25.
//

import SwiftUI
import SwiftData

var relativeDateFormatter: RelativeDateTimeFormatter = {
    let formatter = RelativeDateTimeFormatter()
    formatter.dateTimeStyle = .numeric
    return formatter
}()

struct EntriesView: View {
    @Environment(\.managedObjectContext) private var viewContext
    @Environment(\.modelContext) var context

    @Query(sort: \Entry.createdAt) var entries: [Entry]

    @State private var showAddEditEntryView = false
    @State private var selectedEntry: Entry?
    var journal: Journal


    var body: some View {
        VStack {
            List {
                ForEach(journal.entries) { entry in
                    entryView(entry)
                        .onTapGesture {
                            self.selectedEntry = entry
                        }
                }
                .onDelete(perform: { indexSet in
                    delete(at: indexSet)
                })
            }
        }
        .navigationTitle(journal.title)
        .toolbar {
            ToolbarItem {
                Button(action: showNewEntryView) {
                    Label("Add Item", systemImage: "plus")
                }
            }
        }
        .sheet(isPresented: $showAddEditEntryView) {
            AddEditEntryView(journal: journal)
        }
        .sheet(item: $selectedEntry) { entry in
            AddEditEntryView(journal: journal, entry: entry)
        }
    }

    func entryView(_ entry: Entry) -> some View  {
        HStack {
            if let imageData = entry.imageData, let uiImage = UIImage(data: imageData) {
                Image(uiImage: uiImage)
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(maxHeight: 50)
            }

            VStack(alignment: .leading) {
                Text(entry.title)

                if let relativeString = relativeDateFormatter.string(for: entry.createdAt) {
                    Text(relativeString)
                }
            }

            Spacer()
        }
        .contentShape(Rectangle())
    }

}

extension EntriesView {

    func showNewEntryView() {
        showAddEditEntryView = true
    }

    func delete(at index: IndexSet) {
        index.forEach { i in
            let entry = journal.entries[i]
            context.delete(entry)
        }
    }

}
