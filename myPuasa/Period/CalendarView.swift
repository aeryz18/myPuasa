import SwiftUI

struct CalendarView: View {
    
    // MARK: - State
    
    @State private var currentMonth = Date()
    
    // Temporary selection for the period currently being entered
    @State private var startDate: Date? = nil
    @State private var endDate: Date? = nil
    
    // Stores ALL period dates from ALL months
    @AppStorage("savedPeriodDates") private var savedPeriodDates: Data = Data()
    
    @State private var periodDates: Set<Date> = []
    
    @State private var selectingStartDate = true
    @State private var isTrackingActive = false
    @State private var isSaved = false
    
    private let calendar = Calendar.current
    private let healthManager = PeriodHealthManager()
    
    // MARK: - Health Calculations

    private var latestPeriodDays: Int {
        healthManager.latestPeriodDayCount(
            from: periodDates
        )
    }

    private var previousPeriodDays: Int {
        healthManager.previousPeriodDayCount(
            from: periodDates
        )
    }

    private var currentCycleLength: Int? {
        healthManager.currentCycleLength(
            from: periodDates
        )
    }

    private var previousCycleLength: Int? {
        healthManager.previousCycleLength(
            from: periodDates
        )
    }

    private var averageCycleLength: Int? {
        healthManager.averageCycleLength(
            from: periodDates
        )
    }

    private var targetPeriodDate: Date? {
        healthManager.targetPeriodDate(
            from: periodDates
        )
    }

    private var cyclePattern: String {
        healthManager.cyclePattern(
            from: periodDates
        )
    }

    private var cycleComparison: String {
        healthManager.cycleComparisonText(
            from: periodDates
        )
    }

    private var targetStatus: String {
        healthManager.targetStatus(
            from: periodDates
        )
    }

    private var periodStatus: String {
        healthManager.periodStatus(
            from: periodDates
        )
    }
    
    private var hasPeriodInCurrentMonth: Bool {
        periodDates.contains { date in
            calendar.isDate(date, equalTo: currentMonth, toGranularity: .month)
        }
    }
    
    // MARK: - Body
    init() {
        if let decoded = try? JSONDecoder().decode(
            [Date].self,
            from: UserDefaults.standard.data(
                forKey: "savedPeriodDates"
            ) ?? Data()
        ) {
            _periodDates = State(
                initialValue: Set(decoded)
            )
        }
    }
    var body: some View {
        NavigationStack
        {
            ScrollView {
                VStack(spacing: 20) {
                    
                    
                    
                    // MARK: - Header
                    
                    ZStack {
                        
                        // Centered month title + arrows
                        HStack(spacing: 14) {
                            
                            Button {
                                changeMonth(by: -1)
                            } label: {
                                Image(systemName: "chevron.left")
                                    .font(.system(size: 16, weight: .semibold))
                            }
                            
                            Text(monthYearString(from: currentMonth))
                                .font(.system(size: 22, weight: .bold))
                            
                            Button {
                                changeMonth(by: 1)
                            } label: {
                                Image(systemName: "chevron.right")
                                    .font(.system(size: 16, weight: .semibold))
                            }
                        }
                        
                        // Yearly calendar stays at the far right
                        HStack {
                            Spacer()
                            
                            NavigationLink {
                                YearlyCalendarView(
                                    periodDates: $periodDates
                                )
                            } label: {
                                Image(systemName: "26.calendar")
                                    .font(.system(size: 16, weight: .semibold))
                            }
                        }
                        .padding(.trailing, 20)
                    }
                    
                    
                    
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
                            spacing: 10
                        ) {
                            
                            ForEach(days.indices, id: \.self) { index in
                                
                                if let date = days[index] {
                                    
                                    dayView(for: date)
                                    
                                } else {
                                    
                                    Color.clear
                                        .frame(height: 40)
                                }
                            }
                        }
                    }
                    .padding(.horizontal)
                    
                    
                    // MARK: Track Period, Reset, Save & Edit Actions
                    
                    if isTrackingActive || startDate != nil {
                        // STATE 2: Selecting / Editing Dates -> Show Reset & Save Buttons
                        HStack(spacing: 16) {
                            Button {
                                withAnimation(.easeInOut(duration: 0.25)) {
                                    resetPeriod()
                                    isTrackingActive = false
                                }
                            } label: {
                                HStack(spacing: 6) {
                                    Image(systemName: "arrow.counterclockwise")
                                        .font(.subheadline)
                                    Text("Reset")
                                        .font(.system(size: 15, weight: .semibold))
                                }
                                .foregroundColor(.pink)
                                .padding(.horizontal, 16)
                                .padding(.vertical, 10)
                                .background(Color.pink.opacity(0.12))
                                .clipShape(Capsule())
                            }
                            
                            Button {
                                withAnimation(.easeInOut(duration: 0.25)) {
                                    if let start = startDate {
                                        let end = endDate ?? start
                                        if start <= end {
                                            savePeriod(from: start, to: end)
                                        } else {
                                            savePeriod(from: end, to: start)
                                        }
                                        startDate = nil
                                        endDate = nil
                                        selectingStartDate = true
                                    } else {
                                        savePeriodDates()
                                    }
                                    isTrackingActive = false
                                }
                            } label: {
                                HStack(spacing: 6) {
                                    Image(systemName: "checkmark.circle.fill")
                                        .font(.subheadline)
                                    Text("Save")
                                        .font(.system(size: 15, weight: .bold))
                                }
                                .foregroundColor(.white)
                                .padding(.horizontal, 22)
                                .padding(.vertical, 10)
                                .background(Color(red: 123 / 255, green: 45 / 255, blue: 63 / 255))
                                .clipShape(Capsule())
                                .shadow(color: Color(red: 123 / 255, green: 45 / 255, blue: 63 / 255).opacity(0.3), radius: 6, x: 0, y: 3)
                            }
                        }
                        .transition(.opacity.combined(with: .scale))
                    } else if hasPeriodInCurrentMonth {
                        // STATE 3: Period Record Exists in Current Month -> Show Edit Period Button
                        Button {
                            withAnimation(.easeInOut(duration: 0.25)) {
                                isTrackingActive = true
                            }
                        } label: {
                            HStack(spacing: 6) {
                                Image(systemName: "square.and.pencil")
                                    .font(.subheadline)
                                Text("Edit Period")
                                    .font(.system(size: 15, weight: .bold))
                            }
                            .foregroundColor(Color(red: 123 / 255, green: 45 / 255, blue: 63 / 255))
                            .padding(.horizontal, 22)
                            .padding(.vertical, 10)
                            .background(Color(red: 123 / 255, green: 45 / 255, blue: 63 / 255).opacity(0.12))
                            .clipShape(Capsule())
                        }
                        .transition(.opacity.combined(with: .scale))
                    } else {
                        // STATE 1: No Period Record -> Show Track Period Button
                        Button {
                            withAnimation(.easeInOut(duration: 0.25)) {
                                isTrackingActive = true
                            }
                        } label: {
                            HStack(spacing: 8) {
                                Image(systemName: "drop.fill")
                                    .font(.subheadline)
                                Text("Track Period")
                                    .font(.system(size: 15, weight: .bold))
                            }
                            .foregroundColor(.white)
                            .padding(.horizontal, 24)
                            .padding(.vertical, 12)
                            .background(Color(red: 123 / 255, green: 45 / 255, blue: 63 / 255))
                            .clipShape(Capsule())
                            .shadow(color: Color(red: 123 / 255, green: 45 / 255, blue: 63 / 255).opacity(0.3), radius: 6, x: 0, y: 3)
                        }
                        .transition(.opacity.combined(with: .scale))
                    }
                    
                    
                    // MARK: Period Information
                    
                    // MARK: - Period Information
                    
                    let currentMonthPeriodDays = periodDates.filter { date in
                        calendar.isDate(
                            date,
                            equalTo: currentMonth,
                            toGranularity: .month
                        )
                    }
                    
                    VStack(spacing: 16) {
                        
                        VStack(spacing: 5) {
                            
                            Text("Period Recorded")
                                .font(.headline)
                            
                            if currentMonthPeriodDays.isEmpty {
                                
                                Text("No period recorded")
                                    .font(.system(size: 18, weight: .semibold))
                                    .foregroundColor(.gray)
                                
                            } else {
                                
                                Text("\(currentMonthPeriodDays.count) day\(currentMonthPeriodDays.count == 1 ? "" : "s")")
                                    .font(.system(size: 28, weight: .bold))
                                    .foregroundColor(.pink)
                            }
                        }
                        
                        // MARK: - Health Summary
                        
                        HealthSummaryView(
                            currentCycleLength: currentCycleLength,
                            previousCycleLength: previousCycleLength,
                            currentPeriodDays: latestPeriodDays,
                            previousPeriodDays: previousPeriodDays,
                            cycleComparison: cycleComparison,
                            cyclePattern: cyclePattern
                        )
                    }
                    .padding(.horizontal)
                }
                .padding(.top)
                .offset(y: -0)
            }
        }
    }
    
    
    // MARK: - Day View
    
    @ViewBuilder
    private func dayView(for date: Date) -> some View {
        
        let normalizedDate = calendar.startOfDay(for: date)
        
        let isPeriod = periodDates.contains(normalizedDate)
        let isStart = isSameDay(date, startDate)
        let isEnd = isSameDay(date, endDate)
        let isToday = calendar.isDateInToday(date)
        
        // Check whether this date belongs to a future month
        let isFuture = isFutureMonth(date)
        
        Button {
            
            // Only allow editing if the month
            // is not in the future
            
            if !isFuture {
                isTrackingActive = true
                selectDate(date)
            }
            
        } label: {
            
            ZStack {
                
                // Pink background for saved period days
                
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
            
            // Make future dates look frozen
            .opacity(isFuture ? 0.4 : 1.0)
        }
        .disabled(isFuture)
        .overlay {
            
            // Start/end indicator for current selection
            
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
            
            // Start a NEW period
            
            startDate = selectedDate
            endDate = nil
            
            // Switch to end date selection
            
            selectingStartDate = false
            
        } else {
            
            // Selecting the end date
            
            guard let start = startDate else {
                return
            }
            
            if selectedDate < start {
                
                // If the selected end is before
                // the start, swap them
                
                savePeriod(
                    from: selectedDate,
                    to: start
                )
                
            } else {
                
                // Save the selected period
                
                savePeriod(
                    from: start,
                    to: selectedDate
                )
            }
            
            // IMPORTANT:
            // Clear the temporary selection after
            // the period has been saved.
            
            startDate = nil
            endDate = nil
            
            // Ready to select a completely
            // new period
            
            selectingStartDate = true
        }
    }
    
    // MARK: - Save Period
    
    private func savePeriod(
        from start: Date,
        to end: Date
    ) {
        
        var currentDate = start
        
        while currentDate <= end {
            
            periodDates.insert(
                calendar.startOfDay(
                    for: currentDate
                )
            )
            
            guard let nextDate = calendar.date(
                byAdding: .day,
                value: 1,
                to: currentDate
            ) else {
                break
            }
            
            currentDate = nextDate
        }
        
        savePeriodDates()
    }
    private func savePeriodDates() {
        
        let dates = Array(periodDates)
        
        if let encoded = try? JSONEncoder().encode(dates) {
            
            UserDefaults.standard.set(
                encoded,
                forKey: "savedPeriodDates"
            )
        }
    }
    
    
    // MARK: - Check Period Date
    
    private func isPeriodDay(_ date: Date) -> Bool {
        
        let normalizedDate = calendar.startOfDay(for: date)
        
        return periodDates.contains(normalizedDate)
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
        
        // Empty spaces before first day
        
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
    
    // MARK: - Check if Month is Future
    
    private func isFutureMonth(_ date: Date) -> Bool {
        
        let today = Date()
        
        let currentYear = calendar.component(
            .year,
            from: today
        )
        
        let currentMonth = calendar.component(
            .month,
            from: today
        )
        
        let selectedYear = calendar.component(
            .year,
            from: date
        )
        
        let selectedMonth = calendar.component(
            .month,
            from: date
        )
        
        // Future year
        if selectedYear > currentYear {
            return true
        }
        
        // Same year, future month
        if selectedYear == currentYear &&
            selectedMonth > currentMonth {
            return true
        }
        
        return false
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
    
    
    // MARK: - Reset
    
    private func resetPeriod() {
        
        periodDates.removeAll()
        
        startDate = nil
        endDate = nil
        selectingStartDate = true
        
        UserDefaults.standard.removeObject (
            forKey: "savedPeriodDates"
        )
    }
}
    
    // MARK: - Preview
    
    #Preview {
        CalendarView()
    }
    

