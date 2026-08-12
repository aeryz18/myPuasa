//
//  MissedFastRow.swift
//  myPuasa
//

import SwiftUI

struct MissedFastRow: View {
    let date: String
    @Binding var isCompleted: Bool
    
    var body: some View {
        HStack {
            Text(date)
                .font(.system(size: 20, weight: .semibold))
            
            Spacer()
            
            Button {
                isCompleted.toggle()
            } label: {
                if isCompleted {
                    Image(systemName: "checkmark.circle.fill")
                        .font(.system(size: 38))
                        .foregroundColor(.green)
                } else {
                    Circle()
                        .stroke(Color.black, lineWidth: 1)
                        .frame(width: 38, height: 38)
                }
            }
        }
        .frame(height: 85)
    }
}
