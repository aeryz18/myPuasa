//
//  AddFastView.swift
//  myPuasa
//

import SwiftUI

struct AddFastView: View {
    @Environment(\.dismiss) private var dismiss
    @State private var selectedDate = Date()
    
    var body: some View {
        NavigationStack {
            VStack(spacing: 20) {
                Text("Add Missed Fast")
                    .font(.title)
                    .fontWeight(.bold)
                
                DatePicker("Select Date", selection: $selectedDate, displayedComponents: .date)
                    .datePickerStyle(.graphical)
                    .padding()
                
                Spacer()
                
                Button {
                    dismiss()
                } label: {
                    Text("Save Missed Fast")
                        .font(.headline)
                        .fontWeight(.bold)
                        .foregroundColor(.white)
                        .frame(maxWidth: .infinity)
                        .padding(.vertical, 14)
                        .background(Color(red: 0.45, green: 0.03, blue: 0.15))
                        .clipShape(Capsule())
                }
                .padding(.horizontal)
            }
            .padding()
            .navigationTitle("Missed Fast")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .cancellationAction) {
                    Button("Cancel") {
                        dismiss()
                    }
                }
            }
        }
    }
}

#Preview {
    AddFastView()
}
