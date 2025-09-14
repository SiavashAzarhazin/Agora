import SwiftUI

// MARK: - View Extensions
extension View {
    func cardStyle() -> some View {
        self
            .background(Color(.systemBackground))
            .cornerRadius(16)
            .shadow(color: Color.black.opacity(0.1), radius: 8, x: 0, y: 2)
    }
    
    func primaryButtonStyle() -> some View {
        self
            .font(.headline)
            .fontWeight(.semibold)
            .foregroundColor(.white)
            .frame(maxWidth: .infinity)
            .padding(.vertical, 16)
            .background(Color.blue)
            .cornerRadius(12)
    }
    
    func secondaryButtonStyle() -> some View {
        self
            .font(.headline)
            .fontWeight(.semibold)
            .foregroundColor(.blue)
            .frame(maxWidth: .infinity)
            .padding(.vertical, 16)
            .background(Color.blue.opacity(0.1))
            .cornerRadius(12)
    }
}

// MARK: - Animation Extensions
extension View {
    func fadeInAnimation(delay: Double = 0) -> some View {
        self
            .opacity(0)
            .animation(.easeInOut(duration: 0.6).delay(delay), value: true)
            .onAppear {
                withAnimation(.easeInOut(duration: 0.6).delay(delay)) {
                    // This will trigger the animation
                }
            }
    }
    
    func slideInAnimation(delay: Double = 0) -> some View {
        self
            .offset(x: 0, y: 20)
            .opacity(0)
            .animation(.easeOut(duration: 0.6).delay(delay), value: true)
            .onAppear {
                withAnimation(.easeOut(duration: 0.6).delay(delay)) {
                    // This will trigger the animation
                }
            }
    }
}

// MARK: - Color Extensions
extension Color {
    static let agoraBlue = Color(red: 0.0, green: 0.48, blue: 1.0)
    static let agoraGreen = Color(red: 0.2, green: 0.78, blue: 0.35)
    static let agoraOrange = Color(red: 1.0, green: 0.58, blue: 0.0)
    static let agoraRed = Color(red: 1.0, green: 0.23, blue: 0.19)
    
    // Gradient colors
    static let agoraGradientStart = Color(red: 0.0, green: 0.48, blue: 1.0)
    static let agoraGradientEnd = Color(red: 0.0, green: 0.78, blue: 0.8)
}

// MARK: - Custom Gradients
extension LinearGradient {
    static let agoraGradient = LinearGradient(
        gradient: Gradient(colors: [Color.agoraGradientStart, Color.agoraGradientEnd]),
        startPoint: .topLeading,
        endPoint: .bottomTrailing
    )
    
    static let cardGradient = LinearGradient(
        gradient: Gradient(colors: [Color.white, Color(.systemGray6)]),
        startPoint: .top,
        endPoint: .bottom
    )
}
