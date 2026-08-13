//
//  PartnerPeriodView.swift
//  myPuasa
//

import SwiftUI

struct PartnerPeriodView: View {
    @AppStorage("partnerName") private var partnerName: String = ""
    @AppStorage("partnerPhone") private var partnerPhone: String = ""
    @AppStorage("savedPeriodDates") private var savedPeriodDates: Data = Data()
    
    @State private var periodDates: Set<Date> = []
    @State private var currentMonth = Date()
    
    private let calendar = Calendar.current
    private let backgroundColor = Color(red: 250 / 255, green: 248 / 255, blue: 245 / 255)
    private let cardColor = Color(red: 237 / 255, green: 231 / 255, blue: 223 / 255)
    private let borderColor = Color(red: 221 / 255, green: 212 / 255, blue: 200 / 255)
    private let highlightColor = Color(red: 123 / 255, green: 45 / 255, blue: 63 / 255)
    private let weekdaySymbols = ["Sun", "Mon", "Tue", "Wed", "Thu", "Fri", "Sat"]
    
    var body: some View {
        ZStack {
            backgroundColor.ignoresSafeArea()
            
            ScrollView(showsIndicators: false) {
                VStack(spacing: 20) {
                    
                    // Partner Info Card
                    HStack(spacing: 14) {
                        ZStack {
                            Circle().fill(highlightColor.opacity(0.15)).frame(width: 52, height: 52)
                            Image(systemName: "person.fill").font(.title2).foregroundColor(highlightColor)
                        }
                        VStack(alignment: .leading, spacing: 2) {
                            Text(partnerName.isEmpty ? "Partner" : partnerName)
                                .font(.headline).fontWeight(.bold)
                            if !partnerPhone.isEmpty {
                                Text(partnerPhone).font(.caption).foregroundColor(.secondary)
                            }
                            Label("Read-only view", systemImage: "eye.fill")
                                .font(.caption2).foregroundColor(highlightColor)
                        }
                        Spacer()
                    }
                    .padding(16)
                    .background(cardColor)
                    .clipShape(RoundedRectangle(cornerRadius: 18))
                    .overlay(RoundedRectangle(cornerRadius: 18).stroke(borderColor, lineWidth: 1))
                    
                    // Calendar Card
                    VStack(spacing: 16) {
                        
                        // Month navigation
                        HStack {
                            Button {
                                withAnimation(.easeInOut(duration: 0.2)) {
                                    currentMonth = calendar.date(byAdding: .month, value: -1, to: currentMonth) ?? currentMonth
                                }
                            } label: {
                                Image(systemName: "chevron.left.circle.fill")
                                    .font(.title2).foregroundColor(highlightColor)
                            }
                            Spacer()
                            Text(currentMonth.formatted(.dateTime.month(.wide).year()))
                                .font(.headline).fontWeight(.bold)
                            Spacer()
                            Button {
                                withAnimation(.easeInOut(duration: 0.2)) {
                                    currentMonth = calendar.date(byAdding: .month, value: 1, to: currentMonth) ?? currentMonth
                                }
                            } label: {
                                Image(systemName: "chevron.right.circle.fill")
                                    .font(.title2).foregroundColor(highlightColor)
                            }
                        }
                        
                        // Weekday headers
                        HStack {
                            ForEach(weekdaySymbols, id: \.self) { day in
                                Text(day).font(.caption).fontWeight(.semibold)
                                    .foregroundColor(.secondary).frame(maxWidth: .infinity)
                            }
                        }
                        
                        // Calendar grid — read-only
                        let days = generateDays(for: currentMonth)
                        LazyVGrid(columns: Array(repeating: GridItem(.flexible()), count: 7), spacing: 10) {
                            ForEach(days.indices, id: \.self) { index in
                                if let date = days[index] {
                                    dayCell(for: date)
                                } else {
                                    Color.clear.frame(height: 40)
                                }
                            }
                        }
                    }
                    .padding(16)
                    .background(Color.white)
                    .clipShape(RoundedRectangle(cornerRadius: 18))
                    .overlay(RoundedRectangle(cornerRadius: 18).stroke(borderColor, lineWidth: 1))
                    
                    // Legend
                    HStack(spacing: 16) {
                        HStack(spacing: 6) {
                            Circle().fill(Color.pink.opacity(0.75)).frame(width: 12, height: 12)
                            Text("Period day").font(.caption).foregroundColor(.secondary)
                        }
                        HStack(spacing: 6) {
                            Circle().stroke(Color.pink, lineWidth: 2).frame(width: 12, height: 12)
                            Text("Today").font(.caption).foregroundColor(.secondary)
                        }
                        Spacer()
                    }
                    .padding(.horizontal, 4)
                    
                    // Empty state
                    if periodDates.isEmpty {
                        VStack(spacing: 10) {
                            Image(systemName: "calendar.badge.exclamationmark")
                                .font(.system(size: 36)).foregroundColor(.secondary.opacity(0.5))
                            Text("No period data yet")
                                .font(.subheadline).fontWeight(.semibold).foregroundColor(.secondary)
                            Text("Ask \(partnerName.isEmpty ? "your partner" : partnerName) to log in and enter her period data.")
                                .font(.caption).foregroundColor(.secondary).multilineTextAlignment(.center)
                        }
                        .padding(24)
                        .background(cardColor)
                        .clipShape(RoundedRectangle(cornerRadius: 18))
                    }
                }
                .padding(.horizontal, 18)
                .padding(.top, 12)
                .padding(.bottom, 32)
            }
        }
        .navigationTitle("\(partnerName.isEmpty ? "Partner" : partnerName)'s Period")
        .navigationBarTitleDisplayMode(.inline)
        .onAppear { loadDates() }
    }
    
    @ViewBuilder
    private func dayCell(for date: Date) -> some View {
        let normalizedDate = calendar.startOfDay(for: date)
        let isPeriod = periodDates.contains(normalizedDate)
        let isToday = calendar.isDateInToday(date)
        ZStack {
            if isPeriod { Circle().fill(Color.pink.opacity(0.75)) }
            if isToday && !isPeriod { Circle().stroke(Color.pink, lineWidth: 2) }
            Text("\(calendar.component(.day, from: date))")
                .font(.system(size: 15, weight: isPeriod ? .bold : .regular))
                .foregroundColor(isPeriod ? .white : .primary)
        }
        .frame(height: 40)
    }
    
    private func loadDates() {
        if let decoded = try? JSONDecoder().decode([Date].self, from: savedPeriodDates) {
            periodDates = Set(decoded)
        }
    }
    
    private func generateDays(for month: Date) -> [Date?] {
        guard let monthInterval = calendar.dateInterval(of: .month, for: month),
              let firstWeekday = calendar.dateComponents([.weekday], from: monthInterval.start).weekday
        else { return [] }
        var days: [Date?] = Array(repeating: nil, count: firstWeekday - 1)
        var current = monthInterval.start
        while current < monthInterval.end {
            days.append(current)
            guard let next = calendar.date(byAdding: .day, value: 1, to: current) else { break }
            current = next
        }
        return days
    }
}

#Preview {
    NavigationStack { PartnerPeriodView() }
}
