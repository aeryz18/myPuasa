//
//  CardDetailView.swift
//  myPuasa
//

import SwiftUI

struct CardDetailView: View {
    @Environment(\.dismiss) private var dismiss
    
    @State private var isEditing: Bool = false
    
    @State private var nameOnCard: String = "Siti Nurul Balqis"
    @State private var cardNumber: String = "9855-1002-8559-0099"
    @State private var month: String = "January"
    @State private var year: String = "2079"
    @State private var cvv: String = "123"
    @State private var isCVVHidden: Bool = true
    
    private let months: [String] = [
        "January", "February", "March", "April", "May", "June",
        "July", "August", "September", "October", "November", "December"
    ]
    
    private let years: [String] = [
        "2024", "2025", "2026", "2027", "2028", "2029", "2030",
        "2031", "2032", "2033", "2034", "2035", "2079"
    ]
    
    private let backgroundColor = Color(red: 250 / 255, green: 248 / 255, blue: 245 / 255)
    private let borderColor = Color(red: 221 / 255, green: 212 / 255, blue: 200 / 255)
    private let highlightColor = Color(red: 123 / 255, green: 45 / 255, blue: 63 / 255)
    
    var body: some View {
        ZStack {
            backgroundColor
                .ignoresSafeArea()
            
            ScrollView(showsIndicators: false) {
                VStack(spacing: 20) {
                    // Header Bar
                    HStack {
                        Button {
                            dismiss()
                        } label: {
                            Image(systemName: "arrow.left")
                                .font(.title3)
                                .fontWeight(.semibold)
                                .foregroundColor(.primary)
                        }
                        
                        Spacer()
                        
                        Text("Card Detail")
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
                    
                    // Card Visual Previews (Front & Back Side-by-Side)
                    HStack(spacing: 12) {
                        // Front Card Preview
                        ZStack(alignment: .topLeading) {
                            RoundedRectangle(cornerRadius: 12)
                                .fill(Color(white: 0.18))
                            
                            VStack(alignment: .leading, spacing: 6) {
                                HStack {
                                    Spacer()
                                    Text("BANK")
                                        .font(.system(size: 10, weight: .bold))
                                        .foregroundColor(.white.opacity(0.8))
                                }
                                
                                // Chip
                                RoundedRectangle(cornerRadius: 3)
                                    .fill(Color(red: 230/255, green: 190/255, blue: 70/255))
                                    .frame(width: 24, height: 18)
                                    .padding(.top, 2)
                                
                                Text(cardNumber.isEmpty ? "•••• •••• •••• ••••" : cardNumber)
                                    .font(.system(size: 9, weight: .semibold, design: .monospaced))
                                    .foregroundColor(.white)
                                    .lineLimit(1)
                                
                                HStack {
                                    Spacer()
                                    Text("\(month.prefix(3))/\(year.suffix(2))")
                                        .font(.system(size: 7, weight: .medium))
                                        .foregroundColor(.white.opacity(0.7))
                                }
                                
                                Spacer(minLength: 0)
                                
                                Text(nameOnCard.isEmpty ? "CARDHOLDER NAME" : nameOnCard.uppercased())
                                    .font(.system(size: 8, weight: .bold))
                                    .foregroundColor(.white.opacity(0.9))
                                    .lineLimit(1)
                            }
                            .padding(10)
                        }
                        .frame(height: 105)
                        
                        // Back Card Preview
                        ZStack(alignment: .top) {
                            RoundedRectangle(cornerRadius: 12)
                                .fill(Color(white: 0.18))
                            
                            VStack(spacing: 6) {
                                // Magnetic Strip
                                Rectangle()
                                    .fill(Color.black)
                                    .frame(height: 22)
                                    .padding(.top, 8)
                                
                                HStack {
                                    Text("AUTHORIZED SIGNATURE")
                                        .font(.system(size: 4))
                                        .foregroundColor(.white.opacity(0.5))
                                    Spacer()
                                }
                                .padding(.horizontal, 10)
                                
                                HStack {
                                    Spacer()
                                    ZStack {
                                        Rectangle()
                                            .fill(Color.white.opacity(0.9))
                                            .frame(height: 18)
                                        Text(isCVVHidden ? "***" : (cvv.isEmpty ? "CVV" : cvv))
                                            .font(.system(size: 9, weight: .bold, design: .monospaced))
                                            .foregroundColor(.black)
                                    }
                                    .frame(width: 48)
                                }
                                .padding(.horizontal, 10)
                                
                                Spacer(minLength: 0)
                            }
                        }
                        .frame(height: 105)
                    }
                    .padding(.top, 6)
                    
                    Text("Please make sure your details is correct.")
                        .font(.caption)
                        .foregroundColor(.secondary)
                    
                    // Quick Action: Fill Blank Form
                    Button {
                        withAnimation {
                            nameOnCard = ""
                            cardNumber = ""
                            month = "January"
                            year = "2026"
                            cvv = ""
                            isEditing = true
                        }
                    } label: {
                        HStack(spacing: 6) {
                            Image(systemName: "plus.circle.fill")
                                .font(.subheadline)
                            Text("Fill Empty Card Form")
                                .font(.subheadline)
                                .fontWeight(.bold)
                        }
                        .foregroundColor(highlightColor)
                        .padding(.vertical, 10)
                        .frame(maxWidth: .infinity)
                        .background(highlightColor.opacity(0.12))
                        .clipShape(Capsule())
                    }
                    
                    // Input Fields
                    VStack(alignment: .leading, spacing: 16) {
                        // Name On Card
                        VStack(alignment: .leading, spacing: 6) {
                            Text("Name On Card")
                                .font(.headline)
                                .fontWeight(.bold)
                            TextField("Name On Card", text: $nameOnCard)
                                .disabled(!isEditing)
                                .font(.subheadline)
                                .fontWeight(.medium)
                                .padding(12)
                                .background(Color.white)
                                .clipShape(RoundedRectangle(cornerRadius: 16))
                                .overlay(
                                    RoundedRectangle(cornerRadius: 16)
                                        .stroke(isEditing ? Color.black : borderColor, lineWidth: 1)
                                )
                        }
                        
                        // Card Number
                        VStack(alignment: .leading, spacing: 6) {
                            Text("Card Number")
                                .font(.headline)
                                .fontWeight(.bold)
                            TextField("Card Number", text: $cardNumber)
                                .disabled(!isEditing)
                                .font(.subheadline)
                                .fontWeight(.medium)
                                .padding(12)
                                .background(Color.white)
                                .clipShape(RoundedRectangle(cornerRadius: 16))
                                .overlay(
                                    RoundedRectangle(cornerRadius: 16)
                                        .stroke(isEditing ? Color.black : borderColor, lineWidth: 1)
                                )
                        }
                        
                        // Month & Year Side-by-Side Dropdowns
                        HStack(spacing: 12) {
                            // Month Dropdown
                            VStack(alignment: .leading, spacing: 6) {
                                Text("Month")
                                    .font(.headline)
                                    .fontWeight(.bold)
                                
                                Menu {
                                    ForEach(months, id: \.self) { monthOption in
                                        Button {
                                            month = monthOption
                                        } label: {
                                            HStack {
                                                Text(monthOption)
                                                if month == monthOption {
                                                    Image(systemName: "checkmark")
                                                }
                                            }
                                        }
                                    }
                                } label: {
                                    HStack {
                                        Text(month.isEmpty ? "Select Month" : month)
                                            .font(.subheadline)
                                            .fontWeight(.medium)
                                            .foregroundColor(month.isEmpty ? .secondary : .primary)
                                        Spacer()
                                        if isEditing {
                                            Image(systemName: "chevron.down")
                                                .font(.footnote)
                                                .fontWeight(.bold)
                                                .foregroundColor(.primary)
                                        }
                                    }
                                    .padding(12)
                                    .background(Color.white)
                                    .clipShape(RoundedRectangle(cornerRadius: 16))
                                    .overlay(
                                        RoundedRectangle(cornerRadius: 16)
                                            .stroke(isEditing ? Color.black : borderColor, lineWidth: 1)
                                    )
                                }
                                .disabled(!isEditing)
                            }
                            
                            // Year Dropdown
                            VStack(alignment: .leading, spacing: 6) {
                                Text("Year")
                                    .font(.headline)
                                    .fontWeight(.bold)
                                
                                Menu {
                                    ForEach(years, id: \.self) { yearOption in
                                        Button {
                                            year = yearOption
                                        } label: {
                                            HStack {
                                                Text(yearOption)
                                                if year == yearOption {
                                                    Image(systemName: "checkmark")
                                                }
                                            }
                                        }
                                    }
                                } label: {
                                    HStack {
                                        Text(year.isEmpty ? "Select Year" : year)
                                            .font(.subheadline)
                                            .fontWeight(.medium)
                                            .foregroundColor(year.isEmpty ? .secondary : .primary)
                                        Spacer()
                                        if isEditing {
                                            Image(systemName: "chevron.down")
                                                .font(.footnote)
                                                .fontWeight(.bold)
                                                .foregroundColor(.primary)
                                        }
                                    }
                                    .padding(12)
                                    .background(Color.white)
                                    .clipShape(RoundedRectangle(cornerRadius: 16))
                                    .overlay(
                                        RoundedRectangle(cornerRadius: 16)
                                            .stroke(isEditing ? Color.black : borderColor, lineWidth: 1)
                                    )
                                }
                                .disabled(!isEditing)
                            }
                        }
                        
                        // CVV
                        VStack(alignment: .leading, spacing: 6) {
                            Text("CVV")
                                .font(.headline)
                                .fontWeight(.bold)
                            
                            HStack(spacing: 12) {
                                Group {
                                    if isCVVHidden {
                                        SecureField("CVV", text: $cvv)
                                    } else {
                                        TextField("CVV", text: $cvv)
                                    }
                                }
                                .disabled(!isEditing)
                                .font(.subheadline)
                                .fontWeight(.medium)
                                .multilineTextAlignment(.center)
                                .padding(12)
                                .frame(width: 140)
                                .background(Color.white)
                                .clipShape(RoundedRectangle(cornerRadius: 16))
                                .overlay(
                                    RoundedRectangle(cornerRadius: 16)
                                        .stroke(isEditing ? Color.black : borderColor, lineWidth: 1)
                                )
                                
                                Button {
                                    isCVVHidden.toggle()
                                } label: {
                                    ZStack {
                                        RoundedRectangle(cornerRadius: 8)
                                            .fill(Color.black)
                                            .frame(width: 36, height: 36)
                                        Image(systemName: isCVVHidden ? "eye.slash.fill" : "eye.fill")
                                            .font(.footnote)
                                            .foregroundColor(.white)
                                    }
                                }
                            }
                        }
                    }
                    .padding(.top, 4)
                    
                    // Update / Save Card Button
                    Button {
                        if isEditing {
                            withAnimation {
                                isEditing = false
                            }
                        } else {
                            dismiss()
                        }
                    } label: {
                        Text(isEditing ? "Save & Update Card" : "Update Card")
                            .font(.headline)
                            .fontWeight(.bold)
                            .foregroundColor(.white)
                            .frame(maxWidth: .infinity)
                            .padding(.vertical, 14)
                            .background(Color.black)
                            .clipShape(Capsule())
                    }
                    .padding(.top, 10)
                }
                .padding(.horizontal, 20)
                .padding(.bottom, 24)
            }
        }
        .navigationBarBackButtonHidden(true)
    }
}

#Preview {
    CardDetailView()
}

