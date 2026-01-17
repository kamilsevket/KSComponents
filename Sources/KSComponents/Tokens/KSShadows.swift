import SwiftUI

public extension KS.Shadows {
    struct ShadowStyle {
        public let color: Color
        public let radius: CGFloat
        public let x: CGFloat
        public let y: CGFloat

        public init(color: Color, radius: CGFloat, x: CGFloat, y: CGFloat) {
            self.color = color
            self.radius = radius
            self.x = x
            self.y = y
        }
    }

    // Shadow presets
    static let none = ShadowStyle(color: .clear, radius: 0, x: 0, y: 0)
    static let small = ShadowStyle(color: .black.opacity(0.1), radius: 2, x: 0, y: 1)
    static let medium = ShadowStyle(color: .black.opacity(0.15), radius: 4, x: 0, y: 2)
    static let large = ShadowStyle(color: .black.opacity(0.2), radius: 8, x: 0, y: 4)
    static let xLarge = ShadowStyle(color: .black.opacity(0.25), radius: 16, x: 0, y: 8)
}

public extension View {
    func ksShadow(_ style: KS.Shadows.ShadowStyle) -> some View {
        self.shadow(color: style.color, radius: style.radius, x: style.x, y: style.y)
    }
}
