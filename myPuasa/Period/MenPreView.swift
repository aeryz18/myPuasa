//
//  MenPreView.swift
//  myPuasa
//
//  Created by STDCX_MACBOOK PRO 32 on 13/08/2026.
//

import SwiftUI

struct MenPreView: View {
    private let backgroundColor = Color(red: 250 / 255, green: 248 / 255, blue: 245 / 255)
    private let burgundyColor = Color(red: 153 / 255, green: 70 / 255, blue: 88 / 255)
    private let circleOverlayColor = Color(red: 123 / 255, green: 45 / 255, blue: 63 / 255)
    
    var body: some View {
        ZStack {
            backgroundColor.ignoresSafeArea()
            Spacer()
            VStack {
                
                ZStack {
                    UnevenRoundedRectangle(
                        cornerRadii: RectangleCornerRadii(
                            topLeading: 180,
                            bottomLeading: 0,
                            bottomTrailing: 0,
                            topTrailing: 180
                        )
                    )
                    .fill(burgundyColor)
                    .frame(maxWidth: .infinity)
                    .frame(height: 650)
                    
                    VStack(spacing: 0) {
                        Spacer()
                            .frame(height: 200)
                        
                        Text("Period Tracker")
                            .font(.system(size: 26, weight: .bold))
                            .foregroundColor(.white)
                        
                        Spacer()
                            .frame(height: 24)
                        
                        Image(systemName: "drop.fill")
                            .font(.system(size: 54))
                            .foregroundColor(.white)
                        
                        Spacer()
                        
                        Text("Add your partner")
                            .font(.system(size: 20, weight: .bold))
                            .foregroundColor(.white)
                            .padding(.bottom, 24)
                        
                        NavigationLink {
                            AddPartnerPage()
                        } label: {
                            ZStack {
                                Circle()
                                    .fill(circleOverlayColor.opacity(0.6))
                                    .frame(width: 50, height: 50)
                                Image(systemName: "plus")
                                    .font(.system(size: 45, weight: .bold))
                                    .foregroundColor(.white)
                            }
                        }
                        
                        Spacer().frame(height: 100)
                    }
                }
                .ignoresSafeArea(edges: .bottom)
            }
            
        }
    }
}

#Preview {
    MenPreView()
}
