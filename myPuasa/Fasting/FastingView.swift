//
//  FastingView.swift
//  myPuasa
//

import SwiftUI

struct FastingView: View {
    // MARK: - Colors
    private let burgundy = Color(red: 0.45, green: 0.03, blue: 0.15)
    private let cream = Color(red: 0.91, green: 0.88, blue: 0.82)
    
    // MARK: - State
    @State private var fast1 = true
    @State private var fast2 = true
    @State private var fast3 = false
    @State private var showAddFast = false
    
    private var completedCount: Int {
        (fast1 ? 1 : 0) + (fast2 ? 1 : 0) + (fast3 ? 1 : 0)
    }
    
    var body: some View {
        VStack {
            ScrollView(showsIndicators: false) {
                VStack(spacing: 20) {
                    // Circular Progress View Component
                    FastingProgressCircle(completedDays: completedCount, totalDays: 3)
                    
                    // Missed Fast List Header
                    HStack {
                        Text("Missed Fast List")
                            .font(.system(size: 25, weight: .bold))
                        Spacer()
                    }
                    
                    // Reusable Fast List Rows
                    VStack(spacing: 0) {
                        MissedFastRow(date: "2 Jan 2025", isCompleted: $fast1)
                        Divider()
                        MissedFastRow(date: "2 Feb 2025", isCompleted: $fast2)
                        Divider()
                        MissedFastRow(date: "2 Mac 2025", isCompleted: $fast3)
                    }
                    .padding(.horizontal, 12)
                    .background(cream)
                    .cornerRadius(18)
                    
                    // Status Summary Indicator
                    HStack(spacing: 12) {
                        Text("Click to Update")
                            .font(.system(size: 23, weight: .bold))
                        
                        Image(systemName: "checkmark.circle.fill")
                            .font(.system(size: 38))
                            .foregroundColor(.green)
                        
                        Spacer()
                    }
                    
                    // Add Missed Fast Button
                    Button {
                        showAddFast = true
                    } label: {
                        HStack {
                            Text("+ Add missed Fast")
                                .font(.system(size: 18))
                            Spacer()
                        }
                        .foregroundColor(.black)
                        .padding(.horizontal, 15)
                        .frame(height: 65)
                        .background(cream)
                        .cornerRadius(15)
                    }
                    
                    Spacer()
                        .frame(height: 30)
                }
                .padding(.horizontal, 15)
                .padding(.top, 25)
            }
        }
        .background(Color.white)
        .sheet(isPresented: $showAddFast) {
            AddFastView()
        }
    }
}

#Preview {
    FastingView()
}
