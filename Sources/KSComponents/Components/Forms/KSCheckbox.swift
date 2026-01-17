import SwiftUI

public struct KSCheckbox: View {
    @Binding var isChecked: Bool
    let label: String

    public init(isChecked: Binding<Bool>, label: String) {
        self._isChecked = isChecked
        self.label = label
    }

    public var body: some View {
        Button {
            withAnimation(.spring(response: 0.2, dampingFraction: 0.7)) {
                isChecked.toggle()
            }
        } label: {
            HStack(spacing: KS.Spacing.sm) {
                ZStack {
                    RoundedRectangle(cornerRadius: KS.Radius.xs)
                        .stroke(isChecked ? KS.Colors.primary : KS.Colors.border, lineWidth: 2)
                        .frame(width: 22, height: 22)

                    if isChecked {
                        RoundedRectangle(cornerRadius: KS.Radius.xs)
                            .fill(KS.Colors.primary)
                            .frame(width: 22, height: 22)

                        Image(systemName: "checkmark")
                            .font(.caption.weight(.bold))
                            .foregroundStyle(.white)
                    }
                }

                Text(label)
                    .font(KS.Typography.bodyMedium)
                    .foregroundStyle(KS.Colors.textPrimary)
            }
        }
        .buttonStyle(.plain)
    }
}

#Preview {
    VStack(alignment: .leading, spacing: 16) {
        KSCheckbox(isChecked: .constant(true), label: "Accept terms and conditions")
        KSCheckbox(isChecked: .constant(false), label: "Subscribe to newsletter")
        KSCheckbox(isChecked: .constant(true), label: "Remember me")
    }
    .padding()
}
