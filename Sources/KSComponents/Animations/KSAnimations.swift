import SwiftUI

extension KS.Animation {
    // MARK: - Spring Presets

    /// Bouncy spring animation with higher bounce effect
    public static let bouncy = SwiftUI.Animation.spring(response: 0.5, dampingFraction: 0.6)

    /// Smooth spring animation with minimal overshoot
    public static let smooth = SwiftUI.Animation.spring(response: 0.4, dampingFraction: 0.8)

    /// Snappy spring animation for quick, responsive feedback
    public static let snappy = SwiftUI.Animation.spring(response: 0.3, dampingFraction: 0.7)

    /// Gentle spring animation for subtle, slow movements
    public static let gentle = SwiftUI.Animation.spring(response: 0.6, dampingFraction: 0.9)

    // MARK: - Easing Presets

    /// Quick ease-out animation (0.2s)
    public static let quick = SwiftUI.Animation.easeOut(duration: 0.2)

    /// Medium ease-in-out animation (0.3s)
    public static let medium = SwiftUI.Animation.easeInOut(duration: 0.3)

    /// Slow ease-in-out animation (0.5s)
    public static let slow = SwiftUI.Animation.easeInOut(duration: 0.5)

    // MARK: - Interactive

    /// Interactive spring for gesture-driven animations
    public static let interactive = SwiftUI.Animation.interactiveSpring(response: 0.3, dampingFraction: 0.7)
}
