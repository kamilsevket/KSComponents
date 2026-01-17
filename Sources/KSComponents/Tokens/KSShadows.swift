import SwiftUI

/// A shadow definition for the design system.
public struct KSShadow {
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

public extension KS.Shadows {
    static let sm = KSShadow(
        color: .black.opacity(0.05),
        radius: 2,
        x: 0,
        y: 1
    )

    static let md = KSShadow(
        color: .black.opacity(0.1),
        radius: 4,
        x: 0,
        y: 2
    )

    static let lg = KSShadow(
        color: .black.opacity(0.15),
        radius: 8,
        x: 0,
        y: 4
    )

    static let xl = KSShadow(
        color: .black.opacity(0.2),
        radius: 16,
        x: 0,
        y: 8
    )

    static let glow = KSShadow(
        color: KS.Colors.primary.opacity(0.4),
        radius: 12,
        x: 0,
        y: 0
    )
}

public extension View {
    /// Applies a KSShadow to the view.
    func ksShadow(_ shadow: KSShadow) -> some View {
        self.shadow(
            color: shadow.color,
            radius: shadow.radius,
            x: shadow.x,
            y: shadow.y
        )
    }
}
