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
    @State private var showMismatch = false
    
    private let backgroundColor = Color(red: 250 / 255, green: 248 / 255, blue: 245 / 255)
    private let borderColor = Color(red: 221 / 255, green: 212 / 255, blue: 200 / 255)
    private let highlightColor = Color(red: 123 / 255, green: 45 / 255, blue: 63 / 255)
    private let cardColor = Color(red: 237 / 255, green: 231 / 255, blue: 223 / 255)
    
    private var passwordsMatch: Bool {
        !passwordOri.isEmpty && passwordOri == passwordNew
    }
    
    var body: some View {
        ZStack {
            backgroundColor.ignoresSafeArea()
            
            ScrollView(showsIndicators: false) {
                VStack(spacing: 28) {
                    
                    VStack(spacing: 10) {
                        Image(systemName: "lock.shield.fill")
                            .font(.system(size: 52))
                            .foregroundColor(highlightColor)
                            .padding(.top, 40)
                        Text("Create Password")
                            .font(.system(size: 28, weight: .bold))
                        Text("Choose a secure password for your account")
                            .font(.subheadline).foregroundColor(.secondary)
                            .multilineTextAlignment(.center)
                    }
                    
                    VStack(spacing: 20) {
                        
                        // Password
                        VStack(alignment: .leading, spacing: 8) {
                            Text("Password").font(.headline).fontWeight(.bold)
                            HStack(spacing: 12) {
                                Image(systemName: "lock.fill").foregroundColor(highlightColor).frame(width: 20)
                                SecureField("Enter password", text: $passwordOri)
                            }
                            .padding(14)
                            .background(Color.white)
                            .clipShape(RoundedRectangle(cornerRadius: 16))
                            .overlay(RoundedRectangle(cornerRadius: 16).stroke(borderColor, lineWidth: 1))
                        }
                        
                        // Re-enter
                        VStack(alignment: .leading, spacing: 8) {
                            Text("Re-enter Password").font(.headline).fontWeight(.bold)
                            HStack(spacing: 12) {
                                Image(systemName: "lock.fill").foregroundColor(highlightColor).frame(width: 20)
                                SecureField("Re-enter password", text: $passwordNew)
                            }
                            .padding(14)
                            .background(Color.white)
                            .clipShape(RoundedRectangle(cornerRadius: 16))
                            .overlay(RoundedRectangle(cornerRadius: 16).stroke(borderColor, lineWidth: 1))
                        }
                        
                        // Create Account → directly back to login page
                        NavigationLink {
                            loginPage()
                                .navigationBarBackButtonHidden(true)
                        } label: {
                            Text("Create Account")
                                .font(.headline).fontWeight(.bold)
                                .foregroundColor(.white)
                                .frame(maxWidth: .infinity)
                                .padding(.vertical, 16)
                                .background(highlightColor)
                                .clipShape(Capsule())
                        }
                    }
                    .padding(24)
                    .background(cardColor)
                    .clipShape(RoundedRectangle(cornerRadius: 24))
                    .shadow(color: Color.black.opacity(0.06), radius: 12, x: 0, y: 4)
                    .padding(.horizontal, 20)
                    .padding(.bottom, 40)
                }
            }
        }
        .navigationTitle("Set Password")
        .navigationBarTitleDisplayMode(.inline)
    }
}

#Preview {
    NavigationStack { passwordPage() }
}
