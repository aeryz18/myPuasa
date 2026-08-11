//
//  IslamicCalendarCard.swift
//  myPuasa
//

import SwiftUI

struct IslamicCalendarCard: View {
    let boxColor: Color
    let borderColor: Color
    let highlightColor: Color
    
    private var hijriDateString: String {
        let formatter = DateFormatter()
        formatter.calendar = Calendar(identifier: .islamicUmmAlQura)
        formatter.dateStyle = .full
        formatter.locale = Locale(identifier: "en")
        return formatter.string(from: Date())
    }
    
    var body: some View {
        HStack(spacing: 14) {
            ZStack {
                Circle()
                    .fill(highlightColor.opacity(0.15))
                    .frame(width: 44, height: 44)
                Image(systemName: "calendar.badge.clock")
                    .font(.subheadline)
                    .foregroundColor(highlightColor)
            }
            
            VStack(alignment: .leading, spacing: 2) {
                Text("Islamic Calendar")
                    .font(.caption)
                    .fontWeight(.semibold)
                    .foregroundColor(highlightColor)
                
                Text(hijriDateString)
                    .font(.subheadline)
                    .fontWeight(.bold)
                    .foregroundColor(.primary)
            }
            
            Spacer()
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

#Preview {
    IslamicCalendarCard(
        boxColor: Color(red: 237 / 255, green: 231 / 255, blue: 223 / 255),
        borderColor: Color(red: 221 / 255, green: 212 / 255, blue: 200 / 255),
        highlightColor: Color(red: 123 / 255, green: 45 / 255, blue: 63 / 255)
    )
}
