//
//  Guideline5.swift
//  myPuasa
//
//  Created by STDCX_MACBOOK PRO 28 on 11/08/2026.
//

import SwiftUI

struct Guideline5: View {
    let boxColor: Color
    let borderColor: Color
    let highlightColor: Color
    
    var body: some View {
        HStack(spacing: 14) {
            ZStack {
                Circle()
                   .fill(highlightColor.opacity(0.15))
                    .frame(width: 44, height: 44)
                Image(systemName: "books.vertical.circle.fill")
                    .font(.subheadline)
                   .foregroundColor(highlightColor)
            }
            
            VStack(alignment: .leading, spacing: 2) {
                Text("Scholarly Reference")
                    .font(.headline)
                    .foregroundColor(.primary)
                Text("State")
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

#Preview {
    Guideline5(boxColor: Color(red: 237 / 255, green: 231 / 255, blue: 223 / 255),
               borderColor: Color(red: 221 / 255, green: 212 / 255, blue: 200 / 255),
               highlightColor: Color(red: 123 / 255, green: 45 / 255, blue: 63 / 255
 ))
}
