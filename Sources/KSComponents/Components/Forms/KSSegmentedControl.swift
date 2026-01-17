import SwiftUI

public struct KSSegmentedControl<T: Hashable>: View {
    @Binding var selection: T
    let options: [(value: T, label: String)]

    @Namespace private var namespace

    public init(
        selection: Binding<T>,
        options: [(value: T, label: String)]
    ) {
        self._selection = selection
        self.options = options
    }

    public var body: some View {
        HStack(spacing: 0) {
            ForEach(options, id: \.value) { option in
                Button {
                    withAnimation(.spring(response: 0.3, dampingFraction: 0.7)) {
                        selection = option.value
                    }
                } label: {
                    Text(option.label)
                        .font(KS.Typography.labelMedium)
                        .foregroundStyle(selection == option.value ? KS.Colors.textPrimary : KS.Colors.textSecondary)
                        .padding(.vertical, KS.Spacing.sm)
                        .frame(maxWidth: .infinity)
                        .background {
                            if selection == option.value {
                                RoundedRectangle(cornerRadius: KS.Radius.sm)
                                    .fill(KS.Colors.surface)
                                    .matchedGeometryEffect(id: "segment", in: namespace)
                                    .shadow(color: .black.opacity(0.05), radius: 2, y: 1)
                            }
                        }
                }
                .buttonStyle(.plain)
            }
        }
        .padding(KS.Spacing.xxs)
        .background(KS.Colors.border.opacity(0.5))
        .clipShape(RoundedRectangle(cornerRadius: KS.Radius.md))
    }
}

#Preview {
    struct PreviewWrapper: View {
        @State private var selection = "daily"

        var body: some View {
            VStack(spacing: 30) {
                KSSegmentedControl(
                    selection: $selection,
                    options: [
                        (value: "daily", label: "Daily"),
                        (value: "weekly", label: "Weekly"),
                        (value: "monthly", label: "Monthly")
                    ]
                )

                Text("Selected: \(selection)")
            }
            .padding()
        }
    }

    return PreviewWrapper()
}
