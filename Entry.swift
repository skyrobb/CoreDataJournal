//
//  Entry.swift
//  CoreDataJournal
//
//  Created by Skyler Robbins on 2/1/25.
//
//

import Foundation
import SwiftData


@Model public class Entry {
    var body: String
    var createdAt: Date
    public var id: String
    @Attribute(.externalStorage) var imageData: Data?
    var title: String
    var journal: Journal?
    
    public init(journal: Journal, title: String, body: String, imageData: Data?) {
        self.id = UUID().uuidString
        self.createdAt = Date()
        self.title = title
        self.body = body
        self.imageData = imageData
        self.journal = journal
    }
    
}
