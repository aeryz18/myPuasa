//
//  FastingView.swift
//  FastingView
//
//  Created by STDCX_MACBOOK PRO 27 on 8/12/26.
//

import SwiftUI

struct FastingView: View {
    
    // MARK: - Colors
    
    let burgundy = Color(
        red: 0.45,
        green: 0.03,
        blue: 0.15
    )
    
    let cream = Color(
        red: 0.91,
        green: 0.88,
        blue: 0.82
    )
    
    // MARK: - Variables
    
    @State private var fast1 = true
    @State private var fast2 = true
    @State private var fast3 = false
    
    @State private var showAddFast = false
    
    // MARK: - Body
    
    var body: some View {
        
        VStack {
            
            ScrollView {
                
                VStack(spacing: 20) {
                    
                    // Progress Circle
                    progressView
                    
                    // Title
                    HStack {
                        Text("Missed Fast List")
                            .font(.system(size: 25, weight: .bold))
                        
                        Spacer()
                    }
                    
                    // Fast List
                    VStack(spacing: 0) {
                        
                        fastRow(
                            date: "2 Jan 2025",
                            isCompleted: $fast1
                        )
                        
                        Divider()
                        
                        fastRow(
                            date: "2 Feb 2025",
                            isCompleted: $fast2
                        )
                        
                        Divider()
                        
                        fastRow(
                            date: "2 Mac 2025",
                            isCompleted: $fast3
                        )
                    }
                    .padding(.horizontal, 12)
                    .background(cream)
                    .cornerRadius(18)
                    
                    // Update
                    HStack(spacing: 12) {
                        
                        Text("Click to Update")
                            .font(.system(size: 23, weight: .bold))
                        
                        Image(
                            systemName: "checkmark.circle.fill"
                        )
                        .font(.system(size: 38))
                        .foregroundColor(.green)
                        
                        Spacer()
                    }
                    
                    // Add missed fast
                    Button {
                        showAddFast = true
                    } label: {
                        
                        HStack {
                            
                            Text("+ Add missed Fast")
                                .font(.system(size: 18))
                            
                            Spacer()
                        }
                        .foregroundColor(.black)
                        .padding(.horizontal, 15)
                        .frame(height: 65)
                        .background(cream)
                        .cornerRadius(15)
                    }
                    
                    Spacer()
                        .frame(height: 30)
                }
                .padding(.horizontal, 15)
                .padding(.top, 25)
            }
        }
        .background(Color.white)
        .sheet(isPresented: $showAddFast) {
            AddFastView()
        }
    }
    
    // MARK: - Progress View
    
    var progressView: some View {
        
        ZStack {
            
            // Background ring
            Circle()
                .stroke(
                    Color(
                        red: 0.88,
                        green: 0.84,
                        blue: 0.77
                    ),
                    lineWidth: 20
                )
            
            // Progress ring
            Circle()
                .trim(
                    from: 0,
                    to: 0.6
                )
                .stroke(
                    burgundy,
                    style: StrokeStyle(
                        lineWidth: 20,
                        lineCap: .butt
                    )
                )
                .rotationEffect(
                    .degrees(-90)
                )
            
            // Text
            HStack(spacing: 5) {
                
                Text("3/5")
                    .font(
                        .system(
                            size: 48,
                            weight: .bold
                        )
                    )
                
                Text("Days")
                    .font(
                        .system(
                            size: 21,
                            weight: .bold
                        )
                    )
            }
        }
        .frame(
            width: 220,
            height: 220
        )
        .shadow(
            color: .black.opacity(0.2),
            radius: 8
        )
    }
    
    // MARK: - Fast Row
    
    func fastRow(
        date: String,
        isCompleted: Binding<Bool>
    ) -> some View {
        
        HStack {
            
            Text(date)
                .font(
                    .system(
                        size: 20,
                        weight: .semibold
                    )
                )
            
            Spacer()
            
            Button {
                isCompleted.wrappedValue.toggle()
            } label: {
                
                if isCompleted.wrappedValue {
                    
                    Image(
                        systemName:
                            "checkmark.circle.fill"
                    )
                    .font(.system(size: 38))
                    .foregroundColor(.green)
                    
                } else {
                    
                    Circle()
                        .stroke(
                            Color.black,
                            lineWidth: 1
                        )
                        .frame(
                            width: 38,
                            height: 38
                        )
                }
            }
        }
        .frame(height: 85)
    }
}


// MARK: - Add Fast View

struct AddFastView: View {
    
    @Environment(\.dismiss) var dismiss
    
    var body: some View {
        
        NavigationStack {
            
            VStack(spacing: 20) {
                
                Text("Add Missed Fast")
                    .font(.title)
                    .fontWeight(.bold)
                
                
                .datePickerStyle(.graphical)
                
                
                
                Spacer()
            }
            .padding()
            .navigationTitle("Missed Fast")
            .navigationBarTitleDisplayMode(.inline)
        }
    }
}




#Preview {
    ContentView()
}
