//
//  MissedFastRow.swift
//  myPuasa
//

import SwiftUI

struct MissedFastRow: View {
    let date: String
    @Binding var isCompleted: Bool
    var onComplete: (() -> Void)? = nil
    
    private let borderColor = Color(red: 221 / 255, green: 212 / 255, blue: 200 / 255)
    private let highlightColor = Color(red: 123 / 255, green: 45 / 255, blue: 63 / 255)
    
    var body: some View {
        HStack(spacing: 14) {
            ZStack {
                Circle()
                    .fill(highlightColor.opacity(0.12))
                    .frame(width: 38, height: 38)
                Image(systemName: "calendar")
                    .font(.subheadline)
                    .foregroundColor(highlightColor)
            }
            
            Text(date)
                .font(.subheadline)
                .fontWeight(.bold)
                .foregroundColor(.primary)
            
            Spacer()
            
            Button {
                let willBeCompleted = !isCompleted
                withAnimation(.spring(response: 0.3, dampingFraction: 0.6)) {
                    isCompleted.toggle()
                }
                if willBeCompleted {
                    onComplete?()
                }
            } label: {
                if isCompleted {
                    Image(systemName: "checkmark.circle.fill")
                        .font(.title2)
                        .foregroundColor(highlightColor)
                } else {
                    Circle()
                        .stroke(borderColor, lineWidth: 2)
                        .frame(width: 24, height: 24)
                }
            }
        }
        .padding(.vertical, 12)
        .padding(.horizontal, 14)
    }
}

