//
//  loginPage.swift
//  myPuasa
//
//  Created by STDCX_MACBOOK PRO 28 on 09/08/2026.
//

import SwiftUI

struct loginPage: View {
    @State private var emaiL = ""
    @State private var password = ""
    
    
    var body: some View {
        NavigationStack{
            
            VStack{
                
               // Image("myPuasaLogo")
                
                
            }
            .padding(50)
            
            VStack (spacing: 10){
                Text("Email")
                    .padding()
                    .frame(maxWidth: .infinity, maxHeight: 20, alignment: .leading)
                    .font(.title)
                    .bold()
                
                
                HStack{
                    Image(systemName: "envelope.fill")
                        .frame(width: 20)
                    TextField (" Enter your email ", text: $emaiL)
                        .border(.blue)
                }
                .padding()
                
                
            }
            
            VStack (spacing: 10){
                Text("Password")
                    .padding()
                    .frame(maxWidth: .infinity, maxHeight: 10, alignment: .leading)
                    .font(.title)
                    .bold()
                
                HStack{
                    Image(systemName: "lock.fill")
                        .frame(width: 20)
                    TextField (" Enter your password ", text: $password)
                        .border(.blue)
                }
                .padding()
                
                NavigationLink {
                    HomeView()
                } label: {
                    Text("Login")
                        .font(.system(size: 17, weight: .bold))
                        .foregroundColor(.white)
                        .frame(maxWidth: .infinity)
                        .frame(height: 55)
                        .background(Color.blue)
                        .cornerRadius(15)
                    
                }
                .padding()
                
                
                Button {
                    
                } label: {
                    Text("Forgot your password")
                        .font(.system(size: 17, weight: .bold))
                        .foregroundColor(.black)
                        .frame(maxWidth: .infinity)
                        .frame(height: 55)
                        .background(Color.white)
                        .cornerRadius(15)
                        .border(Color.black)
                }
                .padding()
                
                
                HStack(spacing: 4){
                    Text("Don't have any account?")
                    
                    NavigationLink{
                    signUpPAge()
                        
                    } label: {
                        Text("Sign Up")
                            .foregroundColor(.blue)
                    }
                    
                }
                
                .padding(.top, 25)
                
                
                HStack {
                    Rectangle()
                        .frame(height: 1)
                        .foregroundColor(.gray)
                    
                    Text("OR")
                        .font(.system(size: 12, weight: .bold))
                        .foregroundColor(.gray)
                    
                    Rectangle()
                        .frame(height: 1)
                        .foregroundColor(.gray)
                }
                .padding(.top, 20)
                
            }
            HStack(spacing: 20) {
                
                
                Button {
                    
                } label: {
                    HStack {
                        Text("G")
                            .font(.system(size: 32, weight: .bold))
                            .foregroundColor(.black)
                        
                        Text("Google")
                            .font(.system(size: 15, weight: .semibold))
                            .foregroundColor(.black)
                    }
                    .frame(maxWidth: .infinity)
                    .frame(height: 75)
                    .background(Color.white)
                    .overlay(
                        RoundedRectangle(cornerRadius: 15)
                            .stroke(Color.gray.opacity(0.25), lineWidth: 1)
                    )
                }
                
                Button {
                    
                } label: {
                    HStack {
                        Image(systemName: "apple.logo")
                            .font(.system(size: 32))
                            .foregroundColor(.black)
                        
                        Text("Apple")
                            .font(.system(size: 15, weight: .semibold))
                            .foregroundColor(.black)
                    }
                    .frame(maxWidth: .infinity)
                    .frame(height: 75)
                    .background(Color.white)
                    .overlay(
                        RoundedRectangle(cornerRadius: 15)
                            .stroke(Color.gray.opacity(0.25), lineWidth: 1)
                    )
                }
            }
            
        }
        
    }
    
}
    #Preview {
        loginPage()
    }

