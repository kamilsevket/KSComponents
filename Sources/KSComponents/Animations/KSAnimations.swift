import SwiftUI

public extension KS.Animation {
    // MARK: - Duration Presets

    /// Fast duration (0.15s)
    static let durationFast: Double = 0.15
    /// Normal duration (0.25s)
    static let durationNormal: Double = 0.25
    /// Slow duration (0.4s)
    static let durationSlow: Double = 0.4

    // MARK: - Animation Presets

    /// Default ease-in-out animation
    static let defaultAnimation = SwiftUI.Animation.easeInOut(duration: durationNormal)
    /// Fast ease-in-out animation
    static let fastAnimation = SwiftUI.Animation.easeInOut(duration: durationFast)
    /// Slow ease-in-out animation
    static let slowAnimation = SwiftUI.Animation.easeInOut(duration: durationSlow)

    // MARK: - Spring Presets

    /// Default spring animation
    static let springDefault = SwiftUI.Animation.spring(response: 0.3, dampingFraction: 0.7)
    /// Bouncy spring with higher bounce effect
    static let springBouncy = SwiftUI.Animation.spring(response: 0.4, dampingFraction: 0.5)
    /// Stiff spring animation
    static let springStiff = SwiftUI.Animation.spring(response: 0.2, dampingFraction: 0.9)

    /// Bouncy spring animation with higher bounce effect
    static let bouncy = SwiftUI.Animation.spring(response: 0.5, dampingFraction: 0.6)
    /// Smooth spring animation with minimal overshoot
    static let smooth = SwiftUI.Animation.spring(response: 0.4, dampingFraction: 0.8)
    /// Snappy spring animation for quick, responsive feedback
    static let snappy = SwiftUI.Animation.spring(response: 0.3, dampingFraction: 0.7)
    /// Gentle spring animation for subtle, slow movements
    static let gentle = SwiftUI.Animation.spring(response: 0.6, dampingFraction: 0.9)

    // MARK: - Easing Presets

    /// Quick ease-out animation (0.2s)
    static let quick = SwiftUI.Animation.easeOut(duration: 0.2)
    /// Medium ease-in-out animation (0.3s)
    static let medium = SwiftUI.Animation.easeInOut(duration: 0.3)
    /// Slow ease-in-out animation (0.5s)
    static let slow = SwiftUI.Animation.easeInOut(duration: 0.5)

    // MARK: - Interactive

    /// Interactive spring for gesture-driven animations
    static let interactive = SwiftUI.Animation.interactiveSpring(response: 0.3, dampingFraction: 0.7, blendDuration: 0.1)
}

// MARK: - View Modifier for KS Animations

public extension View {
    /// Apply a KS animation to the view
    func ksAnimation(_ animation: SwiftUI.Animation = KS.Animation.defaultAnimation) -> some View {
        self.animation(animation, value: UUID())
    }
}
