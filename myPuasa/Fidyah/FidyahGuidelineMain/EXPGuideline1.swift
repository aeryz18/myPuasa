//
//  EXPGuideline1.swift
//  myPuasa
//
//  Created by STDCX_MACBOOK PRO 28 on 11/08/2026.
//

import SwiftUI

struct EXPGuideline1: View {
    var body: some View {
        NavigationStack {
           
            
            
            ScrollView {
                
                VStack(alignment: .leading, spacing: 18) {
                    
                    Text("Who needs to pay fidyah?")
                        .font(.system(size: 18, weight: .bold))
                        .foregroundColor(.black)
                    
                    Text("""
                           1. Orang yang meninggalkan puasa Ramadhan kerana uzur syarie (musafir, haid atau nifas atau wiladah), sakit yang tiada harapan sembuh.
                           
                           2. Orang yang sakit yang tiada kemungkinan atau harapan untuk sembuh yang disahkan oleh doktor tidak boleh berpuasa.
                           
                           3. Ibu hamil atau yang masih menyusui anaknya yang tidak berpuasa di Bulan Ramadhan dengan sebab :
                           
                           a. Bimbang akan kesihatan dirinya dan janinnya / anaknya.
                           
                           4. Orang yang telah meninggal dunia dan tidak sempat menggantikan puasanya.
                           """)
                    .font(.system(size: 16))
                    .foregroundColor(.black)
                    .lineSpacing(6)
                }
                .padding(22)
                .frame(maxWidth: .infinity, alignment: .leading)
                .background(
                    RoundedRectangle(cornerRadius: 15)
                        .fill(Color(red: 0.95, green: 0.94, blue: 0.89))
                )
                .padding(.horizontal, 25)
                .padding(.top, 20)
                .padding(.bottom, 30)
            }
            
        }
    }
}

#Preview {
    EXPGuideline1()
}
