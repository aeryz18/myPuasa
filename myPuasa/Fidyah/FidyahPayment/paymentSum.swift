//
//  paymentSum.swift
//  myPuasa
//
//  Created by STDCX_MACBOOK PRO 28 on 11/08/2026.
//

import SwiftUI

struct paymentSum: View {
    let stateName: String
        let rate: Double
        let days: Int
        let totalAmount: Double


        var body: some View {

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

                    // MARK: Left

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


                    // MARK: Right

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
                .foregroundStyle(.black)
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
        }
    }

#Preview {
    paymentSum(stateName: "selangor" , rate: 0.0, days: 0, totalAmount: 0.0)
}
