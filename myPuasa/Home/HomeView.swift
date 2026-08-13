//
//  HomeView.swift
//  myPuasa
//
//  Created by STDCX_MACBOOK PRO 32 on 09/08/2026.
//

import SwiftUI

struct HomeView: View {
    @ObservedObject var fastingStore = FastingStore.shared
    
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
                        // Header / Greeting & Integrated Calendar Section
                        HomeHeaderView(userName: UserStore.shared.currentUser.name)
                        
                        // Featured Ads Banner Carousel
                        AdsCard(
                            boxColor: boxColor,
                            borderColor: borderColor,
                            highlightColor: highlightColor
                        )
                            
                        
                        // Separated Feature Cards
                        MenstrualStatusCard(
                            boxColor: boxColor,
                            borderColor: borderColor,
                            highlightColor: highlightColor
                        )
                        
                        FastingProgressCard(
                            completedDays: fastingStore.completedCount,
                            totalDays: fastingStore.totalCount,
                            boxColor: boxColor,
                            borderColor: borderColor,
                            highlightColor: highlightColor
                        )
                        
                        FidyahGuidelineCard(
                            boxColor: boxColor,
                            borderColor: borderColor,
                            highlightColor: highlightColor
                        )
                    }
                    .padding(.horizontal, 20)
                    .padding(.bottom, 24)
                }
            }
        }
    }
}

#Preview {
    HomeView()
}


