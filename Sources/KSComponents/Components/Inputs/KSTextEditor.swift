import SwiftUI

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

// MARK: - Preview

#if DEBUG
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
