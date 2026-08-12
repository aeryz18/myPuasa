//
//  FidyahView.swift
//  myPuasa
//
//  Created by STDCX_MACBOOK PRO 32 on 09/08/2026.
//

import SwiftUI

struct FidyahView: View {
    var body: some View {
        NavigationStack {
            VStack {
                /*Text("Fidyah Guideline")
                    .font(.title)
                    .bold()
                    .underline()*/
                
                ScrollView{
                    Guideline_1_(boxColor: Color(red: 237 / 255, green: 231 / 255, blue: 223 / 255),
                                 borderColor: Color(red: 221 / 255, green: 212 / 255, blue: 200 / 255),
                                 highlightColor: Color(red: 123 / 255, green: 45 / 255, blue: 63 / 255
                   ))
                    Guideline2(boxColor: Color(red: 237 / 255, green: 231 / 255, blue: 223 / 255),
                               borderColor: Color(red: 221 / 255, green: 212 / 255, blue: 200 / 255),
                               highlightColor: Color(red: 123 / 255, green: 45 / 255, blue: 63 / 255
                 ))
                    Guideline3(boxColor: Color(red: 237 / 255, green: 231 / 255, blue: 223 / 255),
                               borderColor: Color(red: 221 / 255, green: 212 / 255, blue: 200 / 255),
                               highlightColor: Color(red: 123 / 255, green: 45 / 255, blue: 63 / 255
                 ))
                    Guideline4(boxColor: Color(red: 237 / 255, green: 231 / 255, blue: 223 / 255),
                               borderColor: Color(red: 221 / 255, green: 212 / 255, blue: 200 / 255),
                               highlightColor: Color(red: 123 / 255, green: 45 / 255, blue: 63 / 255
                 ))
                    Guideline5(boxColor: Color(red: 237 / 255, green: 231 / 255, blue: 223 / 255),
                               borderColor: Color(red: 221 / 255, green: 212 / 255, blue: 200 / 255),
                               highlightColor: Color(red: 123 / 255, green: 45 / 255, blue: 63 / 255
                 ))
                    Spacer()
                    
                }
                
            }
        }
        .navigationTitle("Fidyah Guideline")
        
    }
}

#Preview {
    FidyahView()
}
