//
//  FidyahView.swift
//  myPuasa
//
//  Created by STDCX_MACBOOK PRO 32 on 09/08/2026.
//

import SwiftUI

struct FidyahView: View {
    private let backgroundColor = Color(red: 250 / 255, green: 248 / 255, blue: 245 / 255)
    private let boxColor = Color(red: 237 / 255, green: 231 / 255, blue: 223 / 255)
    private let borderColor = Color(red: 221 / 255, green: 212 / 255, blue: 200 / 255)
    private let highlightColor = Color(red: 123 / 255, green: 45 / 255, blue: 63 / 255)
    
    var body: some View {
        NavigationStack {
            ZStack {
                backgroundColor
                    .ignoresSafeArea()
                
                ScrollView(showsIndicators: false) {
                    VStack(spacing: 16) {
                        Guideline_1_(boxColor: boxColor, borderColor: borderColor, highlightColor: highlightColor)
                        Guideline2(boxColor: boxColor, borderColor: borderColor, highlightColor: highlightColor)
                        Guideline3(boxColor: boxColor, borderColor: borderColor, highlightColor: highlightColor)
                        Guideline4(boxColor: boxColor, borderColor: borderColor, highlightColor: highlightColor)
                        Guideline5(boxColor: boxColor, borderColor: borderColor, highlightColor: highlightColor)
                        Spacer()
                    }
                    .padding(.horizontal, 20)
                    .padding(.bottom, 24)
                }
            }
            .navigationTitle("Fidyah Guideline")
        }
    }
}

#Preview {
    FidyahView()
}
