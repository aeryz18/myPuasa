//
//  FastingProgressCircle.swift
//  myPuasa
//

import SwiftUI

struct FastingProgressCircle: View {
    var completedDays: Int = 3
    var totalDays: Int = 5
    
    private let borderColor = Color(red: 221 / 255, green: 212 / 255, blue: 200 / 255)
    private let highlightColor = Color(red: 123 / 255, green: 45 / 255, blue: 63 / 255)
    
    private var progressRatio: Double {
        guard totalDays > 0 else { return 0 }
        return Double(completedDays) / Double(totalDays)
    }
    
    var body: some View {
        ZStack {
            // Background track ring
            Circle()
                .stroke(borderColor, lineWidth: 16)
                .frame(width: 175, height: 175)
            
            // Progress ring
            Circle()
                .trim(from: 0, to: progressRatio)
                .stroke(highlightColor, style: StrokeStyle(lineWidth: 16, lineCap: .round))
                .rotationEffect(.degrees(-90))
                .frame(width: 175, height: 175)
            
            // Text counter inside ring
            VStack(spacing: 2) {
                Text("\(completedDays) / \(totalDays)")
                    .font(.system(size: 34, weight: .bold, design: .rounded))
                    .foregroundColor(highlightColor)
                Text("Days Completed")
                    .font(.caption)
                    .foregroundColor(.secondary)
            }
        }
        .padding(.vertical, 4)
    }
}

#Preview {
    FastingProgressCircle()
}
