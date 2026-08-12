//
//  ProfileView.swift
//  myPuasa
//

import SwiftUI

struct ProfileView: View {
    @State private var isEditing: Bool = false
    
    @State private var name: String = "Siti Nurul Balqis"
    @State private var email: String = "balqis@gmail.com"
    @State private var gender: String = "Female"
    @State private var selectedState: String = "Selangor"
    
    private let genderOptions: [String] = ["Male", "Female"]
    
    private let malaysianStates: [String] = [
        "Johor",
        "Kedah",
        "Kelantan",
        "Melaka",
        "Negeri Sembilan",
        "Pahang",
        "Perak",
        "Perlis",
        "Pulau Pinang",
        "Sabah",
        "Sarawak",
        "Selangor",
        "Terengganu",
        "Wilayah Persekutuan Kuala Lumpur",
        "Wilayah Persekutuan Labuan",
        "Wilayah Persekutuan Putrajaya"
    ]
    
    private let backgroundColor = Color(red: 250 / 255, green: 248 / 255, blue: 245 / 255)
    private let borderColor = Color(red: 221 / 255, green: 212 / 255, blue: 200 / 255)
    private let highlightColor = Color(red: 123 / 255, green: 45 / 255, blue: 63 / 255)
    
    var body: some View {
        NavigationStack {
            ZStack {
                backgroundColor
                    .ignoresSafeArea()
                
                ScrollView(showsIndicators: false) {
                    VStack(spacing: 20) {
                        // Header Bar
                        HStack {
                            Image(systemName: "arrow.left")
                                .font(.title3)
                                .fontWeight(.semibold)
                                .foregroundColor(.primary)
                                .opacity(0) // Spacer balance
                            
                            Spacer()
                            
                            Text("Welcome Back!")
                                .font(.title2)
                                .fontWeight(.bold)
                                .foregroundColor(.primary)
                            
                            Spacer()
                            
                            // Edit Mode Toggle Button
                            Button {
                                withAnimation(.spring(response: 0.3, dampingFraction: 0.7)) {
                                    isEditing.toggle()
                                }
                            } label: {
                                Image(systemName: isEditing ? "checkmark.circle.fill" : "square.and.pencil")
                                    .font(.title3)
                                    .fontWeight(.semibold)
                                    .foregroundColor(isEditing ? highlightColor : .primary)
                            }
                        }
                        .padding(.top, 4)
                        
                        // Profile Avatar
                        ZStack {
                            Circle()
                                .fill(Color(red: 237 / 255, green: 231 / 255, blue: 223 / 255))
                                .frame(width: 130, height: 130)
                                .shadow(color: Color.black.opacity(0.12), radius: 8, x: 0, y: 4)
                            
                            Image(systemName: "person.crop.circle.fill")
                                .resizable()
                                .scaledToFit()
                                .frame(width: 130, height: 130)
                                .foregroundColor(highlightColor)
                                .clipShape(Circle())
                        }
                        .padding(.vertical, 4)
                        
                        // Profile Information Fields
                        VStack(alignment: .leading, spacing: 16) {
                            // Name
                            VStack(alignment: .leading, spacing: 6) {
                                Text("Name")
                                    .font(.headline)
                                    .fontWeight(.bold)
                                TextField("Name", text: $name)
                                    .disabled(!isEditing)
                                    .font(.subheadline)
                                    .fontWeight(.medium)
                                    .padding(12)
                                    .background(Color.white)
                                    .clipShape(RoundedRectangle(cornerRadius: 16))
                                    .overlay(
                                        RoundedRectangle(cornerRadius: 16)
                                            .stroke(isEditing ? highlightColor : borderColor, lineWidth: 1)
                                    )
                            }
                            
                            // Email
                            VStack(alignment: .leading, spacing: 6) {
                                Text("Email")
                                    .font(.headline)
                                    .fontWeight(.bold)
                                TextField("Email", text: $email)
                                    .disabled(!isEditing)
                                    .font(.subheadline)
                                    .fontWeight(.medium)
                                    .padding(12)
                                    .background(Color.white)
                                    .clipShape(RoundedRectangle(cornerRadius: 16))
                                    .overlay(
                                        RoundedRectangle(cornerRadius: 16)
                                            .stroke(isEditing ? highlightColor : borderColor, lineWidth: 1)
                                    )
                            }
                            
                            // Gender Dropdown
                            VStack(alignment: .leading, spacing: 6) {
                                Text("Gender")
                                    .font(.headline)
                                    .fontWeight(.bold)
                                
                                Menu {
                                    ForEach(genderOptions, id: \.self) { option in
                                        Button {
                                            gender = option
                                        } label: {
                                            HStack {
                                                Text(option)
                                                if gender == option {
                                                    Image(systemName: "checkmark")
                                                }
                                            }
                                        }
                                    }
                                } label: {
                                    HStack {
                                        Text(gender)
                                            .font(.subheadline)
                                            .fontWeight(.medium)
                                            .foregroundColor(.primary)
                                        Spacer()
                                        if isEditing {
                                            Image(systemName: "chevron.down")
                                                .font(.footnote)
                                                .fontWeight(.bold)
                                                .foregroundColor(highlightColor)
                                        }
                                    }
                                    .padding(12)
                                    .background(Color.white)
                                    .clipShape(RoundedRectangle(cornerRadius: 16))
                                    .overlay(
                                        RoundedRectangle(cornerRadius: 16)
                                            .stroke(isEditing ? highlightColor : borderColor, lineWidth: 1)
                                    )
                                }
                                .disabled(!isEditing)
                            }
                            
                            // State Dropdown (All Malaysian States & Federal Territories)
                            VStack(alignment: .leading, spacing: 6) {
                                Text("State")
                                    .font(.headline)
                                    .fontWeight(.bold)
                                
                                Menu {
                                    ForEach(malaysianStates, id: \.self) { stateOption in
                                        Button {
                                            selectedState = stateOption
                                        } label: {
                                            HStack {
                                                Text(stateOption)
                                                if selectedState == stateOption {
                                                    Image(systemName: "checkmark")
                                                }
                                            }
                                        }
                                    }
                                } label: {
                                    HStack {
                                        Text(selectedState)
                                            .font(.subheadline)
                                            .fontWeight(.medium)
                                            .foregroundColor(.primary)
                                        Spacer()
                                        if isEditing {
                                            Image(systemName: "chevron.down")
                                                .font(.footnote)
                                                .fontWeight(.bold)
                                                .foregroundColor(highlightColor)
                                        }
                                    }
                                    .padding(12)
                                    .background(Color.white)
                                    .clipShape(RoundedRectangle(cornerRadius: 16))
                                    .overlay(
                                        RoundedRectangle(cornerRadius: 16)
                                            .stroke(isEditing ? highlightColor : borderColor, lineWidth: 1)
                                    )
                                }
                                .disabled(!isEditing)
                            }
                        }
                        
                        // Save Banner indicator when editing
                        if isEditing {
                            Button {
                                withAnimation {
                                    isEditing = false
                                }
                            } label: {
                                HStack {
                                    Image(systemName: "checkmark")
                                        .font(.subheadline)
                                        .bold()
                                    Text("Save Changes")
                                        .font(.subheadline)
                                        .fontWeight(.bold)
                                }
                                .foregroundColor(.white)
                                .frame(maxWidth: .infinity)
                                .padding(.vertical, 12)
                                .background(highlightColor)
                                .clipShape(Capsule())
                            }
                            .padding(.top, 4)
                        }
                        
                        // Action Buttons
                        VStack(spacing: 12) {
                            // Credit/Debit Card Button (Navigates to CardDetailView)
                            NavigationLink {
                                CardDetailView()
                            } label: {
                                HStack {
                                    Spacer()
                                    Text("Credit/Debit Card")
                                        .font(.headline)
                                        .fontWeight(.bold)
                                        .foregroundColor(.white)
                                    Spacer()
                                    Image(systemName: "arrow.shape.turn.up.forward.circle.fill")
                                        .font(.title3)
                                        .foregroundColor(Color.blue)
                                }
                                .padding(.horizontal, 16)
                                .padding(.vertical, 14)
                                .background(Color.black)
                                .clipShape(Capsule())
                            }
                            
                            // Log Out Button
                            Button {
                                // Log out action
                            } label: {
                                Text("Log Out")
                                    .font(.headline)
                                    .fontWeight(.bold)
                                    .foregroundColor(.white)
                                    .frame(maxWidth: .infinity)
                                    .padding(.vertical, 14)
                                    .background(highlightColor)
                                    .clipShape(Capsule())
                            }
                        }
                        .padding(.top, 6)
                    }
                    .padding(.horizontal, 20)
                    .padding(.bottom, 24)
                }
            }
        }
    }
}

#Preview {
    ProfileView()
}

