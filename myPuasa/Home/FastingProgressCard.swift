//
//  FastingProgressCard.swift
//  myPuasa
//

import SwiftUI

struct FastingProgressCard: View {
    var completedDays: Int = 7
    var totalDays: Int = 14
    
    let boxColor: Color
    let borderColor: Color
    let highlightColor: Color
    
    var body: some View {
        VStack(spacing: 18) {
            Text("Fasting Progress")
                .font(.headline)
                .foregroundColor(.primary)
                .frame(maxWidth: .infinity, alignment: .leading)
            
            // Circular Progress Ring
            ZStack {
                Circle()
                    .stroke(borderColor, lineWidth: 16)
                    .frame(width: 180, height: 180)
                
                Circle()
                    .trim(from: 0, to: Double(completedDays) / Double(totalDays))
                    .stroke(
                        highlightColor,
                        style: StrokeStyle(lineWidth: 16, lineCap: .round)
                    )
                    .rotationEffect(.degrees(-90))
                    .frame(width: 180, height: 180)
                
                VStack(spacing: 2) {
                    Text("\(completedDays) / \(totalDays)")
                        .font(.system(size: 36, weight: .bold, design: .rounded))
                        .foregroundColor(highlightColor)
                    Text("Days Completed")
                        .font(.caption)
                        .foregroundColor(.secondary)
                }
            }
            .padding(.vertical, 6)
            
            Text("Keep it up, don't give up! 💪")
                .font(.subheadline)
                .fontWeight(.semibold)
                .foregroundColor(.primary)
            
            NavigationLink {
                FastingView()
            } label: {
                HStack(spacing: 6) {
                    Text("Update Fasting Progress")
                        .font(.subheadline)
                        .fontWeight(.semibold)
                    Image(systemName: "chevron.right")
                        .font(.footnote)
                        .bold()
                }
                .foregroundColor(.white)
                .padding(.vertical, 13)
                .padding(.horizontal, 24)
                .background(highlightColor)
                .clipShape(Capsule())
            }
        }
        .padding(22)
        .frame(maxWidth: .infinity)
        .background(boxColor)
        .clipShape(RoundedRectangle(cornerRadius: 22))
        .overlay(
            RoundedRectangle(cornerRadius: 22)
                .stroke(borderColor, lineWidth: 1)
        )
    }
}

#Preview {
    FastingProgressCard(
        boxColor: Color(red: 237 / 255, green: 231 / 255, blue: 223 / 255),
        borderColor: Color(red: 221 / 255, green: 212 / 255, blue: 200 / 255),
        highlightColor: Color(red: 123 / 255, green: 45 / 255, blue: 63 / 255)
    )
}
