//
//  FastingView.swift
//  myPuasa
//

import SwiftUI

struct FastingView: View {
    // Custom Color Palette (Identical to HomeView)
    private let backgroundColor = Color(red: 250 / 255, green: 248 / 255, blue: 245 / 255)
    private let boxColor = Color(red: 237 / 255, green: 231 / 255, blue: 223 / 255)
    private let borderColor = Color(red: 221 / 255, green: 212 / 255, blue: 200 / 255)
    private let highlightColor = Color(red: 123 / 255, green: 45 / 255, blue: 63 / 255)
    
    // MARK: - State
    @State private var missedFasts: [MissedFastItem] = [
        MissedFastItem(dateString: "2 Jan 2025", note: "Ramadan 1446", isCompleted: true),
        MissedFastItem(dateString: "2 Feb 2025", note: "Ramadan 1446", isCompleted: true),
        MissedFastItem(dateString: "2 Mac 2025", note: "Ramadan 1446", isCompleted: false)
    ]
    
    @State private var showAddFast = false
    @State private var showCongratulations = false
    
    private var completedCount: Int {
        missedFasts.filter { $0.isCompleted }.count
    }
    
    var body: some View {
        NavigationStack {
            ZStack {
                backgroundColor
                    .ignoresSafeArea()
                
                ScrollView(showsIndicators: false) {
                    VStack(spacing: 18) {
                        // Header Title
                        HStack {
                            VStack(alignment: .leading, spacing: 3) {
                                Text("Fasting Tracker")
                                    .font(.title2)
                                    .fontWeight(.bold)
                                    .foregroundColor(.primary)
                                Text("Log and complete your Qada' fasts")
                                    .font(.subheadline)
                                    .foregroundColor(.secondary)
                            }
                            Spacer()
                        }
                        .padding(.top, 6)
                        
                        // Fasting Progress Card Container
                        VStack(spacing: 16) {
                            FastingProgressCircle(completedDays: completedCount, totalDays: missedFasts.count)
                            
                            Text("\(missedFasts.count - completedCount) Days Remaining")
                                .font(.subheadline)
                                .fontWeight(.semibold)
                                .foregroundColor(highlightColor)
                        }
                        .padding(20)
                        .frame(maxWidth: .infinity)
                        .background(boxColor)
                        .clipShape(RoundedRectangle(cornerRadius: 22))
                        .overlay(
                            RoundedRectangle(cornerRadius: 22)
                                .stroke(borderColor, lineWidth: 1)
                        )
                        
                        // Missed Fast List Card
                        VStack(spacing: 12) {
                            HStack {
                                Text("Missed Fast List")
                                    .font(.headline)
                                    .foregroundColor(.primary)
                                Spacer()
                                Text("\(completedCount)/\(missedFasts.count) Done")
                                    .font(.caption)
                                    .fontWeight(.semibold)
                                    .foregroundColor(highlightColor)
                            }
                            
                            VStack(spacing: 0) {
                                ForEach($missedFasts) { $fast in
                                    MissedFastRow(date: fast.dateString, isCompleted: $fast.isCompleted) {
                                        withAnimation(.spring(response: 0.4, dampingFraction: 0.7)) {
                                            showCongratulations = true
                                        }
                                    }
                                    
                                    if fast.id != missedFasts.last?.id {
                                        Divider()
                                            .background(borderColor)
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
                        
                        // Add Missed Fast Button (Capsule CTA)
                        Button {
                            showAddFast = true
                        } label: {
                            HStack(spacing: 8) {
                                Image(systemName: "plus.circle.fill")
                                    .font(.subheadline)
                                Text("Add Missed Fast")
                                    .font(.subheadline)
                                    .fontWeight(.bold)
                            }
                            .foregroundColor(.white)
                            .frame(maxWidth: .infinity)
                            .padding(.vertical, 14)
                            .background(highlightColor)
                            .clipShape(Capsule())
                        }
                        .padding(.top, 4)
                    }
                    .padding(.horizontal, 20)
                    .padding(.bottom, 24)
                }
                
                // Congratulations Celebration Popup Overlay
                if showCongratulations {
                    CongratulationsPopupView(isPresented: $showCongratulations)
                        .transition(.opacity)
                        .zIndex(10)
                }
            }
        }
        .sheet(isPresented: $showAddFast) {
            AddFastView { count, ramadan, note in
                for i in 1...max(1, count) {
                    let item = MissedFastItem(
                        dateString: count > 1 ? "\(ramadan) (Fast #\(i))" : ramadan,
                        note: note.isEmpty ? nil : note,
                        isCompleted: false
                    )
                    missedFasts.append(item)
                }
            }
        }
    }
}

#Preview {
    FastingView()
}

