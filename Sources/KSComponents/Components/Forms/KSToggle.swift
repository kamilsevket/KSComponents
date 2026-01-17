import SwiftUI

public struct KSToggle: View {
    @Binding var isOn: Bool
    let label: String?
    let description: String?

    public init(
        isOn: Binding<Bool>,
        label: String? = nil,
        description: String? = nil
    ) {
        self._isOn = isOn
        self.label = label
        self.description = description
    }

    public var body: some View {
        HStack {
            if label != nil || description != nil {
                VStack(alignment: .leading, spacing: KS.Spacing.xxs) {
                    if let label {
                        Text(label)
                            .font(KS.Typography.bodyLarge)
                            .foregroundStyle(KS.Colors.textPrimary)
                    }
                    if let description {
                        Text(description)
                            .font(KS.Typography.bodySmall)
                            .foregroundStyle(KS.Colors.textSecondary)
                    }
                }
                Spacer()
            }

            Toggle("", isOn: $isOn)
                .labelsHidden()
                .tint(KS.Colors.primary)
        }
    }
}

#Preview {
    VStack(spacing: 20) {
        KSToggle(isOn: .constant(true), label: "Notifications", description: "Enable push notifications")
        KSToggle(isOn: .constant(false), label: "Dark Mode")
        KSToggle(isOn: .constant(true))
    }
    .padding()
}
