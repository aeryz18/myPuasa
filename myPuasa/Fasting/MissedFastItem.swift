//
//  MissedFastItem.swift
//  myPuasa
//

import Foundation

struct MissedFastItem: Identifiable, Equatable {
    let id: UUID
    var dateString: String
    var note: String?
    var isCompleted: Bool
    
    init(id: UUID = UUID(), dateString: String, note: String? = nil, isCompleted: Bool = false) {
        self.id = id
        self.dateString = dateString
        self.note = note
        self.isCompleted = isCompleted
    }
}
