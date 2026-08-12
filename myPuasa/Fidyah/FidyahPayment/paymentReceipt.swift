//
//  paymentReceipt.swift
//  myPuasa
//
//  Created by STDCX_MACBOOK PRO 28 on 11/08/2026.
//

import SwiftUI

struct paymentReceipt: View {
    var body: some View {
        HStack {
            Button(action: {
                print("Back tapped")
            }) {
                Image(systemName: "chevron.left")
                    .font(.system(size: 14, weight: .medium))
                    .foregroundColor(.black)
                    .frame(width: 30, height: 30)
                    .background(
                        Circle()
                            .stroke(Color.black.opacity(0.4), lineWidth: 1)
                    )
            }
            
            Spacer()
        }
        .padding(.horizontal, 22)
        .padding(.top, 12)
        
        
        ZStack {
            Circle()
                .fill(Color(red: 0.72, green: 0.86, blue: 0.55))
                .frame(width: 150, height: 150)
            
            Image(systemName: "checkmark")
                .font(.system(size: 75, weight: .bold))
                .foregroundColor(Color(red: 0.25, green: 0.39, blue: 0.15))
        }
        .padding(.top, 20)
        // .background(FidyahTheme.cream)
        
        VStack(spacing: 8){
            Text("Alhamdulillah!")
                .font(.system(size: 20, weight: .bold))
            
            Text("Your fidyah has been recorded!")
                .font(.system(size: 19, weight: .bold))
            
        }
        
        VStack(spacing: 15) {
            
            HStack {
                Text("Amount Paid")
                Spacer()
                Text("RM 0")
            }

            HStack {
                Text("Payment Method")
                Spacer()
                Text("")
            }

            HStack {
                Text("Date")
                Spacer()
                Text("")
            }

            HStack {
                Text("Reference No.")
                Spacer()
                Text("FIDYAH24262")
            }
        }
        .padding()
        .background(
            RoundedRectangle(cornerRadius: 18)
                .fill(Color(red: 0.89, green: 0.87, blue: 0.79))
        )
        
        Button(action: {
                             print("Done")
                         }) {
                             Text("Done")
                                 .font(.system(size: 17, weight: .bold))
                                 .foregroundColor(.white)
                                 .frame(maxWidth: .infinity)
                                 .frame(height: 52)
                                 .background(
                                     RoundedRectangle(cornerRadius: 25)
                                         .fill(Color(red: 0.08, green: 0.52, blue: 0.15))
                                 )
                         }
                         .padding(.horizontal, 22)
                         .padding(.top, 25)
                         .padding(.bottom, 30)
                     }
                 }
 
#Preview {
    paymentReceipt()
}
