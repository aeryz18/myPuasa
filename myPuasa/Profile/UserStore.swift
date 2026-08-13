//
//  UserStore.swift
//  myPuasa
//

import SwiftUI
import Combine

class UserStore: ObservableObject {
    static let shared = UserStore()
    private let key = "currentUserData"
    
    @Published var currentUser: User {
        didSet {
            saveToDefaults(currentUser)
        }
    }
    
    init() {
        if let data = UserDefaults.standard.data(forKey: key),
           let decoded = try? JSONDecoder().decode(User.self, from: data) {
            self.currentUser = decoded
        } else {
            self.currentUser = .demoFemale
        }
    }
    
    func saveToDefaults(_ user: User) {
        if let encoded = try? JSONEncoder().encode(user) {
            UserDefaults.standard.set(encoded, forKey: key)
        }
    }
    
    func switchUser(_ user: User) {
        self.currentUser = user
    }
    
    func updateProfile(name: String, email: String, gender: String, state: String) {
        currentUser.name = name
        currentUser.email = email
        currentUser.gender = gender
        currentUser.state = state
    }
}
