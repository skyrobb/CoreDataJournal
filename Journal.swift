//
//  Journal.swift
//  CoreDataJournal
//
//  Created by Skyler Robbins on 2/1/25.
//
//

import Foundation
import SwiftData


@Model public class Journal {
    var colorHex: String?
    var createdAt: Date
    public var id: String
    var title: String
    @Relationship(deleteRule: .cascade, inverse: \Entry.journal) var entries = [Entry]()
    
    public init(title: String, colorHex: String?) {
        self.id = UUID().uuidString
        self.createdAt = Date()
        self.title = title
        self.colorHex = colorHex
    }
}
