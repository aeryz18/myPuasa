//
//  profile2CardDetail.swift
//  myPuasa
//
//  Created by STDCX_MACBOOK PRO 28 on 09/08/2026.
//

import SwiftUI

struct profile2CardDetail: View {
    @State private var namecard = ""
    @State private var cardNum = ""
    @State private var month = ""
    @State private var year = ""
    @State private var cvv = ""
    
    var body: some View {
      
        Text("Card Detail")
            .font(.largeTitle)
            .fontWeight(.bold)
            .padding(.bottom, 5)
        
        Image(systemName:  "creditcard.fill")
            .font(.system(size: 55))
            .foregroundColor(.gray)
            .frame(width: 100, height: 100)
            .background(Color.gray.opacity(0.15))
            .clipShape(Circle())
            .padding(.bottom, 15)
        
        VStack (spacing: 10){
            Text("Name On Card")
            
                .padding()
                .frame(maxWidth: .infinity, maxHeight: 20, alignment: .leading)
                .font(.title2)
                .bold()
            
            
            HStack{
               
                TextField ("  ", text: $namecard)
                    .border(.black)
            }
            .padding()
            
        }
        
        VStack (spacing: 10){
            Text("Card Number")
            
                .padding()
                .frame(maxWidth: .infinity, maxHeight: 20, alignment: .leading)
                .font(.title2)
                .bold()
            
            
            HStack{
               
                TextField ("  ", text: $cardNum)
                    .border(.black)
            }
            .padding()
            
        }
        HStack (spacing: 10){
            Text("Month")
            
                .padding()
                .frame(maxWidth: .infinity, maxHeight: 20, alignment: .leading)
                .font(.title2)
                .bold()
            
            
            HStack{
                
                TextField ("  ", text: $cardNum)
                    .border(.black)
                    .frame(maxWidth: 100, maxHeight:20, alignment: .leading)
            }
            
            .padding()
        }
        HStack (spacing: 10){
            Text("Year")
            
                .padding()
                .frame(maxWidth: .infinity, maxHeight: 20, alignment: .leading)
                .font(.title2)
                .bold()
            
            
            HStack{
                
                TextField ("  ", text: $cardNum)
                    .border(.black)
                    .frame(maxWidth: 100, maxHeight:20, alignment: .leading)
            }
            
            .padding()
        }
        
        VStack (spacing: 10){
            Text("CVV")
            
                .padding()
                .frame(maxWidth: .infinity, maxHeight: 20, alignment: .leading)
                .font(.title2)
                .bold()
            
            
            HStack{
               
                TextField ("  ", text: $cardNum)
                    .border(.black)
                HStack{
                    Image(systemName:  "eye.slash")
                        .frame(width: 20)
                 
                }
            }
            .padding()
            
        }
        
        Button {
                      
                  } label: {
                      Text("Update Card")
                          .font(.system(size: 17, weight: .bold))
                          .foregroundColor(.white)
                          .frame(maxWidth: .infinity)
                          .frame(height: 55)
                          .background(Color.black)
                          .cornerRadius(15)
                      
                  }
                  .padding()
    }
}

#Preview {
    profile2CardDetail()
}
