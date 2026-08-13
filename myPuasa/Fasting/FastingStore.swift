//
//  FastingStore.swift
//  myPuasa
//

import SwiftUI
import Combine

class FastingStore: ObservableObject {
    static let shared = FastingStore()
    
    @Published var missedFasts: [MissedFastItem] = []
    private var cancellables = Set<AnyCancellable>()
    
    init() {
        // Sync with active user's missedFasts
        UserStore.shared.$currentUser
            .map { $0.missedFasts }
            .assign(to: &$missedFasts)
    }
    
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
        var updated = UserStore.shared.currentUser.missedFasts
        for i in 1...max(1, count) {
            let item = MissedFastItem(
                dateString: count > 1 ? "\(ramadan) (Fast #\(i))" : ramadan,
                note: note.isEmpty ? nil : note,
                isCompleted: false
            )
            updated.append(item)
        }
        UserStore.shared.currentUser.missedFasts = updated
    }
    
    func toggleFastCompletion(id: UUID) -> Bool {
        var updated = UserStore.shared.currentUser.missedFasts
        if let index = updated.firstIndex(where: { $0.id == id }) {
            updated[index].isCompleted.toggle()
            let newValue = updated[index].isCompleted
            UserStore.shared.currentUser.missedFasts = updated
            return newValue
        }
        return false
    }
}
