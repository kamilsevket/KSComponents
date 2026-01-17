import SwiftUI

// MARK: - KSButton

public struct KSButton: View {
    public enum Style {
        case primary
        case secondary
        case ghost
        case destructive
        case success
    }

    public enum Size {
        case small
        case medium
        case large

        var height: CGFloat {
            switch self {
            case .small: 36
            case .medium: 44
            case .large: 56
            }
        }

        var font: Font {
            switch self {
            case .small: KS.Typography.labelMedium
            case .medium: KS.Typography.labelLarge
            case .large: KS.Typography.titleSmall
            }
        }

        var padding: CGFloat {
            switch self {
            case .small: KS.Spacing.sm
            case .medium: KS.Spacing.md
            case .large: KS.Spacing.lg
            }
        }
    }

    public enum IconPosition {
        case leading
        case trailing
    }

    let title: String
    let style: Style
    let size: Size
    let icon: String?
    let iconPosition: IconPosition
    let isLoading: Bool
    let isFullWidth: Bool
    let action: () -> Void

    public init(
        _ title: String,
        style: Style = .primary,
        size: Size = .medium,
        icon: String? = nil,
        iconPosition: IconPosition = .leading,
        isLoading: Bool = false,
        isFullWidth: Bool = false,
        action: @escaping () -> Void
    ) {
        self.title = title
        self.style = style
        self.size = size
        self.icon = icon
        self.iconPosition = iconPosition
        self.isLoading = isLoading
        self.isFullWidth = isFullWidth
        self.action = action
    }

    public var body: some View {
        Button(action: action) {
            HStack(spacing: KS.Spacing.xs) {
                if isLoading {
                    ProgressView()
                        .tint(foregroundColor)
                } else {
                    if let icon, iconPosition == .leading {
                        Image(systemName: icon)
                    }

                    Text(title)

                    if let icon, iconPosition == .trailing {
                        Image(systemName: icon)
                    }
                }
            }
            .font(size.font)
            .foregroundStyle(foregroundColor)
            .frame(height: size.height)
            .frame(maxWidth: isFullWidth ? .infinity : nil)
            .padding(.horizontal, size.padding)
            .background(backgroundColor)
            .clipShape(RoundedRectangle(cornerRadius: KS.Radius.md))
            .overlay(
                RoundedRectangle(cornerRadius: KS.Radius.md)
                    .stroke(borderColor, lineWidth: style == .ghost ? 1.5 : 0)
            )
        }
        .buttonStyle(KSButtonStyle())
        .disabled(isLoading)
    }

    private var foregroundColor: Color {
        switch style {
        case .primary, .destructive, .success: .white
        case .secondary: KS.Colors.primary
        case .ghost: KS.Colors.textPrimary
        }
    }

    private var backgroundColor: Color {
        switch style {
        case .primary: KS.Colors.primary
        case .secondary: KS.Colors.primary.opacity(0.1)
        case .ghost: .clear
        case .destructive: KS.Colors.error
        case .success: KS.Colors.success
        }
    }

    private var borderColor: Color {
        style == .ghost ? KS.Colors.border : .clear
    }
}

// MARK: - KSIconButton

public struct KSIconButton: View {
    let icon: String
    let size: KSButton.Size
    let style: KSButton.Style
    let action: () -> Void

    public init(
        icon: String,
        size: KSButton.Size = .medium,
        style: KSButton.Style = .ghost,
        action: @escaping () -> Void
    ) {
        self.icon = icon
        self.size = size
        self.style = style
        self.action = action
    }

    public var body: some View {
        Button(action: action) {
            Image(systemName: icon)
                .font(size.font)
                .foregroundStyle(foregroundColor)
                .frame(width: size.height, height: size.height)
                .background(backgroundColor)
                .clipShape(Circle())
        }
        .buttonStyle(KSButtonStyle())
    }

    private var foregroundColor: Color {
        switch style {
        case .primary: .white
        case .secondary, .ghost: KS.Colors.primary
        case .destructive: .white
        case .success: .white
        }
    }

    private var backgroundColor: Color {
        switch style {
        case .primary: KS.Colors.primary
        case .secondary: KS.Colors.primary.opacity(0.1)
        case .ghost: KS.Colors.surface
        case .destructive: KS.Colors.error
        case .success: KS.Colors.success
        }
    }
}

// MARK: - KSFloatingButton (FAB)

public struct KSFloatingButton: View {
    let icon: String
    let action: () -> Void

    public init(icon: String = "plus", action: @escaping () -> Void) {
        self.icon = icon
        self.action = action
    }

    public var body: some View {
        Button(action: action) {
            Image(systemName: icon)
                .font(.title2.weight(.semibold))
                .foregroundStyle(.white)
                .frame(width: 56, height: 56)
                .background(KS.Colors.primary)
                .clipShape(Circle())
                .ksShadow(KS.Shadows.lg)
        }
        .buttonStyle(KSButtonStyle())
    }
}

// MARK: - Button Style with Press Animation

public struct KSButtonStyle: ButtonStyle {
    public init() {}

    public func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .scaleEffect(configuration.isPressed ? 0.96 : 1.0)
            .opacity(configuration.isPressed ? 0.9 : 1.0)
            .animation(.spring(response: 0.2, dampingFraction: 0.7), value: configuration.isPressed)
    }
}

// MARK: - Previews

#Preview("Button Styles") {
    VStack(spacing: 16) {
        KSButton("Primary Button", style: .primary) {}
        KSButton("Secondary Button", style: .secondary) {}
        KSButton("Ghost Button", style: .ghost) {}
        KSButton("Destructive Button", style: .destructive) {}
        KSButton("Success Button", style: .success) {}
    }
    .padding()
}

#Preview("Button Sizes") {
    VStack(spacing: 16) {
        KSButton("Small", size: .small) {}
        KSButton("Medium", size: .medium) {}
        KSButton("Large", size: .large) {}
    }
    .padding()
}

#Preview("Button with Icon") {
    VStack(spacing: 16) {
        KSButton("Add Item", icon: "plus") {}
        KSButton("Next", icon: "arrow.right", iconPosition: .trailing) {}
        KSButton("Loading...", isLoading: true) {}
        KSButton("Full Width", isFullWidth: true) {}
    }
    .padding()
}

#Preview("Icon Buttons") {
    HStack(spacing: 16) {
        KSIconButton(icon: "heart.fill", style: .primary) {}
        KSIconButton(icon: "star.fill", style: .secondary) {}
        KSIconButton(icon: "bookmark.fill", style: .ghost) {}
        KSIconButton(icon: "trash.fill", style: .destructive) {}
    }
    .padding()
}

#Preview("Floating Button") {
    ZStack {
        Color.gray.opacity(0.1)
        VStack {
            Spacer()
            HStack {
                Spacer()
                KSFloatingButton(icon: "plus") {}
                    .padding()
            }
        }
    }
}
