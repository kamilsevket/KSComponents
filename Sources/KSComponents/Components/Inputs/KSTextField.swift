import SwiftUI

// MARK: - KSTextField

public struct KSTextField: View {
    @Binding var text: String
    let placeholder: String
    let label: String?
    let icon: String?
    let helperText: String?
    let errorText: String?
    let isDisabled: Bool

    @FocusState private var isFocused: Bool

    public init(
        _ placeholder: String,
        text: Binding<String>,
        label: String? = nil,
        icon: String? = nil,
        helperText: String? = nil,
        errorText: String? = nil,
        isDisabled: Bool = false
    ) {
        self.placeholder = placeholder
        self._text = text
        self.label = label
        self.icon = icon
        self.helperText = helperText
        self.errorText = errorText
        self.isDisabled = isDisabled
    }

    public var body: some View {
        VStack(alignment: .leading, spacing: KS.Spacing.xs) {
            // Label
            if let label {
                Text(label)
                    .font(KS.Typography.labelMedium)
                    .foregroundStyle(KS.Colors.textSecondary)
            }

            // Input Field
            HStack(spacing: KS.Spacing.sm) {
                if let icon {
                    Image(systemName: icon)
                        .foregroundStyle(iconColor)
                }

                TextField(placeholder, text: $text)
                    .font(KS.Typography.bodyLarge)
                    .focused($isFocused)

                if !text.isEmpty {
                    Button {
                        text = ""
                    } label: {
                        Image(systemName: "xmark.circle.fill")
                            .foregroundStyle(KS.Colors.textTertiary)
                    }
                }
            }
            .padding(.horizontal, KS.Spacing.md)
            .frame(height: 52)
            .background(KS.Colors.surface)
            .clipShape(RoundedRectangle(cornerRadius: KS.Radius.md))
            .overlay(
                RoundedRectangle(cornerRadius: KS.Radius.md)
                    .stroke(borderColor, lineWidth: isFocused ? 2 : 1)
            )
            .animation(.easeInOut(duration: 0.2), value: isFocused)

            // Helper/Error Text
            if let errorText {
                Text(errorText)
                    .font(KS.Typography.caption)
                    .foregroundStyle(KS.Colors.error)
            } else if let helperText {
                Text(helperText)
                    .font(KS.Typography.caption)
                    .foregroundStyle(KS.Colors.textTertiary)
            }
        }
        .disabled(isDisabled)
        .opacity(isDisabled ? 0.5 : 1)
    }

    private var borderColor: Color {
        if errorText != nil {
            return KS.Colors.error
        }
        return isFocused ? KS.Colors.primary : KS.Colors.border
    }

    private var iconColor: Color {
        isFocused ? KS.Colors.primary : KS.Colors.textTertiary
    }
}

// MARK: - Preview

#if DEBUG
#Preview("KSTextField") {
    VStack(spacing: 20) {
        KSTextField(
            "Enter your email",
            text: .constant(""),
            label: "Email",
            icon: "envelope"
        )

        KSTextField(
            "Enter username",
            text: .constant("john_doe"),
            label: "Username",
            icon: "person",
            helperText: "Choose a unique username"
        )

        KSTextField(
            "Enter email",
            text: .constant("invalid-email"),
            label: "Email",
            icon: "envelope",
            errorText: "Please enter a valid email address"
        )

        KSTextField(
            "Disabled field",
            text: .constant(""),
            label: "Disabled",
            isDisabled: true
        )
    }
    .padding()
    .background(KS.Colors.background)
}
#endif
