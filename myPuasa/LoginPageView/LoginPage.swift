//
//  LoginPage.swift
//  myPuasa
//
//  Created by STDCX_MACBOOK PRO 28 on 09/08/2026.
//

import SwiftUI

struct loginPage: View {
    @AppStorage("isLoggedIn") private var isLoggedIn: Bool = false
    @AppStorage("selectedTab") private var selectedTab: Int = 0
    
    
    
    @State private var emaiL = ""
    @State private var password = ""
    
    private let backgroundColor = Color(red: 250 / 255, green: 248 / 255, blue: 245 / 255)
    private let borderColor = Color(red: 221 / 255, green: 212 / 255, blue: 200 / 255)
    private let highlightColor = Color(red: 123 / 255, green: 45 / 255, blue: 63 / 255)
    private let cardColor = Color(red: 237 / 255, green: 231 / 255, blue: 223 / 255)
    
    var body: some View {
        ZStack {
            backgroundColor.ignoresSafeArea()
            
            ScrollView(showsIndicators: false) {
                VStack(spacing: 28) {
                    
                    // App Logo & Header
                    VStack(spacing: 14) {
                        Image("AppLogo")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 90, height: 90)
                            .clipShape(RoundedRectangle(cornerRadius: 22))
                            .shadow(color: highlightColor.opacity(0.35), radius: 12, x: 0, y: 6)
                        
                        
                        VStack(spacing: 4) {
                            Text("Assalamualaikum")
                                .font(.system(size: 24, weight: .bold))
                                .foregroundColor(.primary)
                                .padding(.top, 5)
                            Text("Log in to your account")
                                .font(.subheadline)
                                .foregroundColor(.secondary)
                        }
                    }
                    .padding(.top, 40)
                    
                    // Form Card
                    VStack(spacing: 20) {
                        
                        // Email field
                        VStack(alignment: .leading, spacing: 8) {
                            Text("Email")
                                .font(.headline).fontWeight(.bold)
                            HStack(spacing: 12) {
                                Image(systemName: "envelope.fill")
                                    .foregroundColor(highlightColor).frame(width: 20)
                                TextField("Enter your email", text: $emaiL)
                                    .keyboardType(.emailAddress)
                                    .autocapitalization(.none)
                            }
                            .padding(14)
                            .background(Color.white)
                            .clipShape(RoundedRectangle(cornerRadius: 16))
                            .overlay(RoundedRectangle(cornerRadius: 16).stroke(borderColor, lineWidth: 1))
                        }
                        
                        // Password field
                        VStack(alignment: .leading, spacing: 8) {
                            Text("Password")
                                .font(.headline).fontWeight(.bold)
                            HStack(spacing: 12) {
                                Image(systemName: "lock.fill")
                                    .foregroundColor(highlightColor).frame(width: 20)
                                SecureField("Enter your password", text: $password)
                            }
                            .padding(14)
                            .background(Color.white)
                            .clipShape(RoundedRectangle(cornerRadius: 16))
                            .overlay(RoundedRectangle(cornerRadius: 16).stroke(borderColor, lineWidth: 1))
                        }
                        
                        // Forgot password
                        HStack {
                            Spacer()
                            Button("Forgot your password?") {}
                                .font(.footnote)
                                .foregroundColor(highlightColor)
                        }
                        
                        // Login Button — matches typed credentials to demo user or creates session
                        Button {
                            let trimmedEmail = emaiL.trimmingCharacters(in: .whitespacesAndNewlines).lowercased()
                            
                            if trimmedEmail.contains("balqis") || trimmedEmail == "balqis@gmail.com" {
                                UserStore.shared.switchUser(.demoFemale)
                            } else if trimmedEmail.contains("ahmad") || trimmedEmail == "ahmad@gmail.com" {
                                UserStore.shared.switchUser(.demoMale)
                            } else {
                                var newUser = User.guest
                                newUser.email = emaiL.isEmpty ? "user@mypuasa.com" : emaiL
                                newUser.password = password.isEmpty ? "123" : password
                                let defaultName = emaiL.components(separatedBy: "@").first?.capitalized ?? "User"
                                newUser.name = defaultName.isEmpty ? "User" : defaultName
                                UserStore.shared.switchUser(newUser)
                            }
                            
                            selectedTab = 0
                            isLoggedIn = true
                        } label: {
                            Text("Login")
                                .font(.headline).fontWeight(.bold)
                                .foregroundColor(.white)
                                .frame(maxWidth: .infinity)
                                .padding(.vertical, 16)
                                .background(highlightColor)
                                .clipShape(Capsule())
                                .shadow(color: highlightColor.opacity(0.3), radius: 6, x: 0, y: 3)
                        }
                        
                        // Sign Up link
                        HStack(spacing: 4) {
                            Text("Don't have an account?")
                                .foregroundColor(.secondary)
                                .font(.subheadline)
                            NavigationLink {
                                signUpPAge()
                            } label: {
                                Text("Sign Up")
                                    .font(.subheadline).fontWeight(.bold)
                                    .foregroundColor(highlightColor)
                            }
                        }
                    }
                    .padding(24)
                    .background(cardColor)
                    .clipShape(RoundedRectangle(cornerRadius: 24))
                    .shadow(color: Color.black.opacity(0.06), radius: 12, x: 0, y: 4)
                    .padding(.horizontal, 20)
                    
                    // OR divider
                    HStack {
                        Rectangle().frame(height: 1).foregroundColor(.gray.opacity(0.3))
                        Text("OR").font(.caption).fontWeight(.bold).foregroundColor(.secondary)
                        Rectangle().frame(height: 1).foregroundColor(.gray.opacity(0.3))
                    }
                    .padding(.horizontal, 32)
                    
                    // Social buttons
                    HStack(spacing: 16) {
                        socialButton(label: "Apple", systemImage: "apple.logo")
                    }
                    .padding(.horizontal, 20)
                    .padding(.bottom, 40)
                }
            }
        }
        .navigationBarHidden(true)
    }
    
    @ViewBuilder
    private func socialButton(label: String, icon: String? = nil, systemImage: String? = nil) -> some View {
        Button {} label: {
            HStack(spacing: 8) {
                if let icon = icon {
                    Text(icon).font(.system(size: 20, weight: .bold)).foregroundColor(.black)
                } else if let systemImage = systemImage {
                    Image(systemName: systemImage).font(.system(size: 20)).foregroundColor(.black)
                }
                Text(label).font(.subheadline).fontWeight(.semibold).foregroundColor(.black)
            }
            .frame(maxWidth: .infinity).frame(height: 52)
            .background(Color.white)
            .clipShape(RoundedRectangle(cornerRadius: 16))
            .overlay(RoundedRectangle(cornerRadius: 16).stroke(borderColor, lineWidth: 1))
        }
    }
}

#Preview {
    NavigationStack { loginPage() }
}
