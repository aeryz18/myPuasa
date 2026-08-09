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
                ProfileView()
                    .tabItem(){
                        Label("Profile",systemImage: "person.fill")
                    }
            }
            
        }
        
        .padding()
    }
}

#Preview {
    ContentView()
}
