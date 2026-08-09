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
            Image(systemName: "moon.fill")
                .imageScale(.large)
                .foregroundStyle(.red)
            Text("Welcom to myPuasa App")
            
        }
        
        .padding()
    }
}

#Preview {
    ContentView()
}
