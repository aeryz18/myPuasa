//
//  ContentView.swift
//  myPuasa
//
//  Created by STDCX_MACBOOK PRO 32 on 09/08/2026.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        VStack {
            TabView{
                FastingView()
                    .tabItem(){
                        Label("Fasting",systemImage: "moon.fill")
                    }

                CalendarView()
                    .tabItem(){
                        Label("Period",systemImage: "drop.fill")
                    }
                HomeView()
                    .tabItem(){
                        Label("Home",systemImage: "house.fill")
                    }
                FidyahView()
                    .tabItem(){
                        Label("Fidyah",systemImage: "circle")
                    }
                ProfileView()
                    .tabItem(){
                        Label("Profile",systemImage: "person.fill")
                    }
            }
            
        }
        
            }
}

#Preview {
    ContentView()
    
}
