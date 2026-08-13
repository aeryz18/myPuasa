//
//  FastingListView.swift
//  myPuasa
//
//  Created by STDCX_MACBOOK PRO 32 on 14/08/2026.
//

import SwiftUI

struct FastingListView: View {
    @ObservedObject var fastingStore = FastingStore.shared
    @State private var showCongratulations = false
    
    // Custom Color Palette (Matching myPuasa design system)
    private let backgroundColor = Color(red: 250 / 255, green: 248 / 255, blue: 245 / 255)
    private let boxColor = Color(red: 237 / 255, green: 231 / 255, blue: 223 / 255)
    private let borderColor = Color(red: 221 / 255, green: 212 / 255, blue: 200 / 255)
    private let highlightColor = Color(red: 123 / 255, green: 45 / 255, blue: 63 / 255)
    
    /// Groups ALL missed fasts (both completed and uncompleted) by detected year in descending order (e.g. 2025, 2024, 2023)
    private var groupedByYear: [(year: Int, fasts: [MissedFastItem])] {
        let groups = Dictionary(grouping: fastingStore.missedFasts) { $0.detectedYear }
        return groups.map { (year: $0.key, fasts: $0.value) }
                     .sorted(by: { $0.year > $1.year })
    }

    var body: some View {
        ZStack {
            backgroundColor
                .ignoresSafeArea()
            
            ScrollView(showsIndicators: false) {
                VStack(spacing: 20) {
                    // Header Description Card
                    VStack(alignment: .leading, spacing: 6) {
                        Text("All Missed Fasts by Year")
                            .font(.title3)
                            .fontWeight(.bold)
                            .foregroundColor(.primary)
                        
                        Text("Review and update all your Qada' fasts categorized by Ramadan year.")
                            .font(.subheadline)
                            .foregroundColor(.secondary)
                    }
                    .padding(16)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .background(boxColor)
                    .clipShape(RoundedRectangle(cornerRadius: 18))
                    .overlay(
                        RoundedRectangle(cornerRadius: 18)
                            .stroke(borderColor, lineWidth: 1)
                    )
                    .padding(.top, 8)
                    
                    // Grouped Year Sections
                    if groupedByYear.isEmpty {
                        // Congratulations Card when no uncompleted fasts remain!
                        VStack(spacing: 14) {
                            ZStack {
                                Circle()
                                    .fill(Color.green.opacity(0.12))
                                    .frame(width: 72, height: 72)
                                Image(systemName: "checkmark.seal.fill")
                                    .font(.system(size: 40))
                                    .foregroundColor(Color.green)
                            }
                            
                            Text("Alhamdulillah!")
                                .font(.title3)
                                .fontWeight(.bold)
                                .foregroundColor(.primary)
                            
                            Text("You have completed all your pending Qada' fasts!")
                                .font(.subheadline)
                                .foregroundColor(.secondary)
                                .multilineTextAlignment(.center)
                        }
                        .padding(28)
                        .frame(maxWidth: .infinity)
                        .background(boxColor)
                        .clipShape(RoundedRectangle(cornerRadius: 20))
                        .overlay(
                            RoundedRectangle(cornerRadius: 20)
                                .stroke(borderColor, lineWidth: 1)
                        )
                        .padding(.top, 12)
                    } else {
                        ForEach(groupedByYear, id: \.year) { group in
                            let completedCount = group.fasts.filter { $0.isCompleted }.count
                            let totalCount = group.fasts.count
                            
                            VStack(alignment: .leading, spacing: 12) {
                                // Year Header Title & Pill
                                HStack {
                                    HStack(spacing: 8) {
                                        Image(systemName: "calendar")
                                            .foregroundColor(highlightColor)
                                        Text("Ramadan \(String(group.year))")
                                            .font(.headline)
                                            .fontWeight(.bold)
                                            .foregroundColor(.primary)
                                    }
                                    
                                    Spacer()
                                    
                                    Text("\(completedCount)/\(totalCount) Completed")
                                        .font(.caption)
                                        .fontWeight(.bold)
                                        .foregroundColor(completedCount == totalCount ? Color.green : highlightColor)
                                        .padding(.horizontal, 10)
                                        .padding(.vertical, 5)
                                        .background(completedCount == totalCount ? Color.green.opacity(0.12) : highlightColor.opacity(0.12))
                                        .clipShape(Capsule())
                                }
                                
                                // List of Missed Fast Rows in this Year
                                VStack(spacing: 0) {
                                    ForEach(group.fasts) { fastItem in
                                        if let index = fastingStore.missedFasts.firstIndex(where: { $0.id == fastItem.id }) {
                                            MissedFastRow(
                                                date: fastItem.dateString,
                                                isCompleted: $fastingStore.missedFasts[index].isCompleted
                                            ) {
                                                withAnimation(.spring(response: 0.4, dampingFraction: 0.7)) {
                                                    showCongratulations = true
                                                }
                                            }
                                            
                                            if fastItem.id != group.fasts.last?.id {
                                                Divider()
                                                    .background(borderColor)
                                            }
                                        }
                                    }
                                }
                                .background(Color.white)
                                .clipShape(RoundedRectangle(cornerRadius: 16))
                                .overlay(
                                    RoundedRectangle(cornerRadius: 16)
                                        .stroke(borderColor, lineWidth: 1)
                                )
                            }
                            .padding(16)
                            .background(boxColor)
                            .clipShape(RoundedRectangle(cornerRadius: 20))
                            .overlay(
                                RoundedRectangle(cornerRadius: 20)
                                    .stroke(borderColor, lineWidth: 1)
                            )
                        }
                    }
                }
                .padding(.horizontal, 20)
                .padding(.bottom, 30)
            }
            
            // Celebration Popup Overlay
            if showCongratulations {
                CongratulationsPopupView(isPresented: $showCongratulations)
                    .transition(.opacity)
                    .zIndex(10)
            }
        }
        .navigationTitle("Fasts by Year")
        .navigationBarTitleDisplayMode(.inline)
    }
}

#Preview {
    NavigationStack {
        FastingListView()
    }
}
