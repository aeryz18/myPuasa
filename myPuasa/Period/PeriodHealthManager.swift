//
//  PeriodHealthManager.swift
//  myPuasa
//
//  Created by STDCX_MACBOOK PRO 50 on 12/08/2026.
//

import Foundation

struct PeriodHealthManager {
    
    private let calendar = Calendar.current
    
    // MARK: - Period Groups
    
    // Groups consecutive dates into one period.
    //
    // Example:
    // 1 Aug, 2 Aug, 3 Aug, 4 Aug
    // = one period lasting 4 days
    
    func periodGroups(
        from periodDates: Set<Date>
    ) -> [[Date]] {
        
        let dates = periodDates
            .map {
                calendar.startOfDay(for: $0)
            }
            .sorted()
        
        guard !dates.isEmpty else {
            return []
        }
        
        var groups: [[Date]] = []
        var currentGroup: [Date] = [dates[0]]
        
        if dates.count > 1 {
            
            for index in 1..<dates.count {
                
                let previousDate = dates[index - 1]
                let currentDate = dates[index]
                
                let difference = calendar.dateComponents(
                    [.day],
                    from: previousDate,
                    to: currentDate
                ).day ?? 0
                
                if difference == 1 {
                    
                    // Consecutive date = same period
                    currentGroup.append(currentDate)
                    
                } else {
                    
                    // Gap = new period
                    groups.append(currentGroup)
                    currentGroup = [currentDate]
                }
            }
        }
        
        groups.append(currentGroup)
        
        return groups
    }
    
    
    // MARK: - Period Start Dates
    
    func periodStartDates(
        from periodDates: Set<Date>
    ) -> [Date] {
        
        return periodGroups(
            from: periodDates
        ).compactMap {
            $0.first
        }
    }
    
    
    // MARK: - Latest Period
    
    func latestPeriod(
        from periodDates: Set<Date>
    ) -> [Date] {
        
        return periodGroups(
            from: periodDates
        ).last ?? []
    }
    
    
    // MARK: - Period Days
    
    func latestPeriodDayCount(
        from periodDates: Set<Date>
    ) -> Int {
        
        return latestPeriod(
            from: periodDates
        ).count
    }
    
    
    // MARK: - Previous Period Day Count
    
    func previousPeriodDayCount(
        from periodDates: Set<Date>
    ) -> Int {
        
        let groups = periodGroups(
            from: periodDates
        )
        
        guard groups.count >= 2 else {
            return 0
        }
        
        return groups[groups.count - 2].count
    }
    
    
    // MARK: - Cycle Lengths
    
    func cycleLengths(
        from periodDates: Set<Date>
    ) -> [Int] {
        
        let starts = periodStartDates(
            from: periodDates
        )
        
        guard starts.count >= 2 else {
            return []
        }
        
        var lengths: [Int] = []
        
        for index in 1..<starts.count {
            
            let previousStart = starts[index - 1]
            let currentStart = starts[index]
            
            let days = calendar.dateComponents(
                [.day],
                from: previousStart,
                to: currentStart
            ).day ?? 0
            
            if days > 0 {
                lengths.append(days)
            }
        }
        
        return lengths
    }
    
    
    // MARK: - Previous Cycle Length
    
    func previousCycleLength(
        from periodDates: Set<Date>
    ) -> Int? {
        
        let lengths = cycleLengths(
            from: periodDates
        )
        
        return lengths.last
    }
    
    
    // MARK: - Average Cycle Length
    
    func averageCycleLength(
        from periodDates: Set<Date>
    ) -> Int? {
        
        let lengths = cycleLengths(
            from: periodDates
        )
        
        guard !lengths.isEmpty else {
            return nil
        }
        
        let total = lengths.reduce(
            0,
            +
        )
        
        return Int(
            round(
                Double(total) /
                Double(lengths.count)
            )
        )
    }
    
    
    // MARK: - Current Cycle Length
    
    func currentCycleLength(
        from periodDates: Set<Date>,
        today: Date = Date()
    ) -> Int? {
        
        guard let latestStart = periodStartDates(
            from: periodDates
        ).last else {
            return nil
        }
        
        let today = calendar.startOfDay(
            for: today
        )
        
        let days = calendar.dateComponents(
            [.day],
            from: latestStart,
            to: today
        ).day ?? 0
        
        return max(days, 0)
    }
    
    
    // MARK: - Cycle Difference
    
    func cycleDifference(
        from periodDates: Set<Date>
    ) -> Int? {
        
        guard let current = currentCycleLength(
            from: periodDates
        ),
              let previous = previousCycleLength(
                from: periodDates
              ) else {
            return nil
        }
        
        return current - previous
    }
    
    
    // MARK: - Cycle Comparison Text
    
    func cycleComparisonText(
        from periodDates: Set<Date>
    ) -> String {
        
        guard let current = currentCycleLength(
            from: periodDates
        ),
              let previous = previousCycleLength(
                from: periodDates
              ) else {
            
            return "Not enough data to compare cycles."
        }
        
        let difference = current - previous
        
        if difference == 0 {
            
            return "The number of days in this cycle is the same as the last time."
            
        } else if difference == 1 {
            
            return "The number of days in this cycle is 1 day more than the last time."
            
        } else if difference == -1 {
            
            return "The number of days in this cycle is 1 day less than the last time."
            
        } else if difference > 0 {
            
            return "The number of days in this cycle is \(difference) days more than the last time."
            
        } else {
            
            return "The number of days in this cycle is \(abs(difference)) days less than the last time."
        }
    }
    
    
    // MARK: - Target Period Date
    
    func targetPeriodDate(
        from periodDates: Set<Date>
    ) -> Date? {
        
        guard let latestStart = periodStartDates(
            from: periodDates
        ).last else {
            return nil
        }
        
        guard let averageCycle = averageCycleLength(
            from: periodDates
        ) else {
            return nil
        }
        
        return calendar.date(
            byAdding: .day,
            value: averageCycle,
            to: latestStart
        )
    }
    
    
    // MARK: - Target Status
    
    func targetStatus(
        from periodDates: Set<Date>,
        today: Date = Date()
    ) -> String {
        
        guard let targetDate = targetPeriodDate(
            from: periodDates
        ) else {
            return "Not enough data"
        }
        
        let today = calendar.startOfDay(
            for: today
        )
        
        let target = calendar.startOfDay(
            for: targetDate
        )
        
        let difference = calendar.dateComponents(
            [.day],
            from: today,
            to: target
        ).day ?? 0
        
        if difference > 0 {
            
            return "Expected in \(difference) days"
            
        } else if difference == 0 {
            
            return "Expected today"
            
        } else {
            
            return "\(abs(difference)) days past estimated date"
        }
    }
    
    
    // MARK: - Period Status
    
    func periodStatus(
        from periodDates: Set<Date>,
        today: Date = Date()
    ) -> String {
        
        guard let targetDate = targetPeriodDate(
            from: periodDates
        ) else {
            return "Not enough data"
        }
        
        let today = calendar.startOfDay(
            for: today
        )
        
        let target = calendar.startOfDay(
            for: targetDate
        )
        
        let difference = calendar.dateComponents(
            [.day],
            from: target,
            to: today
        ).day ?? 0
        
        if difference > 0 {
            
            return "Menstruation \(difference) days late"
            
        } else if difference == 0 {
            
            return "Your period is expected today"
            
        } else {
            
            return "Your next period is expected in \(abs(difference)) days"
        }
    }
    
    
    // MARK: - Cycle Pattern
    
    func cyclePattern(
        from periodDates: Set<Date>
    ) -> String {
        
        let lengths = cycleLengths(
            from: periodDates
        )
        
        guard lengths.count >= 2 else {
            return "Not enough data"
        }
        
        let average = Double(
            averageCycleLength(
                from: periodDates
            ) ?? 0
        )
        
        let consistent = lengths.allSatisfy {
            abs(
                Double($0) - average
            ) <= 3
        }
        
        return consistent
        ? "Consistent"
        : "Variable"
    }
    
    
    // MARK: - Health Conclusion
    
    func healthConclusion(
        from periodDates: Set<Date>
    ) -> String {
        
        guard !periodDates.isEmpty else {
            return "Record your period to begin tracking your cycle."
        }
        
        let starts = periodStartDates(
            from: periodDates
        )
        
        guard starts.count >= 2 else {
            return "Record another period to calculate your cycle."
        }
        
        let pattern = cyclePattern(
            from: periodDates
        )
        
        if pattern == "Consistent" {
            
            return "Your current cycle is consistent with your previous records."
            
        } else {
            
            return "Your cycle length varies compared with your previous records."
        }
    }
}


