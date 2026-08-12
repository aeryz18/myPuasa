//
//  FastingProgressCircle.swift
//  myPuasa
//

import SwiftUI

struct FastingProgressCircle: View {
    var completedDays: Int = 3
    var totalDays: Int = 5
    
    private let burgundy = Color(red: 0.45, green: 0.03, blue: 0.15)
    private let trackColor = Color(red: 0.88, green: 0.84, blue: 0.77)
    
    private var progressRatio: Double {
        guard totalDays > 0 else { return 0 }
        return Double(completedDays) / Double(totalDays)
    }
    
    var body: some View {
        ZStack {
            // Background track ring
            Circle()
                .stroke(trackColor, lineWidth: 20)
            
            // Progress ring
            Circle()
                .trim(from: 0, to: progressRatio)
                .stroke(burgundy, style: StrokeStyle(lineWidth: 20, lineCap: .butt))
                .rotationEffect(.degrees(-90))
            
            // Text counter
            HStack(spacing: 5) {
                Text("\(completedDays)/\(totalDays)")
                    .font(.system(size: 48, weight: .bold))
                
                Text("Days")
                    .font(.system(size: 21, weight: .bold))
            }
        }
        .frame(width: 220, height: 220)
        .shadow(color: .black.opacity(0.2), radius: 8)
    }
}

#Preview {
    FastingProgressCircle()
}
