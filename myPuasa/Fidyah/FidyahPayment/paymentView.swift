//
//  paymentView.swift
//  myPuasa
//
//  Created by STDCX_MACBOOK PRO 28 on 11/08/2026.
//

import SwiftUI

struct paymentView: View {
    let stateName: String
    let rate: Double
    let days: Int
    let totalAmount: Double

    @State private var selectedMethod: PaymentMethod = .onlineBanking
    @State private var showReceipt = false

    private var selectedMethodName: String {
        switch selectedMethod {
        case .onlineBanking: return "Online Banking"
        case .tng: return "TnG eWallet"
        case .duitNow: return "QR DuitNow"
        case .card: return "Credit/Debit Card"
        }
    }

    var body: some View {
        NavigationStack {
            ScrollView(
                .vertical,
                showsIndicators: false
            ) {
                VStack(
                    alignment: .leading,
                    spacing: 18
                ) {
                    // Summary Card
                    VStack(
                        alignment: .leading,
                        spacing: 14
                    ) {
                        Text("Summary")
                            .font(.system(size: 18, weight: .bold))

                        HStack {
                            VStack(alignment: .leading, spacing: 8) {
                                Text("State")
                                Text("Rate per day")
                                Text("Number of days")
                                Spacer()
                                Text("Total Amount")
                                    .fontWeight(.bold)
                            }

                            Spacer()

                            VStack(alignment: .trailing, spacing: 8) {
                                Text(stateName)
                                Text("RM \(rate, specifier: "%.2f")")
                                Text("\(days)")
                                Spacer()
                                Text("RM \(totalAmount, specifier: "%.2f")")
                                    .font(.system(size: 22, weight: .bold))
                                    .foregroundStyle(FidyahTheme.maroon)
                            }
                        }
                        .font(.system(size: 13))
                    }
                    .padding(18)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .background(FidyahTheme.cream)
                    .clipShape(RoundedRectangle(cornerRadius: 20))

                    // Payment Method Section
                    FidyahSectionTitle(number: "1", title: "Payment Method")

                    // Online Banking
                    Button {
                        selectedMethod = .onlineBanking
                    } label: {
                        paymentMethodRow(
                            icon: "building.columns.fill",
                            title: "Online Banking",
                            isSelected: selectedMethod == .onlineBanking
                        )
                    }
                    .buttonStyle(.plain)

                    // TnG eWallet
                    Button {
                        selectedMethod = .tng
                    } label: {
                        paymentMethodRow(
                            icon: "wallet.pass.fill",
                            title: "TnG eWallet",
                            isSelected: selectedMethod == .tng
                        )
                    }
                    .buttonStyle(.plain)

                    // QR DuitNow
                    Button {
                        selectedMethod = .duitNow
                    } label: {
                        paymentMethodRow(
                            icon: "qrcode",
                            title: "QR DuitNow",
                            isSelected: selectedMethod == .duitNow
                        )
                    }
                    .buttonStyle(.plain)

                    // Proceed Payment Button
                    FidyahPrimaryButton(
                        title: "Proceed Payment",
                        disabled: false
                    ) {
                        showReceipt = true
                    }

                    Spacer(minLength: 30)
                }
                .padding(.horizontal, 18)
                .padding(.top, 20)
            }
            .background(
                FidyahTheme.background
                    .ignoresSafeArea()
            )
            .navigationTitle("Payment")
            .navigationBarTitleDisplayMode(.inline)
            .navigationDestination(isPresented: $showReceipt) {
                paymentReceipt(
                    amountPaid: totalAmount,
                    paymentMethod: selectedMethodName,
                    stateName: stateName
                )
                .navigationBarBackButtonHidden(true)
            }
        }
    }

    private func paymentMethodRow(icon: String, title: String, isSelected: Bool) -> some View {
        HStack {
            Image(systemName: icon)
                .foregroundStyle(FidyahTheme.maroon)

            Text(title)
                .foregroundStyle(.black)

            Spacer()

            Image(systemName: isSelected ? "largecircle.fill.circle" : "circle")
                .foregroundStyle(isSelected ? FidyahTheme.maroon : .gray)
        }
        .padding(18)
        .background(Color.white)
        .clipShape(RoundedRectangle(cornerRadius: 18))
    }
}

#Preview {
    paymentView(stateName: "Selangor", rate: 7.00, days: 5, totalAmount: 35.00)
}

