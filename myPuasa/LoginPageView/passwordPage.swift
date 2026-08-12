//
//  passwordPage.swift
//  myPuasa
//
//  Created by STDCX_MACBOOK PRO 28 on 09/08/2026.
//

import SwiftUI

struct passwordPage: View {
    @State private var passwordOri = ""
    @State private var passwordNew = ""
    
    var body: some View {
        NavigationStack {
            VStack {
                
                Text("Create your Password")
                    .font(.title)
                    .fontWeight(.bold)
                    .padding(.top)
                    .underline()
                
            }
            
            
            VStack {
                Text("Enter password")
                
                    .padding()
                    .frame(maxWidth: .infinity, maxHeight: 20, alignment: .leading)
                    .font(.title2)
                    .bold()
                
                
                HStack{
                    
                    
                    TextField ("  ", text: $passwordOri)
                        .border(.blue)
                }
                .padding()
                
            }
            
            VStack (spacing: 10){
                Text("Re-enter the password")
                
                    .padding()
                    .frame(maxWidth: .infinity, maxHeight: 20, alignment: .leading)
                    .font(.title2)
                    .bold()
                
                
                HStack{
                    
                    TextField (" ", text: $passwordNew)
                        .border(.blue)
                }
                .padding()
                
            }
            
            
            
            NavigationLink {
                loginPage()
            } label: {
                Text("Create Account")
                    .font(.system(size: 17, weight: .bold))
                    .foregroundColor(.white)
                    .frame(maxWidth: .infinity)
                    .frame(height: 55)
                    .background(Color.blue)
                    .cornerRadius(15)
                
            }
            .padding()
        }
    }
    
}

#Preview {
    passwordPage()
}
