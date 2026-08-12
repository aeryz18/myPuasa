//
//  MenstrualStatusCard.swift
//  myPuasa
//

import SwiftUI

struct MenstrualStatusCard: View {
    let boxColor: Color
    let borderColor: Color
    let highlightColor: Color
    
    var body: some View {
        NavigationLink {
            CalendarView()
        } label: {
            HStack(spacing: 14) {
                ZStack {
                    Circle()
                        .fill(highlightColor.opacity(0.15))
                        .frame(width: 44, height: 44)
                    Image(systemName: "drop.fill")
                        .font(.subheadline)
                        .foregroundColor(highlightColor)
                }
                
                VStack(alignment: .leading, spacing: 2) {
                    Text("Menstrual Cycle")
                        .font(.caption)
                        .fontWeight(.semibold)
                        .foregroundColor(highlightColor)
                    
                    Text("3 days until next cycle")
                        .font(.subheadline)
                        .fontWeight(.bold)
                        .foregroundColor(.primary)
                }
                
                Spacer()
                
                HStack(spacing: 4) {
                    Text("Update")
                        .font(.footnote)
                        .fontWeight(.semibold)
                    Image(systemName: "chevron.right")
                        .font(.caption)
                        .bold()
                }
                .foregroundColor(highlightColor)
            }
            .padding(14)
            .background(boxColor)
            .clipShape(RoundedRectangle(cornerRadius: 16))
            .overlay(
                RoundedRectangle(cornerRadius: 16)
                    .stroke(borderColor, lineWidth: 1)
            )
        }
    }
}

#Preview {
    MenstrualStatusCard(
        boxColor: Color(red: 237 / 255, green: 231 / 255, blue: 223 / 255),
        borderColor: Color(red: 221 / 255, green: 212 / 255, blue: 200 / 255),
        highlightColor: Color(red: 123 / 255, green: 45 / 255, blue: 63 / 255)
    )
}
