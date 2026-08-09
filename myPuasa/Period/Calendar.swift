//
//  CalendarView.swift
//  MyTeamApp
//
//  Created by STDCX_MACBOOK PRO 50 on 09/08/2026.
//

import SwiftUI

struct CalendarView: View {
    
    @State private var startDate: Date? = nil
    @State private var endDate: Date? = nil
    @State private var isTracking = false
    @State private var currentDate = Date()
    
    var body: some View {
        VStack {
            
            // Month header
            HStack {
                Button {
                    changeMonth(by: -1)
                } label: {
                    Image(systemName: "chevron.left")
                }
                
                Spacer()
                
                Text(monthYear)
                    .font(.title2)
                    .fontWeight(.bold)
                
                Spacer()
                
                Button {
                    changeMonth(by: 1)
                } label: {
                    Image(systemName: "chevron.right")
                }
            }
            .padding(.horizontal)
            
            // Days of week
            HStack {
                ForEach(["Sun", "Mon", "Tue", "Wed", "Thu", "Fri", "Sat"], id: \.self) { day in
                    Text(day)
                        .font(.caption)
                        .fontWeight(.bold)
                        .frame(maxWidth: .infinity)
                }
            }
            .padding(.top)
            
            // Calendar
            let days = generateDays()
            
            LazyVGrid(
                columns: Array(repeating: GridItem(.flexible()), count: 7)
            ) {
                ForEach(days, id: \.self) { date in
                    
                    if let date = date {
                        Text("\(dayNumber(date))")
                            .frame(width: 40, height: 40)
                            .background(
                                isToday(date)
                                ? Color.pink
                                : Color.clear
                            )
                            .foregroundColor(
                                isToday(date)
                                ? .white
                                : .primary
                            )
                            .clipShape(Circle())
                    } else {
                        Text("")
                            .frame(width: 40, height: 40)
                        
                    }
                }
            }
            .padding()
            
            Spacer()
            Button(isTracking ? "Stop Period" : "Start Period") {
                
                if isTracking {
                    endDate = Date()
                    isTracking = false
                } else {
                    startDate = Date()
                    endDate = nil
                    isTracking = true
                }
            }
        }
    }
    
    // MARK: - Month & Year
    
    var monthYear: String {
        let formatter = DateFormatter()
        formatter.dateFormat = "MMMM yyyy"
        return formatter.string(from: currentDate)
    }
    
    // MARK: - Generate Calendar Days
    
    func generateDays() -> [Date?]
    {
        
        let calendar = Calendar.current
        
        guard let monthInterval = calendar.dateInterval(
            of: .month,
            for: currentDate
        ) else {
            return []
        }
        
        let firstDay = monthInterval.start
        
        let weekday = calendar.component(
            .weekday,
            from: firstDay
        )
        
        let numberOfDays = calendar.range(
            of: .day,
            in: .month,
            for: currentDate
        )!.count
        
        var days: [Date?] = []
        
        // Empty spaces before first day
        for _ in 1..<weekday {
            days.append(nil)
        }
        
        // Actual days
        for day in 1...numberOfDays {
            if let date = calendar.date(
                bySetting: .day,
                value: day,
                of: currentDate
            ) {
                days.append(date)
            }
        }
        
        return days
    }
    func isPeriodDay(_ date: Date) -> Bool {
        
        guard let startDate = startDate else {
            return false
        }
        
        if isTracking {
            return date >= startDate
        }
        
        guard let endDate = endDate else {
            return false
        }
        
        return date >= startDate && date <= endDate
    }
    
    // MARK: - Day Number
    
    func dayNumber(_ date: Date) -> Int {
        Calendar.current.component(.day, from: date)
    }
    
    // MARK: - Today
    
    func isToday(_ date: Date) -> Bool {
        Calendar.current.isDateInToday(date)
    }
    
    // MARK: - Change Month
    
    func changeMonth(by value: Int) {
        if let newDate = Calendar.current.date(
            byAdding: .month,
            value: value,
            to: currentDate
        ) {
            currentDate = newDate
        }
    }
}



#Preview {
    CalendarView()
}
