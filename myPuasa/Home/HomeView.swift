//
//  HomeView.swift
//  myPuasa
//
//  Created by STDCX_MACBOOK PRO 32 on 09/08/2026.
//

import SwiftUI

struct HomeView: View {
    var body: some View {
        VStack {
            HStack{
                Text("Welcome back Harith")
                    .bold()
                    .padding(.top)
                    .frame(maxWidth: .infinity, alignment: .center)
                Spacer()
            }
            .padding(.bottom)
            
            
            
            
            VStack{
                HStack{
                    HStack {
                        ZStack{
                            
                            Circle()
                                .foregroundStyle(Color.black)
                                .frame(width: 70, height: 70)
                            Circle()
                                .foregroundStyle(Color.white)
                                .frame(width: 60, height: 70)
                            Text("7/14")
                        }
                        
                        
                        .font(.subheadline)
                        Text("Keep it up, don't give up!")
                            .padding(.leading)
                            .font(.subheadline)
                        Spacer()
                        
                    }
                    .padding()
                    .background(.pink, in:RoundedRectangle(cornerRadius: 15))
                    .frame(maxWidth: .infinity, alignment: .center)
                    
                }
                .font(.title)
                
                VStack {
                    HStack{
                        ZStack{
                            Circle()
                                .foregroundStyle(Color.black)
                                .frame(width: 350)
                            Circle()
                                .foregroundStyle(Color.white)
                                .frame(width: 260)
                            Text("Cycle Day")
                                .foregroundStyle(Color.black)
                                .bold()
                            
                        }
                        
                    }
                    .foregroundStyle(.blue)
                    
                    VStack{
                        
                        Text("Lorem")
                            .padding()
                        HStack{
                            Rectangle()
                                .frame(width: 30, height: 30)
                            Rectangle()
                                .frame(width: 30, height: 30)
                            Rectangle()
                                .frame(width: 30, height: 30)
                            Rectangle()
                                .frame(width: 30, height: 30)
                        }
                    }
                    
                }
                .padding()
                .background(.red)
                
            }
            
            
            
            HStack{
                VStack{
                    HStack{
                        Text("Fidyah Guideline")
                            .font(.title2)
                            .padding()
                        
                    }
                    
                    
                }
                .font(.title3)
            }
            
            Spacer()
        }
        
        
        
    }
}

#Preview {
    HomeView()
}
