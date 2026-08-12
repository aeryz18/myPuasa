//
//  FastingStore.swift
//  myPuasa
//

import SwiftUI
import Combine

class FastingStore: ObservableObject {
    static let shared = FastingStore()
    
    @Published var missedFasts: [MissedFastItem] = [
        MissedFastItem(dateString: "2 Jan 2025", note: "Ramadan 1446", isCompleted: true),
        MissedFastItem(dateString: "2 Feb 2025", note: "Ramadan 1446", isCompleted: true),
        MissedFastItem(dateString: "2 Mac 2025", note: "Ramadan 1446", isCompleted: false)
    ]
    
    var completedCount: Int {
        missedFasts.filter { $0.isCompleted }.count
    }
    
    var totalCount: Int {
        missedFasts.count
    }
    
    var progressRatio: Double {
        guard totalCount > 0 else { return 0 }
        return Double(completedCount) / Double(totalCount)
    }
    
    func addMissedFasts(count: Int, ramadan: String, note: String) {
        for i in 1...max(1, count) {
            let item = MissedFastItem(
                dateString: count > 1 ? "\(ramadan) (Fast #\(i))" : ramadan,
                note: note.isEmpty ? nil : note,
                isCompleted: false
            )
            missedFasts.append(item)
        }
    }
    
    func toggleFastCompletion(id: UUID) -> Bool {
        if let index = missedFasts.firstIndex(where: { $0.id == id }) {
            missedFasts[index].isCompleted.toggle()
            return missedFasts[index].isCompleted
        }
        return false
    }
}
