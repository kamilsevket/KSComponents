import SwiftUI

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

// MARK: - Preview

#if DEBUG
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
#endif
