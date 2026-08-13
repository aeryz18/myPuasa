//
//  MissedFastItem.swift
//  myPuasa
//

import Foundation

struct MissedFastItem: Identifiable, Equatable, Codable {
    var id: UUID
    var dateString: String
    var note: String?
    var isCompleted: Bool
    
    init(id: UUID = UUID(), dateString: String, note: String? = nil, isCompleted: Bool = false) {
        self.id = id
        self.dateString = dateString
        self.note = note
        self.isCompleted = isCompleted
    }
    
    /// Returns the 4-digit year parsed from dateString or note (e.g. 2023 from "Ramadan 1445 (2023)")
    var detectedYear: Int {
        let searchString = "\(dateString) \(note ?? "")"
        
        if let regex = try? NSRegularExpression(pattern: "\\b(20\\d{2})\\b"),
           let match = regex.firstMatch(in: searchString, options: [], range: NSRange(location: 0, length: searchString.utf16.count)),
           let range = Range(match.range(at: 1), in: searchString),
           let extractedYear = Int(searchString[range]) {
            return extractedYear
        }
        
        return 2025
    }
    
    /// Returns true if this missed fast belongs to a past year (2025 and prior) for Fidyah eligibility
    var isPastYearEligible: Bool {
        let currentYear = Calendar.current.component(.year, from: Date())
        return detectedYear < currentYear
    }
}
