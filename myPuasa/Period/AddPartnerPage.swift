//
//  AddPartnerPage.swift
//  myPuasa
//
//  Created by STDCX_MACBOOK PRO 32 on 13/08/2026.
//

import SwiftUI

struct AddPartnerPage: View {
    @AppStorage("partnerName") private var partnerName: String = ""
    @AppStorage("partnerPhone") private var partnerPhone: String = ""
    @AppStorage("hasPartner") private var hasPartner: Bool = false
    
    @State private var partnerNameInput = ""
    @State private var partnerPhoneInput = ""
    @State private var navigateToPartnerPeriod = false
    
    private let backgroundColor = Color(red: 250 / 255, green: 248 / 255, blue: 245 / 255)
    private let borderColor = Color(red: 221 / 255, green: 212 / 255, blue: 200 / 255)
    private let highlightColor = Color(red: 123 / 255, green: 45 / 255, blue: 63 / 255)
    private let cardColor = Color(red: 237 / 255, green: 231 / 255, blue: 223 / 255)
    
    var body: some View {
        ZStack {
            backgroundColor.ignoresSafeArea()
            
            ScrollView(showsIndicators: false) {
                VStack(spacing: 28) {
                    
                    // Header
                    VStack(spacing: 12) {
                        ZStack {
                            Circle().fill(cardColor).frame(width: 100, height: 100)
                            Image(systemName: "person.2.fill")
                                .font(.system(size: 40))
                                .foregroundColor(highlightColor)
                        }
                        Text("Add Your Partner")
                            .font(.system(size: 26, weight: .bold))
                        Text("Stay connected with your partner's cycle")
                            .font(.subheadline).foregroundColor(.secondary)
                            .multilineTextAlignment(.center)
                    }
                    .padding(.top, 32)
                    
                    VStack(spacing: 20) {
                        
                        // Name
                        VStack(alignment: .leading, spacing: 8) {
                            Text("Partner's Name").font(.headline).fontWeight(.bold)
                            HStack(spacing: 12) {
                                Image(systemName: "person.fill").foregroundColor(highlightColor).frame(width: 20)
                                TextField("e.g. Siti Nurul", text: $partnerNameInput)
                                    .autocapitalization(.words)
                            }
                            .padding(14)
                            .background(Color.white)
                            .clipShape(RoundedRectangle(cornerRadius: 16))
                            .overlay(RoundedRectangle(cornerRadius: 16).stroke(borderColor, lineWidth: 1))
                        }
                        
                        // Phone
                        VStack(alignment: .leading, spacing: 8) {
                            Text("Phone Number (Optional)").font(.headline).fontWeight(.bold)
                            HStack(spacing: 12) {
                                Image(systemName: "phone.fill").foregroundColor(highlightColor).frame(width: 20)
                                TextField("e.g. 012-3456789", text: $partnerPhoneInput)
                                    .keyboardType(.phonePad)
                            }
                            .padding(14)
                            .background(Color.white)
                            .clipShape(RoundedRectangle(cornerRadius: 16))
                            .overlay(RoundedRectangle(cornerRadius: 16).stroke(borderColor, lineWidth: 1))
                        }
                        
                        // How it works card
                        HStack(alignment: .top, spacing: 14) {
                            Image(systemName: "info.circle.fill")
                                .foregroundColor(highlightColor).font(.title3).padding(.top, 2)
                            VStack(alignment: .leading, spacing: 6) {
                                Text("How it works").font(.subheadline).fontWeight(.bold)
                                Text("Ask your partner to switch profile and log in on this device to enter her period data. You will then view her period in read-only mode.")
                                    .font(.caption).foregroundColor(.secondary)
                                    .fixedSize(horizontal: false, vertical: true)
                            }
                        }
                        .padding(16)
                        .background(highlightColor.opacity(0.08))
                        .clipShape(RoundedRectangle(cornerRadius: 16))
                        
                        // Add Partner button
                        Button {
                            partnerName = partnerNameInput.isEmpty ? "Partner" : partnerNameInput
                            partnerPhone = partnerPhoneInput
                            hasPartner = true
                            navigateToPartnerPeriod = true
                        } label: {
                            Text("Add Partner")
                                .font(.headline).fontWeight(.bold)
                                .foregroundColor(.white)
                                .frame(maxWidth: .infinity)
                                .padding(.vertical, 16)
                                .background(highlightColor)
                                .clipShape(Capsule())
                                .shadow(color: highlightColor.opacity(0.3), radius: 6, x: 0, y: 3)
                        }
                        .navigationDestination(isPresented: $navigateToPartnerPeriod) {
                            PartnerPeriodView()
                        }
                    }
                    .padding(24)
                    .background(cardColor)
                    .clipShape(RoundedRectangle(cornerRadius: 24))
                    .shadow(color: Color.black.opacity(0.06), radius: 12, x: 0, y: 4)
                    .padding(.horizontal, 20)
                    .padding(.bottom, 40)
                }
            }
        }
        .navigationTitle("Add Partner")
        .navigationBarTitleDisplayMode(.inline)
    }
}

#Preview {
    NavigationStack { AddPartnerPage() }
}
