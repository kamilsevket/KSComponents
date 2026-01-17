import SwiftUI

/// A custom alert component with icon, title, message, and action buttons
public struct KSAlert: View {
    @Binding var isPresented: Bool
    let icon: String?
    let iconColor: Color
    let title: String
    let message: String?
    let primaryButton: AlertButton
    let secondaryButton: AlertButton?

    public struct AlertButton {
        let title: String
        let style: KSButton.Style
        let action: () -> Void

        public init(title: String, style: KSButton.Style = .primary, action: @escaping () -> Void) {
            self.title = title
            self.style = style
            self.action = action
        }
    }

    public init(
        isPresented: Binding<Bool>,
        icon: String? = nil,
        iconColor: Color = KS.Colors.primary,
        title: String,
        message: String? = nil,
        primaryButton: AlertButton,
        secondaryButton: AlertButton? = nil
    ) {
        self._isPresented = isPresented
        self.icon = icon
        self.iconColor = iconColor
        self.title = title
        self.message = message
        self.primaryButton = primaryButton
        self.secondaryButton = secondaryButton
    }

    public var body: some View {
        ZStack {
            // Backdrop
            Color.black.opacity(0.4)
                .ignoresSafeArea()
                .onTapGesture {
                    withAnimation(.spring()) {
                        isPresented = false
                    }
                }

            // Alert Card
            VStack(spacing: KS.Spacing.lg) {
                // Icon
                if let icon {
                    Image(systemName: icon)
                        .font(.system(size: 48))
                        .foregroundStyle(iconColor)
                }

                // Title & Message
                VStack(spacing: KS.Spacing.xxs) {
                    Text(title)
                        .font(KS.Typography.headlineSmall)
                        .foregroundStyle(KS.Colors.textPrimary)
                        .multilineTextAlignment(.center)

                    if let message {
                        Text(message)
                            .font(KS.Typography.bodyMedium)
                            .foregroundStyle(KS.Colors.textSecondary)
                            .multilineTextAlignment(.center)
                    }
                }

                // Buttons
                VStack(spacing: KS.Spacing.xs) {
                    KSButton(primaryButton.title, style: primaryButton.style, isFullWidth: true) {
                        primaryButton.action()
                        withAnimation { isPresented = false }
                    }

                    if let secondary = secondaryButton {
                        KSButton(secondary.title, style: secondary.style, isFullWidth: true) {
                            secondary.action()
                            withAnimation { isPresented = false }
                        }
                    }
                }
            }
            .padding(KS.Spacing.lg)
            .background(KS.Colors.surface)
            .clipShape(RoundedRectangle(cornerRadius: KS.Radius.xl))
            .padding(.horizontal, KS.Spacing.xl)
            .transition(.scale.combined(with: .opacity))
        }
        .opacity(isPresented ? 1 : 0)
        .animation(.spring(response: 0.3, dampingFraction: 0.7), value: isPresented)
    }
}

// MARK: - View Modifier for presenting KSAlert

public struct KSAlertModifier: ViewModifier {
    @Binding var isPresented: Bool
    let icon: String?
    let iconColor: Color
    let title: String
    let message: String?
    let primaryButton: KSAlert.AlertButton
    let secondaryButton: KSAlert.AlertButton?

    public func body(content: Content) -> some View {
        ZStack {
            content

            if isPresented {
                KSAlert(
                    isPresented: $isPresented,
                    icon: icon,
                    iconColor: iconColor,
                    title: title,
                    message: message,
                    primaryButton: primaryButton,
                    secondaryButton: secondaryButton
                )
            }
        }
    }
}

public extension View {
    func ksAlert(
        isPresented: Binding<Bool>,
        icon: String? = nil,
        iconColor: Color = KS.Colors.primary,
        title: String,
        message: String? = nil,
        primaryButton: KSAlert.AlertButton,
        secondaryButton: KSAlert.AlertButton? = nil
    ) -> some View {
        modifier(KSAlertModifier(
            isPresented: isPresented,
            icon: icon,
            iconColor: iconColor,
            title: title,
            message: message,
            primaryButton: primaryButton,
            secondaryButton: secondaryButton
        ))
    }
}

// MARK: - Previews

#Preview("KSAlert") {
    ZStack {
        Color.gray.opacity(0.3)
            .ignoresSafeArea()

        KSAlert(
            isPresented: .constant(true),
            icon: "exclamationmark.triangle.fill",
            iconColor: .orange,
            title: "Delete Item?",
            message: "This action cannot be undone. Are you sure you want to continue?",
            primaryButton: .init(title: "Delete", style: .destructive, action: {}),
            secondaryButton: .init(title: "Cancel", style: .ghost, action: {})
        )
    }
}

#Preview("Success Alert") {
    ZStack {
        Color.gray.opacity(0.3)
            .ignoresSafeArea()

        KSAlert(
            isPresented: .constant(true),
            icon: "checkmark.circle.fill",
            iconColor: KS.Colors.success,
            title: "Success!",
            message: "Your changes have been saved successfully.",
            primaryButton: .init(title: "OK", style: .success, action: {})
        )
    }
}
