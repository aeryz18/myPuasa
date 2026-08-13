//
//  paymentReceipt.swift
//  myPuasa
//
//  Created by STDCX_MACBOOK PRO 28 on 11/08/2026.
//

import SwiftUI

struct paymentReceipt: View {
    let amountPaid: Double
    let paymentMethod: String
    let stateName: String
    
    @Environment(\.dismiss) private var dismiss
    
    private let backgroundColor = Color(red: 250 / 255, green: 248 / 255, blue: 245 / 255)
    private let boxColor = Color(red: 237 / 255, green: 231 / 255, blue: 223 / 255)
    private let highlightColor = Color(red: 123 / 255, green: 45 / 255, blue: 63 / 255)
    
    private var currentDateString: String {
        let formatter = DateFormatter()
        formatter.dateFormat = "dd MMM yyyy, h:mm a"
        return formatter.string(from: Date())
    }
    
    private var referenceNo: String {
        "FIDYAH\(Int.random(in: 10000...99999))"
    }
    
    var body: some View {
        ZStack {
            backgroundColor
                .ignoresSafeArea()
            
            VStack(spacing: 24) {
                Spacer()
                
                // Green Checkmark Circle
                ZStack {
                    Circle()
                        .fill(Color(red: 0.72, green: 0.86, blue: 0.55))
                        .frame(width: 120, height: 120)
                    
                    Image(systemName: "checkmark")
                        .font(.system(size: 60, weight: .bold))
                        .foregroundColor(Color(red: 0.25, green: 0.39, blue: 0.15))
                }
                
                // Success Message
                VStack(spacing: 6) {
                    Text("Alhamdulillah!")
                        .font(.system(size: 22, weight: .bold))
                    
                    Text("Your fidyah has been recorded!")
                        .font(.system(size: 16, weight: .semibold))
                        .foregroundColor(.secondary)
                }
                
                // Receipt Details Card
                VStack(spacing: 14) {
                    receiptRow(label: "Amount Paid", value: String(format: "RM %.2f", amountPaid))
                    receiptRow(label: "Payment Method", value: paymentMethod)
                    receiptRow(label: "State", value: stateName)
                    receiptRow(label: "Date", value: currentDateString)
                    receiptRow(label: "Reference No.", value: referenceNo)
                }
                .padding(18)
                .background(boxColor)
                .clipShape(RoundedRectangle(cornerRadius: 20))
                .padding(.horizontal, 20)
                
                Spacer()
                
                // Done Button
                Button {
                    dismiss()
                } label: {
                    Text("Done")
                        .font(.system(size: 17, weight: .bold))
                        .foregroundColor(.white)
                        .frame(maxWidth: .infinity)
                        .frame(height: 52)
                        .background(highlightColor)
                        .clipShape(Capsule())
                }
                .padding(.horizontal, 22)
                .padding(.bottom, 30)
            }
        }
    }
    
    private func receiptRow(label: String, value: String) -> some View {
        HStack {
            Text(label)
                .font(.system(size: 14))
                .foregroundColor(.secondary)
            Spacer()
            Text(value)
                .font(.system(size: 14, weight: .semibold))
        }
    }
}

#Preview {
    paymentReceipt(amountPaid: 150.00, paymentMethod: "Online Banking", stateName: "Selangor")
}
