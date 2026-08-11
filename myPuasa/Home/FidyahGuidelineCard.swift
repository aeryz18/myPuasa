//
//  FidyahGuidelineCard.swift
//  myPuasa
//

import SwiftUI

struct FidyahGuidelineCard: View {
    let boxColor: Color
    let borderColor: Color
    let highlightColor: Color
    
    var body: some View {
        NavigationLink {
            FidyahView()
        } label: {
            HStack(spacing: 14) {
                ZStack {
                    Circle()
                        .fill(highlightColor.opacity(0.15))
                        .frame(width: 44, height: 44)
                    Image(systemName: "book.closed.fill")
                        .font(.subheadline)
                        .foregroundColor(highlightColor)
                }
                
                VStack(alignment: .leading, spacing: 2) {
                    Text("Fidyah Guideline")
                        .font(.headline)
                        .foregroundColor(.primary)
                    Text("Learn rules & calculation guide")
                        .font(.caption)
                        .foregroundColor(.secondary)
                }
                
                Spacer()
                
                Image(systemName: "chevron.right")
                    .font(.subheadline)
                    .fontWeight(.bold)
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
    FidyahGuidelineCard(
        boxColor: Color(red: 237 / 255, green: 231 / 255, blue: 223 / 255),
        borderColor: Color(red: 221 / 255, green: 212 / 255, blue: 200 / 255),
        highlightColor: Color(red: 123 / 255, green: 45 / 255, blue: 63 / 255)
    )
}
