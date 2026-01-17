import SwiftUI

public extension KS.Animation {
    // Duration presets
    static let durationFast: Double = 0.15
    static let durationNormal: Double = 0.25
    static let durationSlow: Double = 0.4

    // Animation presets
    static let defaultAnimation = SwiftUI.Animation.easeInOut(duration: durationNormal)
    static let fastAnimation = SwiftUI.Animation.easeInOut(duration: durationFast)
    static let slowAnimation = SwiftUI.Animation.easeInOut(duration: durationSlow)

    // Spring animations
    static let springDefault = SwiftUI.Animation.spring(response: 0.3, dampingFraction: 0.7)
    static let springBouncy = SwiftUI.Animation.spring(response: 0.4, dampingFraction: 0.5)
    static let springStiff = SwiftUI.Animation.spring(response: 0.2, dampingFraction: 0.9)

    // Interactive animations
    static let interactive = SwiftUI.Animation.interactiveSpring(response: 0.3, dampingFraction: 0.7, blendDuration: 0.1)
}

// View modifier for applying KS animations
public extension View {
    func ksAnimation(_ animation: SwiftUI.Animation = KS.Animation.defaultAnimation) -> some View {
        self.animation(animation, value: UUID())
    }
}
