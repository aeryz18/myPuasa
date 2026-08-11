//
//  HomeView.swift
//  myPuasa
//
//  Created by STDCX_MACBOOK PRO 32 on 09/08/2026.
//

/*
 backhround : Color(red: 250 / 255, green: 248 / 255, blue: 245 / 255)
 box : Color(red: 237 / 255, green: 231 / 255, blue: 223 / 255)
 border: Color(red: 221 / 255, green: 212 / 255, blue: 200 / 255)
 Highlight : Color(red: 123 / 255, green: 45 / 255, blue: 63 / 255)
 
 */

import SwiftUI

struct HomeView: View {
    var body: some View {
        NavigationStack {
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
                        NavigationLink{
                            PeriodView()
                        } label: {
                            HStack {
                                ZStack{
                                    VStack{
                                        Rectangle()
                                            .frame(width: 30, height: 30)
                                            .foregroundStyle(Color(red: 123 / 255, green: 45 / 255, blue: 63 / 255))
                                        Text("Menstrual")
                                    }
                                    
                                }
                                
                                
                                .font(.subheadline)
                                VStack {
                                Text("3 more day until next cycle")
                                    .padding(.leading)
                                    .font(.subheadline)
                                    .bold()
                                
                                    HStack {
                                        Text("Click to update")
                                            .font(.footnote)
                                    
                                    Image(systemName: "chevron.right")
                                            .font(.footnote)
                                            .bold()
                                    }
                                }
                                    
                                Spacer()
                                
                            }
                            .padding()
                            .background(Color(red: 237 / 255, green: 231 / 255, blue: 223 / 255), in:RoundedRectangle(cornerRadius: 15))
                            .frame(maxWidth: .infinity, alignment: .center)
                            .foregroundStyle(.black)
                        }
                        
                        
                    }
                    .font(.title)
                    
                    VStack {
                        HStack{
                            VStack {
                                ZStack{
                                    Circle()
                                        .foregroundStyle(Color(red: 123 / 255, green: 45 / 255, blue: 63 / 255))
                                        .frame(width: 350)
                                    Circle()
                                        .foregroundStyle(Color.white)
                                        .frame(width: 260)
                                    Text("7 / 14")
                                        .foregroundStyle(Color.black)
                                        .bold()
                                        .font(.largeTitle)
                                }
                            }
                            
                        }
                        .foregroundStyle(.blue)
                        
                        VStack{
                            Text("Keep it up, don't give up!")
                                .padding()
                                .font(.subheadline)
                                .bold()
                            
                            NavigationLink {
                                FastingView()//replace with fidyah guideline page
                            } label: {
                                HStack {
                                    Text("Update your fasting")
                                        .font(.footnote)
                                
                                Image(systemName: "chevron.right")
                                        .font(.footnote)
                                        .bold()
                                }
                                
                            }
                            .foregroundStyle(.black)
                            
                            
                        }
                        .font(.subheadline)
                        
                    }
                    .padding()
                    .background(Color(red: 237 / 255, green: 231 / 255, blue: 223 / 255))
                    
                }
                
                HStack{
                    VStack{
                        NavigationLink {
                            FidyahView()//replace with fidyah guideline page
                        } label: {
                            HStack{
                                Text("Fidyah Guideline")
                                    .font(.title2)
                                    .padding()
                                    .foregroundStyle(.black)
                                
                                
                                Image(systemName: "chevron.right")
                                    .foregroundColor(Color(red: 123 / 255, green: 45 / 255, blue: 63 / 255))
                                    .font(.title2)
                                    .bold()
                            }
                            .frame(maxWidth: .infinity, alignment: .center)
                            
                        }
                        
                        
                    }
                    .font(.title3)
                    
                }
                .background(Color(red: 237 / 255, green: 231 / 255, blue: 223 / 255))
                
                Spacer()
            }
        }
        
        
        
    }
}

#Preview {
    HomeView()
}
