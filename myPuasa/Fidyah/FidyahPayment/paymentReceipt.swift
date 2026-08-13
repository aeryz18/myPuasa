//
//  paymentReceipt.swift
//  myPuasa
//
//  Created by STDCX_MACBOOK PRO 28 on 11/08/2026.
//

import SwiftUI

struct ConfettiParticleItem: Identifiable {
    let id = UUID()
    let color: Color
    let size: CGFloat
    let angle: Double
    let distance: CGFloat
    let speed: Double
    let rotation: Double
}

struct ConfettiView: View {
    @State private var particles: [ConfettiParticleItem] = []
    @State private var animate = false
    
    private let colors: [Color] = [
        Color(red: 123 / 255, green: 45 / 255, blue: 63 / 255),  // Maroon
        Color(red: 218 / 255, green: 165 / 255, blue: 32 / 255), // Gold
        Color(red: 76 / 255, green: 175 / 255, blue: 80 / 255),   // Green
        Color(red: 244 / 255, green: 143 / 255, blue: 177 / 255), // Pink
        Color(red: 237 / 255, green: 231 / 255, blue: 223 / 255)  // Sand
    ]
    
    var body: some View {
        GeometryReader { geo in
            ZStack {
                ForEach(particles) { p in
                    RoundedRectangle(cornerRadius: 2)
                        .fill(p.color)
                        .frame(width: p.size, height: p.size * 1.6)
                        .rotationEffect(.degrees(animate ? p.rotation + 360 : 0))
                        .position(
                            x: animate ? geo.size.width / 2 + cos(p.angle) * p.distance : geo.size.width / 2,
                            y: animate ? (geo.size.height * 0.3) + sin(p.angle) * p.distance + 40 : (geo.size.height * 0.3)
                        )
                        .scaleEffect(animate ? 1.0 : 0.2)
                        .opacity(animate ? 0 : 1)
                        .animation(
                            .easeOut(duration: p.speed)
                            .delay(Double.random(in: 0...0.15)),
                            value: animate
                        )
                }
            }
            .onAppear {
                createParticles()
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.05) {
                    animate = true
                }
            }
        }
        .allowsHitTesting(false)
    }
    
    private func createParticles() {
        particles = (0..<50).map { i in
            let angle = Double.random(in: 0...2 * .pi)
            let distance = CGFloat.random(in: 90...280)
            return ConfettiParticleItem(
                color: colors[i % colors.count],
                size: CGFloat.random(in: 9...15),
                angle: angle,
                distance: distance,
                speed: Double.random(in: 1.5...2.5),
                rotation: Double.random(in: 180...720)
            )
        }
    }
}

struct paymentReceipt: View {
    let amountPaid: Double
    var daysPaid: Int = 1
    let paymentMethod: String
    let stateName: String
    var onDone: (() -> Void)? = nil
    var onFinishAndGoToHistory: (() -> Void)? = nil
    
    @Environment(\.dismiss) private var dismiss
    @AppStorage("selectedTab") private var selectedTab: Int = 0
    @State private var navigateToRecords = false
    @State private var isCheckmarkAnimated = false
    
    private let backgroundColor = Color(red: 250 / 255, green: 248 / 255, blue: 245 / 255)
    private let boxColor = Color(red: 237 / 255, green: 231 / 255, blue: 223 / 255)
    private let borderColor = Color(red: 221 / 255, green: 212 / 255, blue: 200 / 255)
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
            
            // Confetti Overlay
            ConfettiView()
                .ignoresSafeArea()
            
            VStack(spacing: 24) {
                Spacer()
                
                // Animated Green Checkmark Circle
                ZStack {
                    Circle()
                        .fill(Color(red: 0.72, green: 0.86, blue: 0.55))
                        .frame(width: 120, height: 120)
                    
                    Image(systemName: "checkmark")
                        .font(.system(size: 60, weight: .bold))
                        .foregroundColor(Color(red: 0.25, green: 0.39, blue: 0.15))
                }
                .scaleEffect(isCheckmarkAnimated ? 1.0 : 0.1)
                .opacity(isCheckmarkAnimated ? 1.0 : 0.0)
                .animation(.spring(response: 0.6, dampingFraction: 0.6), value: isCheckmarkAnimated)
                
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
                    receiptRow(label: "Days Covered", value: "\(daysPaid) day(s)")
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
                
                // Two Action Buttons: History & Home Redirect
                VStack(spacing: 12) {
                    // Button 1: Fidyah Record History
                    Button {
                        if let onFinishAndGoToHistory = onFinishAndGoToHistory {
                            onFinishAndGoToHistory()
                        } else {
                            navigateToRecords = true
                        }
                    } label: {
                        HStack(spacing: 8) {
                            Image(systemName: "clock.arrow.circlepath")
                            Text("Fidyah Record History")
                                .font(.system(size: 16, weight: .bold))
                        }
                        .foregroundColor(.white)
                        .frame(maxWidth: .infinity)
                        .frame(height: 52)
                        .background(highlightColor)
                        .clipShape(Capsule())
                    }
                    
                    // Button 2: Done -> Redirect to Home Page & Dismiss Sheet
                    Button {
                        selectedTab = 0
                        if let onDone = onDone {
                            onDone()
                        } else {
                            dismiss()
                        }
                    } label: {
                        Text("Done")
                            .font(.system(size: 16, weight: .bold))
                            .foregroundColor(.primary)
                            .frame(maxWidth: .infinity)
                            .frame(height: 52)
                            .background(boxColor)
                            .clipShape(Capsule())
                            .overlay(Capsule().stroke(borderColor, lineWidth: 1))
                    }
                }
                .padding(.horizontal, 22)
                .padding(.bottom, 30)
            }
        }
        .navigationDestination(isPresented: $navigateToRecords) {
            FidyahRecordsView()
        }
        .onAppear {
            savePaymentRecord()
            withAnimation {
                isCheckmarkAnimated = true
            }
        }
    }
    
    private func savePaymentRecord() {
        let formatter = DateFormatter()
        formatter.dateFormat = "dd MMM yyyy"
        let todayStr = formatter.string(from: Date())
        
        let newRecord = FidyahRecordItem(
            dateString: todayStr,
            amount: amountPaid,
            days: daysPaid,
            paymentMethod: paymentMethod,
            stateName: stateName
        )
        
        // Prevent duplicate insertion
        if !UserStore.shared.currentUser.fidyahRecords.contains(where: { $0.amount == amountPaid && $0.dateString == todayStr }) {
            UserStore.shared.currentUser.fidyahRecords.insert(newRecord, at: 0)
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
