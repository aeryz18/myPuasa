//
//  User.swift
//  myPuasa
//

import Foundation

struct User: Identifiable, Codable, Equatable {
    var id: UUID = UUID()
    var name: String
    var phone: String
    var email: String
    var password: String
    var gender: String // "Female" or "Male"
    var state: String
    var partnerName: String?
    var partnerEmail: String?
    var partnerPhone: String?
    var hasPartner: Bool
    
    // Feature Arrays
    var missedFasts: [MissedFastItem]
    var periodDates: [Date]
    var fidyahRecords: [FidyahRecordItem]
    
    // Default Guest / Empty User
    static var guest: User {
        User(
            name: "",
            phone: "",
            email: "",
            password: "",
            gender: "Female",
            state: "Selangor",
            partnerName: nil,
            partnerEmail: nil,
            partnerPhone: nil,
            hasPartner: false,
            missedFasts: [],
            periodDates: [],
            fidyahRecords: []
        )
    }
    
    // Demo Profile 1: Female (Siti Nurul Balqis)
    static var demoFemale: User {
        let calendar = Calendar.current
        let today = calendar.startOfDay(for: Date())
        
        // Sample period dates (e.g. 5 days starting 10 days ago)
        let periodSampleDates: [Date] = (0..<5).compactMap { offset in
            calendar.date(byAdding: .day, value: -offset, to: today)
        }
        
        return User(
            name: "Siti Nurul Balqis",
            phone: "012-3456789",
            email: "balqis@gmail.com",
            password: "123",
            gender: "Female",
            state: "Selangor",
            partnerName: nil,
            partnerEmail: nil,
            partnerPhone: nil,
            hasPartner: false,
            missedFasts: [
                MissedFastItem(dateString: "2 Jan 2025", note: "Ramadan 1446", isCompleted: true),
                MissedFastItem(dateString: "2 Feb 2025", note: "Ramadan 1446", isCompleted: true),
                MissedFastItem(dateString: "2 Mac 2025", note: "Ramadan 1446", isCompleted: false)
            ],
            periodDates: periodSampleDates,
            fidyahRecords: [
                FidyahRecordItem(dateString: "25 May 2024", amount: 35.00, days: 10, paymentMethod: "Online Banking", stateName: "Selangor"),
                FidyahRecordItem(dateString: "12 May 2024", amount: 15.00, days: 5, paymentMethod: "TnG eWallet", stateName: "Wilayah Persekutuan")
            ]
        )
    }
    
    // Demo Profile 2: Male (Ahmad Razak)
    static var demoMale: User {
        return User(
            name: "Ahmad Razak",
            phone: "019-8765432",
            email: "ahmad@gmail.com",
            password: "123",
            gender: "Male",
            state: "Johor",
            partnerName: "Siti Nurul Balqis",
            partnerEmail: "balqis@gmail.com",
            partnerPhone: "012-3456789",
            hasPartner: false,
            missedFasts: [
                MissedFastItem(dateString: "15 Mar 2024", note: "Ramadan 1445", isCompleted: true)
            ],
            periodDates: [],
            fidyahRecords: [
                FidyahRecordItem(dateString: "10 Aug 2023", amount: 55.00, days: 15, paymentMethod: "QR DuitNow", stateName: "Johor")
            ]
        )
    }
}
