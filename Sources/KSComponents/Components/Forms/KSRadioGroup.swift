import SwiftUI

public struct KSRadioGroup<T: Hashable>: View {
    @Binding var selection: T
    let options: [(value: T, label: String)]

    public init(
        selection: Binding<T>,
        options: [(value: T, label: String)]
    ) {
        self._selection = selection
        self.options = options
    }

    public var body: some View {
        VStack(alignment: .leading, spacing: KS.Spacing.sm) {
            ForEach(options, id: \.value) { option in
                Button {
                    withAnimation(.spring(response: 0.2, dampingFraction: 0.7)) {
                        selection = option.value
                    }
                } label: {
                    HStack(spacing: KS.Spacing.sm) {
                        Circle()
                            .stroke(selection == option.value ? KS.Colors.primary : KS.Colors.border, lineWidth: 2)
                            .frame(width: 22, height: 22)
                            .overlay(
                                Circle()
                                    .fill(KS.Colors.primary)
                                    .frame(width: 12, height: 12)
                                    .opacity(selection == option.value ? 1 : 0)
                            )

                        Text(option.label)
                            .font(KS.Typography.bodyMedium)
                            .foregroundStyle(KS.Colors.textPrimary)
                    }
                }
                .buttonStyle(.plain)
            }
        }
    }
}

#Preview {
    struct PreviewWrapper: View {
        @State private var selection = "option1"

        var body: some View {
            KSRadioGroup(
                selection: $selection,
                options: [
                    (value: "option1", label: "Option 1"),
                    (value: "option2", label: "Option 2"),
                    (value: "option3", label: "Option 3")
                ]
            )
            .padding()
        }
    }

    return PreviewWrapper()
}
