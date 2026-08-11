//
//  HomeHeaderView.swift
//  myPuasa
//

import SwiftUI

struct HomeHeaderView: View {
    var userName: String = "Harith"
    
    private var gregorianDateString: String {
        let formatter = DateFormatter()
        formatter.dateFormat = "d MMMM yyyy"
        formatter.locale = Locale(identifier: "en")
        return formatter.string(from: Date())
    }
    
    private var hijriDateString: String {
        let formatter = DateFormatter()
        formatter.calendar = Calendar(identifier: .islamicUmmAlQura)
        formatter.dateFormat = "d MMMM yyyy 'AH'"
        formatter.locale = Locale(identifier: "en")
        return formatter.string(from: Date())
    }
    
    var body: some View {
        ZStack {
            // 1. Background Image
            HStack {
                Image("image2")
                    .resizable()         // MUST be called first to allow resizing
                    .scaledToFill()      // Use Fill so it covers the whole frame area without white space
                    .frame(height: 250)
                    .opacity(0.4)
                    .clipped()
            }
            
            // 2. Foreground Text
            HStack {
                VStack(alignment: .leading, spacing: 2) {
                    Text("Assalamualaikum,")
                        .font(.title3)
                        .fontWeight(.semibold)
                        .foregroundColor(.secondary)
                    
                    Text(userName)
                        .font(.largeTitle)
                        .fontWeight(.bold)
                        .foregroundColor(.primary)
                    
                    Text("\(gregorianDateString) • \(hijriDateString)")
                        .font(.subheadline)
                        .fontWeight(.medium)
                        .foregroundColor(.secondary)
                        .padding(.top, 2)
                    Spacer()
                }
                .padding(.top,30)
                Spacer() // Pushes the text to the left side of the screen
            }
            .padding(.horizontal) // Adds breathing room on the left and right sides
        }
        
    }
}

#Preview {
    HomeHeaderView()
}


