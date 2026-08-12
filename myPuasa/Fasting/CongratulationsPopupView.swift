//
//  CongratulationsPopupView.swift
//  myPuasa
//

import SwiftUI

struct CongratulationsPopupView: View {
    @Binding var isPresented: Bool
    
    @State private var isVisible = false
    @State private var isExploded = false
    
    private let highlightColor = Color(red: 123 / 255, green: 45 / 255, blue: 63 / 255)
    
    var body: some View {
        ZStack {
            // Apple-style Glassmorphism Backdrop Overlay
            ZStack {
                Rectangle()
                    .fill(.ultraThinMaterial)
                Color.black.opacity(0.28)
            }
            .ignoresSafeArea()
            .opacity(isVisible ? 1 : 0)
            .onTapGesture {
                dismissWithAppleAnimation()
            }
            
            // Dynamic Bursting Confetti Layer
            AppleConfettiBurstView(isExploded: isExploded)
                .ignoresSafeArea()
            
            // Celebration Card with Apple Spring Motion
            VStack(spacing: 12) {
                // Animated Checkmark Badge
                ZStack {
                    Circle()
                        .fill(Color.white.opacity(0.2))
                        .frame(width: 56, height: 56)
                    Image(systemName: "checkmark.seal.fill")
                        .font(.system(size: 32, weight: .bold))
                        .foregroundColor(.white)
                }
                .scaleEffect(isVisible ? 1.0 : 0.4)
                .rotationEffect(.degrees(isVisible ? 0 : -45))
                
                VStack(spacing: 6) {
                    Text("Congratulations !")
                        .font(.system(size: 28, weight: .bold, design: .rounded))
                        .foregroundColor(.white)
                    
                    Text("You have completed your fast !")
                        .font(.system(size: 16, weight: .medium, design: .rounded))
                        .foregroundColor(.white.opacity(0.92))
                }
            }
            .multilineTextAlignment(.center)
            .padding(.vertical, 32)
            .padding(.horizontal, 36)
            .background(highlightColor)
            .clipShape(RoundedRectangle(cornerRadius: 26, style: .continuous))
            .shadow(color: highlightColor.opacity(0.45), radius: 24, x: 0, y: 12)
            .shadow(color: Color.black.opacity(0.25), radius: 12, x: 0, y: 6)
            .scaleEffect(isVisible ? 1.0 : 0.65)
            .opacity(isVisible ? 1.0 : 0.0)
            .blur(radius: isVisible ? 0 : 10)
        }
        .onAppear {
            // Entry Spring Animation (Apple HIG)
            withAnimation(.spring(response: 0.45, dampingFraction: 0.72, blendDuration: 0)) {
                isVisible = true
            }
            
            // Confetti Burst Trigger
            withAnimation(.spring(response: 0.6, dampingFraction: 0.65)) {
                isExploded = true
            }
            
            // Auto dismiss after 2.8 seconds
            DispatchQueue.main.asyncAfter(deadline: .now() + 2.8) {
                if isPresented {
                    dismissWithAppleAnimation()
                }
            }
        }
    }
    
    private func dismissWithAppleAnimation() {
        withAnimation(.spring(response: 0.35, dampingFraction: 0.85)) {
            isVisible = false
            isExploded = false
        }
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.25) {
            isPresented = false
        }
    }
}

// MARK: - Apple Confetti Burst Particle System
struct AppleConfettiBurstView: View {
    var isExploded: Bool
    
    let particleCount = 36
    let colors: [Color] = [
        Color.red, Color.green, Color.blue, Color.yellow,
        Color.purple, Color.orange, Color.pink, Color.cyan
    ]
    
    var body: some View {
        GeometryReader { geo in
            let center = CGPoint(x: geo.size.width / 2, y: geo.size.height / 2)
            
            ZStack {
                ForEach(0..<particleCount, id: \.self) { i in
                    let angle = Double(i) * (360.0 / Double(particleCount)) + Double.random(in: -10...10)
                    let distance = CGFloat.random(in: 120...260)
                    let radians = angle * .pi / 180.0
                    
                    let targetX = center.x + cos(radians) * distance
                    let targetY = center.y + sin(radians) * distance + CGFloat.random(in: 20...80)
                    
                    AppleConfettiPiece(color: colors[i % colors.count])
                        .position(
                            x: isExploded ? targetX : center.x,
                            y: isExploded ? targetY : center.y
                        )
                        .scaleEffect(isExploded ? CGFloat.random(in: 0.8...1.3) : 0.1)
                        .rotationEffect(.degrees(isExploded ? Double.random(in: 180...720) : 0))
                        .opacity(isExploded ? 0.9 : 0.0)
                }
            }
        }
        .allowsHitTesting(false)
    }
}

struct AppleConfettiPiece: View {
    let color: Color
    
    var body: some View {
        Group {
            if Bool.random() {
                Circle()
                    .fill(color)
                    .frame(width: 10, height: 10)
            } else {
                ConfettiTriangle()
                    .fill(color)
                    .frame(width: 12, height: 12)
            }
        }
    }
}

struct ConfettiTriangle: Shape {
    func path(in rect: CGRect) -> Path {
        var path = Path()
        path.move(to: CGPoint(x: rect.midX, y: rect.minY))
        path.addLine(to: CGPoint(x: rect.maxX, y: rect.maxY))
        path.addLine(to: CGPoint(x: rect.minX, y: rect.maxY))
        path.closeSubpath()
        return path
    }
}

#Preview {
    CongratulationsPopupView(isPresented: .constant(true))
}
