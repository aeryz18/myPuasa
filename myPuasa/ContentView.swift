//
//  ContentView.swift
//  myPuasa
//
//  Created by STDCX_MACBOOK PRO 32 on 09/08/2026.
//

import SwiftUI

struct ContentView: View {
    @ObservedObject var userStore = UserStore.shared
    @AppStorage("selectedTab") private var selectedTab: Int = 0

    private let highlightColor = Color(red: 123 / 255, green: 45 / 255, blue: 63 / 255)
    
    var body: some View {
        TabView(selection: $selectedTab) {
            HomeView()
                .tabItem { Label("Home", systemImage: "house.fill") }
                .tag(0)

            // Period tab — gender-aware
            periodTab
                .tabItem { Label("Period", systemImage: "drop.fill") }
                .tag(1)

            FastingView()
                .tabItem { Label("Fasting", systemImage: "moon.fill") }
                .tag(2)

            FidyahCalView()
                .tabItem { Label("Fidyah", systemImage: "book.closed.fill") }
                .tag(3)

            ProfileView()
                .tabItem { Label("Profile", systemImage: "person.fill") }
                .tag(4)
        }
        .tint(highlightColor)
    }
    
    @ViewBuilder
    private var periodTab: some View {
        if userStore.currentUser.gender == "Male" {
            if userStore.currentUser.hasPartner {
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
