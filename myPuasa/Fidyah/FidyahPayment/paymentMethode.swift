//
//  paymentMethode.swift
//  myPuasa
//
//  Created by STDCX_MACBOOK PRO 28 on 11/08/2026.
//

//import SwiftUI

//struct paymentMethode: View {
    //var body: some View {
        
        enum PaymentMethod: String, CaseIterable, Identifiable {

            case onlineBanking
            case tng
            case duitNow
            case card

            var id: String {
                rawValue
            }

            var title: String {

                switch self {

                case .onlineBanking:
                    return "Online Banking"

                case .tng:
                    return "TnG eWallet"

                case .duitNow:
                    return "QR DuitNow"

                case .card:
                    return "Credit/Debit Card"
                }
            }

            var subtitle: String {

                switch self {

                case .onlineBanking:
                    return "FPX Online Banking"

                case .tng:
                    return "Touch 'n Go eWallet"

                case .duitNow:
                    return "Scan QR to pay"

                case .card:
                    return "Visa / Mastercard"
                }
            }

            var icon: String {

                switch self {

                case .onlineBanking:
                    return "building.columns.fill"

                case .tng:
                    return "wallet.pass.fill"

                case .duitNow:
                    return "qrcode"

                case .card:
                    return "creditcard.fill"
                }
            }
    }

