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
            Text("lets full fill our duty as a Muslim")
                .padding(.top)
                .font(.caption2)
            
        }
        
        .padding()
    }
}

#Preview {
    ContentView()
}
