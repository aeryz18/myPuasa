//
//  AddFastView.swift
//  myPuasa
//

import SwiftUI

struct AddFastView: View {
    @Environment(\.dismiss) private var dismiss
    
    @State private var numberOfFasts: String = "1"
    @State private var selectedRamadan: String = "Ramadan 1447 (2025)"
    @State private var optionalNote: String = ""
    
    var onAdd: ((Int, String, String) -> Void)?
    
    private let ramadanOptions: [String] = [
        "Ramadan 1447 (2025)",
        "Ramadan 1446 (2024)",
        "Ramadan 1445 (2023)",
        "Ramadan 1444 (2022)"
        
    ]
    
    private let backgroundColor = Color(red: 250 / 255, green: 248 / 255, blue: 245 / 255)
    private let boxColor = Color(red: 237 / 255, green: 231 / 255, blue: 223 / 255)
    private let borderColor = Color(red: 221 / 255, green: 212 / 255, blue: 200 / 255)
    private let highlightColor = Color(red: 123 / 255, green: 45 / 255, blue: 63 / 255)
    
    var body: some View {
        NavigationStack {
            ZStack {
                backgroundColor
                    .ignoresSafeArea()
                
                VStack(alignment: .leading, spacing: 22) {
                    // Header Title
                    Text("Add Missed Fasts")
                        .font(.title2)
                        .fontWeight(.bold)
                        .foregroundColor(.primary)
                        .padding(.top, 12)
                    
                    // Field 1: Enter number of missed fasts
                    VStack(alignment: .leading, spacing: 8) {
                        Text("Enter number of missed fasts")
                            .font(.headline)
                            .fontWeight(.semibold)
                            .foregroundColor(.primary)
                        
                        TextField("10", text: $numberOfFasts)
                            .keyboardType(.numberPad)
                            .font(.subheadline)
                            .fontWeight(.medium)
                            .padding(.horizontal, 16)
                            .padding(.vertical, 14)
                            .background(boxColor)
                            .clipShape(Capsule())
                    }
                    
                    // Field 2: Select Ramadan Dropdown
                    VStack(alignment: .leading, spacing: 8) {
                        Text("Select Ramadan")
                            .font(.headline)
                            .fontWeight(.semibold)
                            .foregroundColor(.primary)
                        
                        Menu {
                            ForEach(ramadanOptions, id: \.self) { option in
                                Button {
                                    selectedRamadan = option
                                } label: {
                                    HStack {
                                        Text(option)
                                        if selectedRamadan == option {
                                            Image(systemName: "checkmark")
                                        }
                                    }
                                }
                            }
                        } label: {
                            HStack {
                                Text(selectedRamadan)
                                    .font(.subheadline)
                                    .fontWeight(.medium)
                                    .foregroundColor(.primary)
                                Spacer()
                                Image(systemName: "chevron.down")
                                    .font(.footnote)
                                    .fontWeight(.bold)
                                    .foregroundColor(.secondary)
                            }
                            .padding(.horizontal, 16)
                            .padding(.vertical, 14)
                            .background(boxColor)
                            .clipShape(Capsule())
                        }
                    }
                    
                    // Field 3: Add an optional note
                    VStack(alignment: .leading, spacing: 8) {
                        Text("Add an optional note")
                            .font(.headline)
                            .fontWeight(.semibold)
                            .foregroundColor(.primary)
                        
                        TextField("Mid Ramadan", text: $optionalNote)
                            .font(.subheadline)
                            .fontWeight(.medium)
                            .padding(.horizontal, 16)
                            .padding(.vertical, 14)
                            .background(boxColor)
                            .clipShape(Capsule())
                    }
                    
                    Spacer()
                    
                    // Action Buttons (Cancel & Add)
                    HStack(spacing: 14) {
                        // Cancel Button (Burgundy)
                        Button {
                            dismiss()
                        } label: {
                            Text("Cancel")
                                .font(.headline)
                                .fontWeight(.bold)
                                .foregroundColor(.white)
                                .frame(maxWidth: .infinity)
                                .padding(.vertical, 16)
                                .background(.black)
                                .clipShape(Capsule())
                        }
                        
                        // Add Button (Light sand box with blue forward icon)
                        Button {
                            let count = Int(numberOfFasts) ?? 1
                            onAdd?(count, selectedRamadan, optionalNote)
                            dismiss()
                        } label: {
                            HStack {
                                Spacer()
                                Text("Add")
                                    .font(.headline)
                                    .fontWeight(.bold)
                                    .foregroundColor(Color(.white))
                                Spacer()
                                Image(systemName: "arrow.shape.turn.up.forward.circle.fill")
                                    .font(.title2)
                                    .foregroundColor(.blue)
                            }
                            .padding(.horizontal, 16)
                            .padding(.vertical, 14)
                            .background(highlightColor)
                            .clipShape(Capsule())
                        }
                    }
                    
                }
                .padding(.horizontal, 20)
                
            }
        }
    }
}

#Preview {
    AddFastView()
}
