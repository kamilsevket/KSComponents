import SwiftUI

// MARK: - Shake Animation

/// View modifier that applies a shake animation when triggered
public struct ShakeModifier: ViewModifier {
    @State private var shakeOffset: CGFloat = 0
    let trigger: Bool

    public init(trigger: Bool) {
        self.trigger = trigger
    }

    public func body(content: Content) -> some View {
        content
            .offset(x: shakeOffset)
            .onChange(of: trigger) { _, newValue in
                if newValue {
                    withAnimation(.spring(response: 0.1, dampingFraction: 0.3)) {
                        shakeOffset = -10
                    }
                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
                        withAnimation(.spring(response: 0.1, dampingFraction: 0.3)) {
                            shakeOffset = 10
                        }
                    }
                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {
                        withAnimation(.spring(response: 0.1, dampingFraction: 0.3)) {
                            shakeOffset = 0
                        }
                    }
                }
            }
    }
}

// MARK: - Pulse Animation

/// View modifier that applies a continuous pulse animation
public struct PulseModifier: ViewModifier {
    @State private var isPulsing = false
    let isActive: Bool

    public init(isActive: Bool) {
        self.isActive = isActive
    }

    public func body(content: Content) -> some View {
        content
            .scaleEffect(isPulsing ? 1.05 : 1.0)
            .opacity(isPulsing ? 0.8 : 1.0)
            .animation(
                isActive ? .easeInOut(duration: 1.0).repeatForever(autoreverses: true) : .default,
                value: isPulsing
            )
            .onAppear {
                isPulsing = isActive
            }
            .onChange(of: isActive) { _, newValue in
                isPulsing = newValue
            }
    }
}

// MARK: - View Extensions

extension View {
    /// Applies a shake animation when the trigger value becomes true
    /// - Parameter trigger: Boolean that triggers the shake when it becomes true
    /// - Returns: Modified view with shake animation
    public func ksShake(trigger: Bool) -> some View {
        modifier(ShakeModifier(trigger: trigger))
    }

    /// Applies a continuous pulse animation
    /// - Parameter isActive: Whether the pulse animation is active
    /// - Returns: Modified view with pulse animation
    public func ksPulse(isActive: Bool = true) -> some View {
        modifier(PulseModifier(isActive: isActive))
    }
}
