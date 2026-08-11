//
//  YearlyCalendarView.swift
//  myPuasa
//
//  Created by STDCX_MACBOOK PRO 50 on 11/08/2026.
//

import SwiftUI

struct YearlyCalendarView: View {
    
    // MARK: - State
    
    @State private var selectedYear: Int = Calendar.current.component(
        .year,
        from: Date()
    )
    
    private let calendar = Calendar.current
    
    // Temporary sample period dates
    // Later we can connect this to your CalendarView's
    // actual periodDates.
    @Binding var periodDates: Set<Date>
    
    // MARK: - Body
    
    var body: some View {
        VStack(spacing: 0) {
            
            // MARK: Year Header
            
            // MARK: - Year Header

            ZStack {
                
                // Centered year navigation
                
                HStack(spacing: 18) {
                    
                    Button {
                        changeYear(by: -1)
                    } label: {
                        Image(systemName: "chevron.left")
                            .font(
                                .system(
                                    size: 16,
                                    weight: .semibold
                                )
                            )
                    }
                    
                    Text("\(selectedYear)")
                        .font(
                            .system(
                                size: 24,
                                weight: .bold
                            )
                        )
                    
                    Button {
                        changeYear(by: 1)
                    } label: {
                        Image(systemName: "chevron.right")
                            .font(
                                .system(
                                    size: 16,
                                    weight: .semibold
                                )
                            )
                    }
                }
            }
            .frame(maxWidth: .infinity)
            .padding(.vertical, 15)
            
            
            // MARK: Months
            
            ScrollView(.vertical, showsIndicators: false) {
                
                LazyVGrid(
                    columns: [
                        GridItem(.flexible(), spacing: 14),
                        GridItem(.flexible(), spacing: 14)
                    ],
                    spacing: 20
                ) {
                    
                    ForEach(1...12, id: \.self) { month in
                        
                        miniMonthView(
                            month: month,
                            year: selectedYear
                        )
                    }
                }
                .padding(.horizontal)
                .padding(.bottom, 20)
            }
        }
    }
    
    
    // MARK: - Mini Month
    
    private func miniMonthView(
        month: Int,
        year: Int
    ) -> some View {
        
        let monthDate = makeDate(
            year: year,
            month: month
        )
        
        return VStack(spacing: 8) {
            
            // Month name
            
            Text(
                monthName(from: monthDate)
            )
            .font(
                .system(
                    size: 15,
                    weight: .bold
                )
            )
            
            
            // Weekday names
            
            HStack(spacing: 0) {
                
                ForEach(
                    calendar.shortWeekdaySymbols,
                    id: \.self
                ) { day in
                    
                    Text(
                        String(day.prefix(1))
                    )
                    .font(
                        .system(
                            size: 8,
                            weight: .semibold
                        )
                    )
                    .foregroundColor(.gray)
                    .frame(
                        maxWidth: .infinity
                    )
                }
            }
            
            
            // Dates
            
            let days = generateDays(
                for: monthDate
            )
            
            LazyVGrid(
                columns: Array(
                    repeating: GridItem(
                        .flexible(),
                        spacing: 0
                    ),
                    count: 7
                ),
                spacing: 5
            ) {
                
                ForEach(
                    days.indices,
                    id: \.self
                ) { index in
                    
                    if let date = days[index] {
                        
                        miniDayView(
                            date: date
                        )
                        
                    } else {
                        
                        Color.clear
                            .frame(height: 22)
                    }
                }
            }
        }
        .padding(10)
        .frame(height: 220)
        .background(
            Color.gray.opacity(0.06)
        )
        .cornerRadius(14)
    }
    
    // MARK: - Mini Day

    private func miniDayView(
        date: Date
    ) -> some View {
        
        let normalizedDate =
            calendar.startOfDay(
                for: date
            )
        
        let isPeriod =
            periodDates.contains(
                normalizedDate
            )
        
        return ZStack {
            
            if isPeriod {
                
                Circle()
                    .fill(
                        Color.pink.opacity(0.75)
                    )
            }
            
            Text(
                "\(calendar.component(.day, from: date))"
            )
            .font(
                .system(
                    size: 9,
                    weight: isPeriod ? .bold : .regular
                )
            )
            .foregroundColor(
                isPeriod
                ? .white
                : .primary
            )
        }
        .frame(
            width: 22,
            height: 22
        )
    }
    
    
   
    
    
    // MARK: - Generate Days
    
    private func generateDays(
        for month: Date
    ) -> [Date?] {
        
        guard let monthInterval =
                calendar.dateInterval(
                    of: .month,
                    for: month
                )
        else {
            return []
        }
        
        let firstDay =
            monthInterval.start
        
        let weekday =
            calendar.component(
                .weekday,
                from: firstDay
            )
        
        // Sunday = 1
        
        let leadingEmptyDays =
            weekday - 1
        
        let numberOfDays =
            calendar.range(
                of: .day,
                in: .month,
                for: firstDay
            )!.count
        
        var days: [Date?] = []
        
        // Empty spaces
        
        for _ in 0..<leadingEmptyDays {
            days.append(nil)
        }
        
        // Actual dates
        
        for day in 1...numberOfDays {
            
            if let date =
                calendar.date(
                    bySetting: .day,
                    value: day,
                    of: firstDay
                ) {
                
                days.append(date)
            }
        }
        
        return days
    }
    
    
    // MARK: - Create Date
    
    private func makeDate(
        year: Int,
        month: Int
    ) -> Date {
        
        calendar.date(
            from: DateComponents(
                year: year,
                month: month,
                day: 1
            )
        )!
    }
    
    
    // MARK: - Month Name
    
    private func monthName(
        from date: Date
    ) -> String {
        
        let formatter =
            DateFormatter()
        
        formatter.dateFormat = "MMMM"
        
        return formatter.string(
            from: date
        )
    }
    
    
    // MARK: - Change Year
    
    private func changeYear(
        by value: Int
    ) {
        
        selectedYear += value
    }
}


// MARK: - Preview

#Preview {
    
    YearlyCalendarView(
        periodDates: .constant([])
    )
}
