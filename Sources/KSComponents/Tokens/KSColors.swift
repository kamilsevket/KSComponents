import SwiftUI

public extension KS.Colors {
    // MARK: - Brand
    static let primary = Color("KSPrimary", bundle: .module)
    static let secondary = Color("KSSecondary", bundle: .module)
    static let accent = Color("KSAccent", bundle: .module)

    // MARK: - Semantic
    static let success = Color(red: 0.2, green: 0.78, blue: 0.35)
    static let warning = Color(red: 1.0, green: 0.76, blue: 0.03)
    static let error = Color(red: 0.94, green: 0.27, blue: 0.27)
    static let info = Color(red: 0.23, green: 0.51, blue: 0.96)

    // MARK: - Neutral
    static let background = Color("KSBackground", bundle: .module)
    static let surface = Color("KSSurface", bundle: .module)
    static let surfaceElevated = Color("KSSurfaceElevated", bundle: .module)

    // MARK: - Text
    static let textPrimary = Color("KSTextPrimary", bundle: .module)
    static let textSecondary = Color("KSTextSecondary", bundle: .module)
    static let textTertiary = Color("KSTextTertiary", bundle: .module)
    static let textInverse = Color("KSTextInverse", bundle: .module)

    // MARK: - Border
    static let border = Color("KSBorder", bundle: .module)
    static let borderFocused = Color("KSBorderFocused", bundle: .module)

    // MARK: - Gradients
    static let gradientPrimary = LinearGradient(
        colors: [primary, primary.opacity(0.8)],
        startPoint: .topLeading,
        endPoint: .bottomTrailing
    )

    static let gradientSunrise = LinearGradient(
        colors: [Color.orange, Color.pink],
        startPoint: .topLeading,
        endPoint: .bottomTrailing
    )

    static let gradientOcean = LinearGradient(
        colors: [Color.blue, Color.cyan],
        startPoint: .topLeading,
        endPoint: .bottomTrailing
    )
}
