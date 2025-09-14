import SwiftUI

// MARK: - Custom Animations
struct ShakeAnimation: ViewModifier {
    @State private var isShaking = false
    let intensity: Double
    
    func body(content: Content) -> some View {
        content
            .offset(x: isShaking ? intensity : 0)
            .animation(.easeInOut(duration: 0.1).repeatCount(3, autoreverses: true), value: isShaking)
            .onAppear {
                isShaking = true
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
                    isShaking = false
                }
            }
    }
}

struct PulseAnimation: ViewModifier {
    @State private var isPulsing = false
    let scale: Double
    
    func body(content: Content) -> some View {
        content
            .scaleEffect(isPulsing ? scale : 1.0)
            .animation(.easeInOut(duration: 1.0).repeatForever(autoreverses: true), value: isPulsing)
            .onAppear {
                isPulsing = true
            }
    }
}

struct BounceAnimation: ViewModifier {
    @State private var isBouncing = false
    let delay: Double
    
    func body(content: Content) -> some View {
        content
            .scaleEffect(isBouncing ? 1.1 : 1.0)
            .animation(.spring(response: 0.6, dampingFraction: 0.8).delay(delay), value: isBouncing)
            .onAppear {
                isBouncing = true
            }
    }
}

struct SlideInFromBottom: ViewModifier {
    @State private var isVisible = false
    let delay: Double
    
    func body(content: Content) -> some View {
        content
            .offset(y: isVisible ? 0 : 50)
            .opacity(isVisible ? 1 : 0)
            .animation(.easeOut(duration: 0.6).delay(delay), value: isVisible)
            .onAppear {
                isVisible = true
            }
    }
}

struct FadeInWithScale: ViewModifier {
    @State private var isVisible = false
    let delay: Double
    
    func body(content: Content) -> some View {
        content
            .scaleEffect(isVisible ? 1.0 : 0.8)
            .opacity(isVisible ? 1 : 0)
            .animation(.easeOut(duration: 0.5).delay(delay), value: isVisible)
            .onAppear {
                isVisible = true
            }
    }
}

// MARK: - View Extensions for Animations
extension View {
    func shake(intensity: Double = 10) -> some View {
        self.modifier(ShakeAnimation(intensity: intensity))
    }
    
    func pulse(scale: Double = 1.05) -> some View {
        self.modifier(PulseAnimation(scale: scale))
    }
    
    func bounce(delay: Double = 0) -> some View {
        self.modifier(BounceAnimation(delay: delay))
    }
    
    func slideInFromBottom(delay: Double = 0) -> some View {
        self.modifier(SlideInFromBottom(delay: delay))
    }
    
    func fadeInWithScale(delay: Double = 0) -> some View {
        self.modifier(FadeInWithScale(delay: delay))
    }
}

// MARK: - Loading Animation
struct LoadingDots: View {
    @State private var animating = false
    
    var body: some View {
        HStack(spacing: 4) {
            ForEach(0..<3) { index in
                Circle()
                    .fill(Color.blue)
                    .frame(width: 8, height: 8)
                    .scaleEffect(animating ? 1.0 : 0.5)
                    .animation(
                        .easeInOut(duration: 0.6)
                        .repeatForever(autoreverses: true)
                        .delay(Double(index) * 0.2),
                        value: animating
                    )
            }
        }
        .onAppear {
            animating = true
        }
    }
}

// MARK: - Success Animation
struct SuccessCheckmark: View {
    @State private var isVisible = false
    @State private var scale: CGFloat = 0
    
    var body: some View {
        ZStack {
            Circle()
                .fill(Color.green)
                .frame(width: 60, height: 60)
                .scaleEffect(scale)
                .animation(.spring(response: 0.6, dampingFraction: 0.8), value: scale)
            
            Image(systemName: "checkmark")
                .font(.title)
                .fontWeight(.bold)
                .foregroundColor(.white)
                .opacity(isVisible ? 1 : 0)
                .animation(.easeIn(duration: 0.3).delay(0.2), value: isVisible)
        }
        .onAppear {
            scale = 1.0
            isVisible = true
        }
    }
}
