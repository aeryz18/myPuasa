//
//  AdsCard.swift
//  myPuasa
//

import SwiftUI

struct AdsCard: View {
    var boxColor: Color = Color(red: 237 / 255, green: 231 / 255, blue: 223 / 255)
    var borderColor: Color = Color(red: 221 / 255, green: 212 / 255, blue: 200 / 255)
    var highlightColor: Color = Color(red: 123 / 255, green: 45 / 255, blue: 63 / 255)
    
    private let ads: [String] = ["ads3", "ads2"]

    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            // Header Title with "SPONSORED" Badge
            HStack(spacing: 8) {
                Text("Special Highlights")
                    .font(.system(size: 15, weight: .bold))
                    .foregroundColor(.primary)

                Text("SPONSORED")
                    .font(.system(size: 9, weight: .bold))
                    .foregroundColor(highlightColor)
                    .padding(.horizontal, 6)
                    .padding(.vertical, 3)
                    .background(highlightColor.opacity(0.12))
                    .clipShape(Capsule())

                Spacer()
            }
            .padding(.horizontal, 4)

            // Horizontal Scroll Banner Carousel
            ScrollView(.horizontal, showsIndicators: false) {
                HStack(spacing: 14) {
                    ForEach(ads, id: \.self) { adName in
                        Image(adName)
                            .resizable()
                            .scaledToFit()
                            .frame(width: 290, height: 140)
                            .clipShape(RoundedRectangle(cornerRadius: 18))
                            .overlay(
                                RoundedRectangle(cornerRadius: 18)
                                    .stroke(borderColor, lineWidth: 1)
                            )
                            .shadow(color: Color.black.opacity(0.06), radius: 6, x: 0, y: 3)
                    }
                }
                .padding(.vertical, 2)
            }
        }
    }
}

#Preview {
    AdsCard()
        .padding()
}
