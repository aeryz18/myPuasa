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

        @State private var showSuccess = false


        


        var body: some View {

            ScrollView(
                .vertical,
                showsIndicators: false
            ) {

                VStack(
                    alignment: .leading,
                    spacing: 18
                ) {

                    
                    VStack(
                        alignment: .leading,
                        spacing: 14
                    ) {

                        Text("Summary")
                            .font(
                                .system(
                                    size: 18,
                                    weight: .bold
                                )
                            )


                        HStack {

                            // LEFT

                            VStack(
                                alignment: .leading,
                                spacing: 8
                            ) {

                                Text("State")

                                Text("Rate per day")

                                Text("Number of days")

                                Spacer()

                                Text("Total Amount")
                                    .fontWeight(.bold)
                            }


                            Spacer()


                            // RIGHT

                            VStack(
                                alignment: .trailing,
                                spacing: 8
                            ) {

                                Text(stateName)

                                Text(
                                    "RM \(rate, specifier: "%.2f")"
                                )

                                Text("\(days)")

                                Spacer()

                                Text(
                                    "RM \(totalAmount, specifier: "%.2f")"
                                )
                                .font(
                                    .system(
                                        size: 22,
                                        weight: .bold
                                    )
                                )
                                .foregroundStyle(
                                    FidyahTheme.maroon
                                )
                            }
                        }
                        .font(
                            .system(size: 13)
                        )
                    }
                    .padding(18)
                    .frame(
                        maxWidth: .infinity,
                        alignment: .leading
                    )
                    .background(
                        FidyahTheme.cream
                    )
                    .clipShape(
                        RoundedRectangle(
                            cornerRadius: 20
                        )
                    )


                    

                    FidyahSectionTitle(
                        number: "1",
                        title: "Payment Method"
                    )


                    

                    Button {

                        selectedMethod = .onlineBanking

                    } label: {

                        HStack {

                            Image(
                                systemName:
                                    "building.columns.fill"
                            )
                            .foregroundStyle(
                                FidyahTheme.maroon
                            )

                            Text("Online Banking")
                                .foregroundStyle(.black)

                            Spacer()

                            Image(
                                systemName:
                                    selectedMethod == .onlineBanking
                                    ? "largecircle.fill.circle"
                                    : "circle"
                            )
                            .foregroundStyle(
                                selectedMethod == .onlineBanking
                                ? FidyahTheme.maroon
                                : .gray
                            )
                        }
                        .padding(18)
                        .background(
                            Color.white
                        )
                        .clipShape(
                            RoundedRectangle(
                                cornerRadius: 18
                            )
                        )
                    }
                    .buttonStyle(.plain)


                   

                    Button {

                        selectedMethod = .tng

                    } label: {

                        HStack {

                            Image(
                                systemName:
                                    "wallet.pass.fill"
                            )
                            .foregroundStyle(
                                FidyahTheme.maroon
                            )

                            Text("TnG eWallet")
                                .foregroundStyle(.black)

                            Spacer()

                            Image(
                                systemName:
                                    selectedMethod == .tng
                                    ? "largecircle.fill.circle"
                                    : "circle"
                            )
                            .foregroundStyle(
                                selectedMethod == .tng
                                ? FidyahTheme.maroon
                                : .gray
                            )
                        }
                        .padding(18)
                        .background(
                            Color.white
                        )
                        .clipShape(
                            RoundedRectangle(
                                cornerRadius: 18
                            )
                        )
                    }
                    .buttonStyle(.plain)


                

                    Button {

                        selectedMethod = .duitNow

                    } label: {

                        HStack {

                            Image(
                                systemName:
                                    "qrcode"
                            )
                            .foregroundStyle(
                                FidyahTheme.maroon
                            )

                            Text("QR DuitNow")
                                .foregroundStyle(.black)

                            Spacer()

                            Image(
                                systemName:
                                    selectedMethod == .duitNow
                                    ? "largecircle.fill.circle"
                                    : "circle"
                            )
                            .foregroundStyle(
                                selectedMethod == .duitNow
                                ? FidyahTheme.maroon
                                : .gray
                            )
                        }
                        .padding(18)
                        .background(
                            Color.white
                        )
                        .clipShape(
                            RoundedRectangle(
                                cornerRadius: 18
                            )
                        )
                    }
                    .buttonStyle(.plain)


                   

                    FidyahPrimaryButton(
                        title: "Proceed Payment",
                        disabled: false
                    ) {

                        showSuccess = true
                    }


                    Spacer(
                        minLength: 30
                    )
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


        

            .alert(
                "Payment Successful",
                isPresented: $showSuccess
            ) {

          

            } message: {

                Text(
                    "Your fidyah payment of RM \(totalAmount, specifier: "%.2f") has been recorded."
                )
            }
        }
    }

#Preview {
    paymentView(stateName: "" , rate: 0.0, days: 0, totalAmount: 0.0)
}
