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

// MARK: - KSSearchField

public struct KSSearchField: View {
    @Binding var text: String
    let placeholder: String
    let onSubmit: (() -> Void)?
    @FocusState private var isFocused: Bool

    public init(
        _ placeholder: String = "Search...",
        text: Binding<String>,
        onSubmit: (() -> Void)? = nil
    ) {
        self.placeholder = placeholder
        self._text = text
        self.onSubmit = onSubmit
    }

    public var body: some View {
        HStack(spacing: KS.Spacing.sm) {
            Image(systemName: "magnifyingglass")
                .foregroundStyle(KS.Colors.textTertiary)

            TextField(placeholder, text: $text)
                .font(KS.Typography.bodyMedium)
                .focused($isFocused)
                .onSubmit {
                    onSubmit?()
                }

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
        .frame(height: 44)
        .background(KS.Colors.surface)
        .clipShape(Capsule())
        .overlay(
            Capsule()
                .stroke(isFocused ? KS.Colors.primary : KS.Colors.border, lineWidth: 1)
        )
        .animation(.easeInOut(duration: 0.2), value: isFocused)
    }
}

// MARK: - KSTextEditor

public struct KSTextEditor: View {
    @Binding var text: String
    let placeholder: String
    let label: String?
    let minHeight: CGFloat
    let maxHeight: CGFloat
    let characterLimit: Int?
    @FocusState private var isFocused: Bool

    public init(
        _ placeholder: String,
        text: Binding<String>,
        label: String? = nil,
        minHeight: CGFloat = 100,
        maxHeight: CGFloat = 200,
        characterLimit: Int? = nil
    ) {
        self.placeholder = placeholder
        self._text = text
        self.label = label
        self.minHeight = minHeight
        self.maxHeight = maxHeight
        self.characterLimit = characterLimit
    }

    public var body: some View {
        VStack(alignment: .leading, spacing: KS.Spacing.xs) {
            if let label {
                Text(label)
                    .font(KS.Typography.labelMedium)
                    .foregroundStyle(KS.Colors.textSecondary)
            }

            ZStack(alignment: .topLeading) {
                if text.isEmpty {
                    Text(placeholder)
                        .font(KS.Typography.bodyLarge)
                        .foregroundStyle(KS.Colors.textTertiary)
                        .padding(.top, KS.Spacing.sm)
                        .padding(.leading, KS.Spacing.xs)
                }

                TextEditor(text: $text)
                    .font(KS.Typography.bodyLarge)
                    .scrollContentBackground(.hidden)
                    .frame(minHeight: minHeight, maxHeight: maxHeight)
                    .focused($isFocused)
            }
            .padding(KS.Spacing.sm)
            .background(KS.Colors.surface)
            .clipShape(RoundedRectangle(cornerRadius: KS.Radius.md))
            .overlay(
                RoundedRectangle(cornerRadius: KS.Radius.md)
                    .stroke(isFocused ? KS.Colors.primary : KS.Colors.border, lineWidth: isFocused ? 2 : 1)
            )
            .animation(.easeInOut(duration: 0.2), value: isFocused)

            if let limit = characterLimit {
                HStack {
                    Spacer()
                    Text("\(text.count)/\(limit)")
                        .font(KS.Typography.caption)
                        .foregroundStyle(text.count > limit ? KS.Colors.error : KS.Colors.textTertiary)
                }
            }
        }
        .onChange(of: text) { _, newValue in
            if let limit = characterLimit, newValue.count > limit {
                text = String(newValue.prefix(limit))
            }
        }
    }
}

// MARK: - Previews

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

#Preview("KSSearchField") {
    VStack(spacing: 20) {
        KSSearchField(text: .constant(""))

        KSSearchField(
            "Search users...",
            text: .constant("John")
        )
    }
    .padding()
    .background(KS.Colors.background)
}

#Preview("KSTextEditor") {
    VStack(spacing: 20) {
        KSTextEditor(
            "Write your bio...",
            text: .constant(""),
            label: "Bio"
        )

        KSTextEditor(
            "Write a message...",
            text: .constant("Hello, this is a sample text."),
            label: "Message",
            characterLimit: 100
        )
    }
    .padding()
    .background(KS.Colors.background)
}
#endif
