import SwiftUI

// MARK: - Theme Protocol

public protocol KSThemeProtocol {
    // Colors
    var primary: Color { get }
    var secondary: Color { get }
    var accent: Color { get }
    var background: Color { get }
    var surface: Color { get }
    var textPrimary: Color { get }
    var textSecondary: Color { get }
    var border: Color { get }
    var success: Color { get }
    var warning: Color { get }
    var error: Color { get }
}

// MARK: - Theme Manager

@Observable
public final class KSThemeManager {
    public static let shared = KSThemeManager()

    public var currentTheme: KSThemeProtocol = KSDefaultTheme()
    public var colorScheme: ColorScheme?

    private init() {}

    public func setTheme(_ theme: KSThemeProtocol) {
        currentTheme = theme
    }
}

// MARK: - Default Theme

public struct KSDefaultTheme: KSThemeProtocol {
    public var primary: Color { KS.Colors.primary }
    public var secondary: Color { KS.Colors.secondary }
    public var accent: Color { KS.Colors.accent }
    public var background: Color { KS.Colors.background }
    public var surface: Color { KS.Colors.surface }
    public var textPrimary: Color { KS.Colors.textPrimary }
    public var textSecondary: Color { KS.Colors.textSecondary }
    public var border: Color { KS.Colors.border }
    public var success: Color { KS.Colors.success }
    public var warning: Color { KS.Colors.warning }
    public var error: Color { KS.Colors.error }

    public init() {}
}

// MARK: - Preset Themes

// Ocean Theme
public struct KSOceanTheme: KSThemeProtocol {
    public var primary: Color { Color(hex: "#0EA5E9") }
    public var secondary: Color { Color(hex: "#06B6D4") }
    public var accent: Color { Color(hex: "#22D3EE") }
    public var background: Color { Color(hex: "#0F172A") }
    public var surface: Color { Color(hex: "#1E293B") }
    public var textPrimary: Color { Color(hex: "#F8FAFC") }
    public var textSecondary: Color { Color(hex: "#94A3B8") }
    public var border: Color { Color(hex: "#334155") }
    public var success: Color { Color(hex: "#10B981") }
    public var warning: Color { Color(hex: "#F59E0B") }
    public var error: Color { Color(hex: "#EF4444") }

    public init() {}
}

// Sunset Theme
public struct KSSunsetTheme: KSThemeProtocol {
    public var primary: Color { Color(hex: "#F97316") }
    public var secondary: Color { Color(hex: "#FB923C") }
    public var accent: Color { Color(hex: "#FBBF24") }
    public var background: Color { Color(hex: "#1C1917") }
    public var surface: Color { Color(hex: "#292524") }
    public var textPrimary: Color { Color(hex: "#FAFAF9") }
    public var textSecondary: Color { Color(hex: "#A8A29E") }
    public var border: Color { Color(hex: "#44403C") }
    public var success: Color { Color(hex: "#22C55E") }
    public var warning: Color { Color(hex: "#EAB308") }
    public var error: Color { Color(hex: "#DC2626") }

    public init() {}
}

// Forest Theme
public struct KSForestTheme: KSThemeProtocol {
    public var primary: Color { Color(hex: "#22C55E") }
    public var secondary: Color { Color(hex: "#10B981") }
    public var accent: Color { Color(hex: "#34D399") }
    public var background: Color { Color(hex: "#14532D") }
    public var surface: Color { Color(hex: "#166534") }
    public var textPrimary: Color { Color(hex: "#F0FDF4") }
    public var textSecondary: Color { Color(hex: "#BBF7D0") }
    public var border: Color { Color(hex: "#15803D") }
    public var success: Color { Color(hex: "#4ADE80") }
    public var warning: Color { Color(hex: "#FACC15") }
    public var error: Color { Color(hex: "#F87171") }

    public init() {}
}

// Lavender Theme
public struct KSLavenderTheme: KSThemeProtocol {
    public var primary: Color { Color(hex: "#A855F7") }
    public var secondary: Color { Color(hex: "#C084FC") }
    public var accent: Color { Color(hex: "#E879F9") }
    public var background: Color { Color(hex: "#1E1B4B") }
    public var surface: Color { Color(hex: "#312E81") }
    public var textPrimary: Color { Color(hex: "#F5F3FF") }
    public var textSecondary: Color { Color(hex: "#C4B5FD") }
    public var border: Color { Color(hex: "#4338CA") }
    public var success: Color { Color(hex: "#34D399") }
    public var warning: Color { Color(hex: "#FCD34D") }
    public var error: Color { Color(hex: "#FB7185") }

    public init() {}
}

// MARK: - Environment Key

private struct KSThemeKey: EnvironmentKey {
    static let defaultValue: KSThemeProtocol = KSDefaultTheme()
}

public extension EnvironmentValues {
    var ksTheme: KSThemeProtocol {
        get { self[KSThemeKey.self] }
        set { self[KSThemeKey.self] = newValue }
    }
}

public extension View {
    func ksTheme(_ theme: KSThemeProtocol) -> some View {
        environment(\.ksTheme, theme)
    }
}

// MARK: - Legacy Support (Deprecated)

@available(*, deprecated, message: "Use KSThemeProtocol and KSDefaultTheme instead")
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

@available(*, deprecated, message: "Use KSThemeProtocol colors instead")
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
        background: Color = KS.Colors.background,
        surface: Color = KS.Colors.surface,
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

@available(*, deprecated, message: "Use KS.Typography directly instead")
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

@available(*, deprecated, message: "Use KS.Spacing directly instead")
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
