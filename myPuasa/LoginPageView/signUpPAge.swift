//
//  signUpPAge.swift
//  myPuasa
//
//  Created by STDCX_MACBOOK PRO 28 on 09/08/2026.
//

import SwiftUI

struct signUpPAge: View {
    // Saved directly to UserDefaults via @AppStorage
    @AppStorage("userGender") private var userGender: String = "Female"
    @AppStorage("userName") private var userName: String = ""
    @AppStorage("userEmail") private var userEmail: String = ""
    
    @State private var fullNama = ""
    @State private var nomTel = ""
    @State private var email = ""
    @State private var gender = "Female"
    @State private var negeri = ""
    
    private let backgroundColor = Color(red: 250 / 255, green: 248 / 255, blue: 245 / 255)
    private let borderColor = Color(red: 221 / 255, green: 212 / 255, blue: 200 / 255)
    private let highlightColor = Color(red: 123 / 255, green: 45 / 255, blue: 63 / 255)
    private let cardColor = Color(red: 237 / 255, green: 231 / 255, blue: 223 / 255)
    
    private let malaysianStates: [String] = [
        "Johor", "Kedah", "Kelantan", "Melaka", "Negeri Sembilan",
        "Pahang", "Perak", "Perlis", "Pulau Pinang", "Sabah",
        "Sarawak", "Selangor", "Terengganu",
        "Wilayah Persekutuan Kuala Lumpur",
        "Wilayah Persekutuan Labuan",
        "Wilayah Persekutuan Putrajaya"
    ]
    
    var body: some View {
        ZStack {
            backgroundColor.ignoresSafeArea()
            
            ScrollView(showsIndicators: false) {
                VStack(spacing: 28) {
                    
                    VStack(spacing: 6) {
                        Text("Create Account")
                            .font(.system(size: 32, weight: .bold))
                        Text("Fill in your details to get started")
                            .font(.subheadline).foregroundColor(.secondary)
                    }
                    .padding(.top, 40)
                    
                    VStack(spacing: 20) {
                        
                        fieldView(label: "Full Name", icon: "person.fill",
                                  placeholder: "Enter your name", text: $fullNama)
                        
                        fieldView(label: "Phone Number", icon: "phone.fill",
                                  placeholder: "Enter your phone number", text: $nomTel,
                                  keyboard: .phonePad)
                        
                        fieldView(label: "Email", icon: "envelope.fill",
                                  placeholder: "Enter your email", text: $email,
                                  keyboard: .emailAddress)
                        
                        // Gender — segmented Picker saved to AppStorage
                        VStack(alignment: .leading, spacing: 8) {
                            Text("Gender")
                                .font(.headline).fontWeight(.bold)
                            Picker("Gender", selection: $gender) {
                                Text("Female").tag("Female")
                                Text("Male").tag("Male")
                            }
                            .pickerStyle(.segmented)
                        }
                        
                        // State dropdown
                        VStack(alignment: .leading, spacing: 8) {
                            Text("State")
                                .font(.headline).fontWeight(.bold)
                            Menu {
                                ForEach(malaysianStates, id: \.self) { state in
                                    Button(state) { negeri = state }
                                }
                            } label: {
                                HStack {
                                    Image(systemName: "globe").foregroundColor(highlightColor)
                                    Text(negeri.isEmpty ? "Select your state" : negeri)
                                        .foregroundColor(negeri.isEmpty ? .secondary : .primary)
                                    Spacer()
                                    Image(systemName: "chevron.down").font(.caption).foregroundColor(.secondary)
                                }
                                .padding(14)
                                .background(Color.white)
                                .clipShape(RoundedRectangle(cornerRadius: 16))
                                .overlay(RoundedRectangle(cornerRadius: 16).stroke(borderColor, lineWidth: 1))
                            }
                        }
                        
                        // Next — navigates directly without validation restrictions
                        NavigationLink {
                            passwordPage()
                        } label: {
                            Text("Next")
                                .font(.headline).fontWeight(.bold)
                                .foregroundColor(.white)
                                .frame(maxWidth: .infinity)
                                .padding(.vertical, 16)
                                .background(highlightColor)
                                .clipShape(Capsule())
                        }
                        .simultaneousGesture(TapGesture().onEnded {
                            userName = fullNama.isEmpty ? "User" : fullNama
                            userEmail = email
                            userGender = gender
                        })
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
        .navigationTitle("Sign Up")
        .navigationBarTitleDisplayMode(.inline)
    }
    
    @ViewBuilder
    private func fieldView(label: String, icon: String, placeholder: String,
                           text: Binding<String>, keyboard: UIKeyboardType = .default) -> some View {
        VStack(alignment: .leading, spacing: 8) {
            Text(label).font(.headline).fontWeight(.bold)
            HStack(spacing: 12) {
                Image(systemName: icon).foregroundColor(highlightColor).frame(width: 20)
                TextField(placeholder, text: text)
                    .keyboardType(keyboard)
                    .autocapitalization(keyboard == .emailAddress ? .none : .words)
            }
            .padding(14)
            .background(Color.white)
            .clipShape(RoundedRectangle(cornerRadius: 16))
            .overlay(RoundedRectangle(cornerRadius: 16).stroke(borderColor, lineWidth: 1))
        }
    }
}

#Preview {
    NavigationStack { signUpPAge() }
}
