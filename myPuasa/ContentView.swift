//
//  ContentView.swift
//  myPuasa
//
//  Created by STDCX_MACBOOK PRO 32 on 09/08/2026.
//

import SwiftUI

struct ContentView: View {
    @AppStorage("userGender") private var userGender: String = "Female"
    @AppStorage("hasPartner") private var hasPartner: Bool = false

    private let highlightColor = Color(red: 123 / 255, green: 45 / 255, blue: 63 / 255)
    
    var body: some View {
        TabView {
            HomeView()
                .tabItem { Label("Home", systemImage: "house.fill") }

            // Period tab — gender-aware
            periodTab
                .tabItem { Label("Period", systemImage: "drop.fill") }

            FastingView()
                .tabItem { Label("Fasting", systemImage: "moon.fill") }

            FidyahCalView()
                .tabItem { Label("Fidyah", systemImage: "book.closed.fill") }

            ProfileView()
                .tabItem { Label("Profile", systemImage: "person.fill") }
        }
        .tint(highlightColor)
    }
    
    @ViewBuilder
    private var periodTab: some View {
        if userGender == "Male" {
            if hasPartner {
                NavigationStack { PartnerPeriodView() }
            } else {
                NavigationStack { MenPreView() }
            }
        } else {
            CalendarView()
        }
    }
}

#Preview {
    ContentView()
}
