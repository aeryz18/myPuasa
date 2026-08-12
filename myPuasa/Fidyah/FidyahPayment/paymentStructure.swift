//
//  paymentStructure.swift
//  myPuasa
//
//  Created by STDCX_MACBOOK PRO 28 on 11/08/2026.
//

import SwiftUI

struct paymentStructure: View {
    let method: PaymentMethod
    let selected: Bool
    let action: () -> Void

    var body: some View {

           
            

                Button {

                    action()

                } label: {

                    HStack(spacing: 14) {

                       

                        Image(systemName: method.icon)
                            .font(
                                .system(
                                    size: 19,
                                    weight: .semibold
                                )
                            )
                            .foregroundStyle(
                                FidyahTheme.maroon
                            )
                            .frame(
                                width: 42,
                                height: 42
                            )
                            .background(
                                FidyahTheme.cream
                            )
                            .clipShape(
                                RoundedRectangle(
                                    cornerRadius: 12
                                )
                            )


                        

                        VStack(
                            alignment: .leading,
                            spacing: 4
                        ) {

                            Text(method.title)
                                .font(
                                    .system(
                                        size: 15,
                                        weight: .semibold
                                    )
                                )
                                .foregroundStyle(.black)

                            Text(method.subtitle)
                                .font(
                                    .system(size: 11)
                                )
                                .foregroundStyle(
                                    FidyahTheme.secondaryText
                                )
                        }


                        Spacer()


                        ZStack {

                            Circle()
                                .stroke(
                                    selected
                                    ? FidyahTheme.maroon
                                    : Color.gray.opacity(0.3),
                                    lineWidth: 2
                                )
                                .frame(
                                    width: 21,
                                    height: 21
                                )


                            if selected {

                                Circle()
                                    .fill(
                                        FidyahTheme.maroon
                                    )
                                    .frame(
                                        width: 11,
                                        height: 11
                                    )
                            }
                        }
                    }
                    .padding(15)
                    .frame(
                        maxWidth: .infinity,
                        alignment: .leading
                    )
                    .background(Color.white)
                    .clipShape(
                        RoundedRectangle(
                            cornerRadius: 18
                        )
                    )
                    .overlay(
                        RoundedRectangle(
                            cornerRadius: 18
                        )
                        .stroke(
                            selected
                            ? FidyahTheme.maroon.opacity(0.3)
                            : FidyahTheme.border,
                            lineWidth: 1
                        )
                    )
                }
                .buttonStyle(.plain)
            }
    }


//#Preview {
    //paymentStructure()
//}
