import SwiftUI

struct CalendarView: View {
    
    // MARK: - State
    
    @State private var currentMonth = Date()
    
    @State private var startDate: Date? = nil
    @State private var endDate: Date? = nil
    
    @State private var selectingStartDate = true
    
    private let calendar = Calendar.current
    
    // MARK: - Body
    
    var body: some View {
        VStack(spacing: 20) {
            
            // MARK: Header
            
            HStack {
                Button {
                    changeMonth(by: -1)
                } label: {
                    Image(systemName: "chevron.left")
                        .font(.title3)
                }
                
                Spacer()
                
                Text(monthYearString(from: currentMonth))
                    .font(.system(size: 22, weight: .bold))
                
                Spacer()
                
                Button {
                    changeMonth(by: 1)
                } label: {
                    Image(systemName: "chevron.right")
                        .font(.title3)
                }
            }
            .padding(.horizontal)
            
            
            // MARK: Start / End Selection
            
            HStack(spacing: 12) {
                
                Button {
                    selectingStartDate = true
                } label: {
                    VStack(alignment: .leading) {
                        Text("Start Period")
                            .font(.caption)
                            .foregroundColor(.gray)
                        
                        Text(
                            startDate == nil
                            ? "Select date"
                            : formattedDate(startDate!)
                        )
                        .font(.system(size: 15, weight: .semibold))
                    }
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding()
                    .background(
                        selectingStartDate
                        ? Color.pink.opacity(0.15)
                        : Color.gray.opacity(0.1)
                    )
                    .cornerRadius(12)
                }
                
                
                Button {
                    selectingStartDate = false
                } label: {
                    VStack(alignment: .leading) {
                        Text("End Period")
                            .font(.caption)
                            .foregroundColor(.gray)
                        
                        Text(
                            endDate == nil
                            ? "Select date"
                            : formattedDate(endDate!)
                        )
                        .font(.system(size: 15, weight: .semibold))
                    }
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding()
                    .background(
                        !selectingStartDate
                        ? Color.pink.opacity(0.15)
                        : Color.gray.opacity(0.1)
                    )
                    .cornerRadius(12)
                }
            }
            .padding(.horizontal)
            
            
            // MARK: Calendar
            
            VStack(spacing: 10) {
                
                // Weekday names
                
                HStack {
                    ForEach(
                        calendar.shortWeekdaySymbols,
                        id: \.self
                    ) { day in
                        
                        Text(day)
                            .font(.system(size: 12, weight: .semibold))
                            .frame(maxWidth: .infinity)
                            .foregroundColor(.gray)
                    }
                }
                
                
                // Calendar dates
                
                let days = generateDays(for: currentMonth)
                
                LazyVGrid(
                    columns: Array(
                        repeating: GridItem(.flexible()),
                        count: 7
                    ),
                    spacing: 12
                ) {
                    
                    ForEach(days, id: \.self) { date in
                        
                        if let date = date {
                            
                            dayView(for: date)
                            
                        } else {
                            
                            Color.clear
                                .frame(height: 40)
                        }
                    }
                }
            }
            .padding(.horizontal)
            
            
            // MARK: Reset
            
            if startDate != nil || endDate != nil {
                
                Button {
                    resetPeriod()
                } label: {
                    Text("Reset")
                        .font(.system(size: 15, weight: .semibold))
                        .foregroundColor(.pink)
                }
            }
            
            
            // MARK: Period Information
            
            if let start = startDate,
               let end = endDate {
                
                let days = numberOfDays(
                    from: start,
                    to: end
                )
                
                VStack(spacing: 5) {
                    
                    Text("Period Recorded")
                        .font(.headline)
                    
                    Text("\(days) day\(days == 1 ? "" : "s")")
                        .font(.system(size: 28, weight: .bold))
                        .foregroundColor(.pink)
                }
                .padding()
            }
            
            Spacer()
        }
        .padding(.top)
    }
    
    
    // MARK: - Day View
    
    @ViewBuilder
    private func dayView(for date: Date) -> some View {
        
        let isPeriod = isPeriodDay(date)
        let isStart = isSameDay(date, startDate)
        let isEnd = isSameDay(date, endDate)
        let isToday = calendar.isDateInToday(date)
        
        Button {
            selectDate(date)
        } label: {
            
            ZStack {
                
                // Pink background for period
                
                if isPeriod {
                    Circle()
                        .fill(Color.pink.opacity(0.75))
                }
                
                // Today outline
                
                if isToday && !isPeriod {
                    Circle()
                        .stroke(Color.pink, lineWidth: 2)
                }
                
                // Date number
                
                Text(
                    "\(calendar.component(.day, from: date))"
                )
                .font(
                    .system(
                        size: 15,
                        weight: isPeriod ? .bold : .regular
                    )
                )
                .foregroundColor(
                    isPeriod ? .white : .primary
                )
            }
            .frame(width: 40, height: 40)
        }
        .overlay {
            
            // Start/end indicator
            
            if isStart || isEnd {
                Circle()
                    .stroke(Color.pink, lineWidth: 2)
                    .frame(width: 44, height: 44)
            }
        }
    }
    
    
    // MARK: - Select Date
    
    private func selectDate(_ date: Date) {
        
        let selectedDate = calendar.startOfDay(for: date)
        
        if selectingStartDate {
            
            // User is selecting start date
            
            startDate = selectedDate
            endDate = nil
            
            // Automatically switch to end-date selection
            
            selectingStartDate = false
            
        } else {
            
            // User is selecting end date
            
            if let start = startDate {
                
                if selectedDate < start {
                    
                    // If user accidentally selects
                    // a date before the start,
                    // make it the new start date.
                    
                    startDate = selectedDate
                    
                } else {
                    
                    endDate = selectedDate
                }
            }
        }
    }
    
    
    // MARK: - Check Period Date
    
    private func isPeriodDay(_ date: Date) -> Bool {
        
        guard let start = startDate else {
            return false
        }
        
        let day = calendar.startOfDay(for: date)
        
        // If there is no end date yet,
        // only highlight the start date.
        
        guard let end = endDate else {
            return calendar.isDate(day, inSameDayAs: start)
        }
        
        let normalizedEnd = calendar.startOfDay(for: end)
        
        return day >= start && day <= normalizedEnd
    }
    
    
    // MARK: - Same Day
    
    private func isSameDay(
        _ date: Date,
        _ otherDate: Date?
    ) -> Bool {
        
        guard let otherDate = otherDate else {
            return false
        }
        
        return calendar.isDate(
            date,
            inSameDayAs: otherDate
        )
    }
    
    
    // MARK: - Generate Calendar Days
    
    private func generateDays(
        for month: Date
    ) -> [Date?] {
        
        guard let monthInterval = calendar.dateInterval(
            of: .month,
            for: month
        ) else {
            return []
        }
        
        let firstDay = monthInterval.start
        
        let weekday = calendar.component(
            .weekday,
            from: firstDay
        )
        
        // Sunday = 1
        let leadingEmptyDays = weekday - 1
        
        let numberOfDays = calendar.range(
            of: .day,
            in: .month,
            for: firstDay
        )!.count
        
        var days: [Date?] = []
        
        // Empty spaces before the first day
        
        for _ in 0..<leadingEmptyDays {
            days.append(nil)
        }
        
        // Actual dates
        
        for day in 1...numberOfDays {
            
            if let date = calendar.date(
                bySetting: .day,
                value: day,
                of: firstDay
            ) {
                
                days.append(date)
            }
        }
        
        return days
    }
    
    
    // MARK: - Change Month
    
    private func changeMonth(by value: Int) {
        
        if let newMonth = calendar.date(
            byAdding: .month,
            value: value,
            to: currentMonth
        ) {
            currentMonth = newMonth
        }
    }
    
    
    // MARK: - Month / Year
    
    private func monthYearString(
        from date: Date
    ) -> String {
        
        let formatter = DateFormatter()
        formatter.dateFormat = "MMMM yyyy"
        
        return formatter.string(from: date)
    }
    
    
    // MARK: - Date Formatting
    
    private func formattedDate(
        _ date: Date
    ) -> String {
        
        let formatter = DateFormatter()
        formatter.dateFormat = "dd MMM yyyy"
        
        return formatter.string(from: date)
    }
    
    
    // MARK: - Number of Period Days
    
    private func numberOfDays(
        from start: Date,
        to end: Date
    ) -> Int {
        
        let components = calendar.dateComponents(
            [.day],
            from: start,
            to: end
        )
        
        return (components.day ?? 0) + 1
    }
    
    
    // MARK: - Reset
    
    private func resetPeriod() {
        
        startDate = nil
        endDate = nil
        selectingStartDate = true
    }
}


// MARK: - Preview

#Preview {
    CalendarView()
}
