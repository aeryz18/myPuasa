//
//  signUpPAge.swift
//  myPuasa
//
//  Created by STDCX_MACBOOK PRO 28 on 09/08/2026.
//

import SwiftUI

struct signUpPAge: View {
    @State private var fullNama = ""
    @State private var nomTel = ""
    @State private var email = ""
    @State private var gender = ""
    @State private var negeri = ""
    
    
    var body: some View {
        NavigationStack{
            VStack(spacing: 20) {
                
                Text("Account Registeration")
                    .font(.title)
                    .fontWeight(.bold)
                    .padding(.bottom, 30)
                    .underline()
                
            }
            
            VStack (spacing: 10){
                Text("Name")
                
                    .padding()
                    .frame(maxWidth: .infinity, maxHeight: 20, alignment: .leading)
                    .font(.title2)
                    .bold()
                
                
                HStack{
                    Image(systemName: "person")
                        .frame(width: 20)
                    TextField (" Enter your name ", text: $fullNama)
                        .border(.black)
                }
                .padding()
                
            }
            
            VStack (spacing: 10){
                Text("Phone Number")
                
                    .padding()
                    .frame(maxWidth: .infinity, maxHeight: 20, alignment: .leading)
                    .font(.title2)
                    .bold()
                
                
                HStack{
                    Image(systemName: "phone.fill")
                        .frame(width: 20)
                    TextField (" Enter your phone number", text: $nomTel)
                        .border(.black)
                }
                .padding()
                
            }
            
            VStack (spacing: 10){
                Text("Email")
                
                    .padding()
                    .frame(maxWidth: .infinity, maxHeight: 20, alignment: .leading)
                    .font(.title2)
                    .bold()
                
                
                HStack{
                    Image(systemName: "envelope.fill")
                        .frame(width: 20)
                    TextField (" Enter your email ", text: $email)
                        .border(.black)
                }
                .padding()
                
            }
            
            VStack (spacing: 10){
                Text("Gender")
                
                    .padding()
                    .frame(maxWidth: .infinity, maxHeight: 20, alignment: .leading)
                    .font(.title2)
                    .bold()
                
                
                HStack{
                    Image(systemName:  "bookmark.circle")
                        .frame(width: 20)
                    TextField (" Enter your gender ", text: $gender)
                        .border(.black)
                }
                .padding()
                
            }
            VStack (spacing: 10){
                Text("State")
                
                    .padding()
                    .frame(maxWidth: .infinity, maxHeight: 20, alignment: .leading)
                    .font(.title2)
                    .bold()
                
                
                HStack{
                    Image(systemName: "globe")
                        .frame(width: 20)
                    TextField (" Enter your state ", text: $negeri)
                        .border(.black)
                }
                .padding()
                
            }
            
            NavigationLink{
                passwordPage()
            } label: {
                Text("Next")
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
    signUpPAge()
}
