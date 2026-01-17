import SwiftUI

public struct KSTheme {
    public var colors: KSThemeColors
    public var typography: KSThemeTypography
    public var spacing: KSThemeSpacing

    public init(
        colors: KSThemeColors = .default,
        typography: KSThemeTypography = .default,
        spacing: KSThemeSpacing = .default
    ) {
        self.colors = colors
        self.typography = typography
        self.spacing = spacing
    }

    public static let `default` = KSTheme()
}

public struct KSThemeColors {
    public var primary: Color
    public var secondary: Color
    public var background: Color
    public var surface: Color
    public var error: Color
    public var onPrimary: Color
    public var onSecondary: Color
    public var onBackground: Color
    public var onSurface: Color
    public var onError: Color

    public init(
        primary: Color = .blue,
        secondary: Color = .purple,
        background: Color = Color(.systemBackground),
        surface: Color = Color(.secondarySystemBackground),
        error: Color = .red,
        onPrimary: Color = .white,
        onSecondary: Color = .white,
        onBackground: Color = .primary,
        onSurface: Color = .primary,
        onError: Color = .white
    ) {
        self.primary = primary
        self.secondary = secondary
        self.background = background
        self.surface = surface
        self.error = error
        self.onPrimary = onPrimary
        self.onSecondary = onSecondary
        self.onBackground = onBackground
        self.onSurface = onSurface
        self.onError = onError
    }

    public static let `default` = KSThemeColors()
}

public struct KSThemeTypography {
    public var displayLarge: Font
    public var headlineMedium: Font
    public var bodyLarge: Font
    public var labelMedium: Font

    public init(
        displayLarge: Font = KS.Typography.displayLarge,
        headlineMedium: Font = KS.Typography.headlineMedium,
        bodyLarge: Font = KS.Typography.bodyLarge,
        labelMedium: Font = KS.Typography.labelMedium
    ) {
        self.displayLarge = displayLarge
        self.headlineMedium = headlineMedium
        self.bodyLarge = bodyLarge
        self.labelMedium = labelMedium
    }

    public static let `default` = KSThemeTypography()
}

public struct KSThemeSpacing {
    public var small: CGFloat
    public var medium: CGFloat
    public var large: CGFloat

    public init(
        small: CGFloat = KS.Spacing.sm,
        medium: CGFloat = KS.Spacing.md,
        large: CGFloat = KS.Spacing.lg
    ) {
        self.small = small
        self.medium = medium
        self.large = large
    }

    public static let `default` = KSThemeSpacing()
}

// Environment key for theme
private struct KSThemeKey: EnvironmentKey {
    static let defaultValue = KSTheme.default
}

public extension EnvironmentValues {
    var ksTheme: KSTheme {
        get { self[KSThemeKey.self] }
        set { self[KSThemeKey.self] = newValue }
    }
}

public extension View {
    func ksTheme(_ theme: KSTheme) -> some View {
        environment(\.ksTheme, theme)
    }
}
