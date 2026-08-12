//
//  ContentView.swift
//  myPuasa
//
//  Created by STDCX_MACBOOK PRO 32 on 09/08/2026.
//

import SwiftUI

struct ContentView: View {
    private let highlightColor = Color(red: 123 / 255, green: 45 / 255, blue: 63 / 255)
    
    var body: some View {
        //<<<<<<< HEAD
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
            /*
             =======
             TabView {
             FastingView()
             .tabItem {
             Label("Fasting", systemImage: "moon.fill")
             }
             
             PeriodView()
             .tabItem {
             Label("Period", systemImage: "drop.fill")
             }
             
             HomeView()
             .tabItem {
             Label("Home", systemImage: "house.fill")
             }
             
             FidyahView()
             .tabItem {
             Label("Fidyah", systemImage: "book.closed.fill")
             }
             
             ProfileView()
             .tabItem {
             Label("Profile", systemImage: "person.fill")
             }
             >>>>>>> main
             }
             .foregroundStyle(.tint(highlightColor)
             }
             */
        }
    }
}
        
        #Preview {
            ContentView()
        }
        
    

