import SwiftUI

// MARK: - KSSecureField

public struct KSSecureField: View {
    @Binding var text: String
    let placeholder: String
    let label: String?
    let helperText: String?
    let errorText: String?
    @State private var isSecure = true
    @FocusState private var isFocused: Bool

    public init(
        _ placeholder: String,
        text: Binding<String>,
        label: String? = nil,
        helperText: String? = nil,
        errorText: String? = nil
    ) {
        self.placeholder = placeholder
        self._text = text
        self.label = label
        self.helperText = helperText
        self.errorText = errorText
    }

    public var body: some View {
        VStack(alignment: .leading, spacing: KS.Spacing.xs) {
            if let label {
                Text(label)
                    .font(KS.Typography.labelMedium)
                    .foregroundStyle(KS.Colors.textSecondary)
            }

            HStack(spacing: KS.Spacing.sm) {
                Image(systemName: "lock")
                    .foregroundStyle(isFocused ? KS.Colors.primary : KS.Colors.textTertiary)

                Group {
                    if isSecure {
                        SecureField(placeholder, text: $text)
                    } else {
                        TextField(placeholder, text: $text)
                    }
                }
                .font(KS.Typography.bodyLarge)
                .focused($isFocused)

                Button {
                    isSecure.toggle()
                } label: {
                    Image(systemName: isSecure ? "eye" : "eye.slash")
                        .foregroundStyle(KS.Colors.textTertiary)
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
    }

    private var borderColor: Color {
        if errorText != nil {
            return KS.Colors.error
        }
        return isFocused ? KS.Colors.primary : KS.Colors.border
    }
}

// MARK: - Preview

#if DEBUG
#Preview("KSSecureField") {
    VStack(spacing: 20) {
        KSSecureField(
            "Enter password",
            text: .constant(""),
            label: "Password"
        )

        KSSecureField(
            "Enter password",
            text: .constant("password123"),
            label: "Password",
            helperText: "Must be at least 8 characters"
        )

        KSSecureField(
            "Enter password",
            text: .constant("short"),
            label: "Password",
            errorText: "Password is too short"
        )
    }
    .padding()
    .background(KS.Colors.background)
}
#endif
