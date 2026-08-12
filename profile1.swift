//
//  profile1.swift
//  myPuasa
//
//  Created by STDCX_MACBOOK PRO 28 on 09/08/2026.
//

import SwiftUI

struct profile1: View {
    
    @State private var nama  = ""
    @State private var eMail = ""
    @State private var gender = ""
    @State private var state = ""
    
    
    var body: some View {
        VStack {
            
            HStack {
                Button {
                    print("Back")
                } label: {
                    Image(systemName: "chevron.left")
                        .font(.system(size: 24, weight: .medium))
                        .foregroundColor(.black)
                }
                
                Spacer()
                
                Button {
                    print("Edit")
                } label: {
                    Image(systemName: "square.and.pencil")
                        .font(.system(size: 23))
                        .foregroundColor(.black)
                }
            }
            .padding(.horizontal, 20)
        }
        
                
                
                Text("Welcome Back!")
                    .font(.largeTitle)
                    .fontWeight(.bold)
                    .padding(.bottom, 30)
        
        Image(systemName: "person.fill")
            .font(.system(size: 65))
            .foregroundColor(.gray)
            .frame(width: 100, height: 100)
            .background(Color.gray.opacity(0.15))
            .clipShape(Circle())
            .padding(.top, 15)
                
                VStack (spacing: 5){
                    Text("Name")
                    
                        .padding()
                        .frame(maxWidth: .infinity, maxHeight: 20, alignment: .leading)
                        .font(.title2)
                        .bold()
                    
                    
                    HStack{
                        
                        TextField ("  ", text: $nama)
                            .border(.black)
                    }
                    .padding()
                    
                }
            
                VStack (spacing: 5){
                    Text("Email")
                    
                        .padding()
                        .frame(maxWidth: .infinity, maxHeight: 20, alignment: .leading)
                        .font(.title2)
                        .bold()
                    
                    
                    HStack{
                        
                        TextField ("  ", text: $nama)
                            .border(.black)
                    }
                    .padding()
                    
                }
                VStack (spacing: 5){
                    Text("Gender")
                    
                        .padding()
                        .frame(maxWidth: .infinity, maxHeight: 20, alignment: .leading)
                        .font(.title2)
                        .bold()
                    
                    
                    HStack{
                        
                        TextField (" ", text: $nama)
                            .border(.black)
                    }
                    .padding()
                    
                }
                VStack (spacing: 5){
                    Text("State")
                    
                        .padding()
                        .frame(maxWidth: .infinity, maxHeight: 20, alignment: .leading)
                        .font(.title2)
                        .bold()
                    
                    
                    HStack{
                        
                        TextField (" ", text:$state)
                            .border(.black)
                    }
                    .padding()
                    
                }
                
                Button {
                    
                } label: {
                    Text("Add Card")
                        .font(.system(size: 17, weight: .bold))
                        .foregroundColor(.white)
                        .frame(maxWidth: .infinity)
                        .frame(height: 40)
                        .background(Color.black)
                        .cornerRadius(15)
                    
                }
                .padding()
                
                Button {
                    
                } label: {
                    Text("Log Out")
                        .font(.system(size: 17, weight: .bold))
                        .foregroundColor(.black)
                        .frame(maxWidth: .infinity)
                        .frame(height: 40)
                        .background(Color.white)
                        .cornerRadius(15)
                        .border(.black)
                    
                }
                .padding()
            }
            
            
        }
        


#Preview {
    profile1()
}
