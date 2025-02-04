//
//  CoreDataJournalApp.swift
//  CoreDataJournal
//
//  Created by Skyler Robbins on 1/30/25.
//

import SwiftUI
import SwiftData

@main
struct CoreDataJournalApp: App {
    var sharedModelContainer: ModelContainer = {
        let schema = Schema([
            Journal.self,
            Entry.self
        ])
        let modelConfiguration = ModelConfiguration(schema: schema, isStoredInMemoryOnly: false)
        
        do {
            return try ModelContainer(for: schema, configurations: [modelConfiguration])
        } catch {
            fatalError("Could not create ModelContainer: \(error)")
        }
    }()
    var body: some Scene {
        WindowGroup {
            JournalsView().modelContext(sharedModelContainer.mainContext)
        }
    }
}
