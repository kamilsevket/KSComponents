import SwiftUI

// MARK: - KSRow

public struct KSRow: View {
    let icon: String?
    let iconColor: Color
    let title: String
    let subtitle: String?
    let value: String?
    let accessory: Accessory

    public enum Accessory {
        case none
        case chevron
        case toggle(Binding<Bool>)
        case checkmark(Bool)
        case custom(AnyView)
    }

    public init(
        icon: String? = nil,
        iconColor: Color = KS.Colors.primary,
        title: String,
        subtitle: String? = nil,
        value: String? = nil,
        accessory: Accessory = .chevron
    ) {
        self.icon = icon
        self.iconColor = iconColor
        self.title = title
        self.subtitle = subtitle
        self.value = value
        self.accessory = accessory
    }

    public var body: some View {
        HStack(spacing: KS.Spacing.md) {
            // Icon
            if let icon {
                Image(systemName: icon)
                    .font(.body)
                    .foregroundStyle(iconColor)
                    .frame(width: 28, height: 28)
            }

            // Content
            VStack(alignment: .leading, spacing: 2) {
                Text(title)
                    .font(KS.Typography.bodyLarge)
                    .foregroundStyle(KS.Colors.textPrimary)

                if let subtitle {
                    Text(subtitle)
                        .font(KS.Typography.bodySmall)
                        .foregroundStyle(KS.Colors.textSecondary)
                }
            }

            Spacer()

            // Value
            if let value {
                Text(value)
                    .font(KS.Typography.bodyMedium)
                    .foregroundStyle(KS.Colors.textSecondary)
            }

            // Accessory
            accessoryView
        }
        .padding(.vertical, KS.Spacing.sm)
    }

    @ViewBuilder
    private var accessoryView: some View {
        switch accessory {
        case .none:
            EmptyView()
        case .chevron:
            Image(systemName: "chevron.right")
                .font(.caption.weight(.semibold))
                .foregroundStyle(KS.Colors.textTertiary)
        case .toggle(let binding):
            Toggle("", isOn: binding)
                .labelsHidden()
                .tint(KS.Colors.primary)
        case .checkmark(let isChecked):
            if isChecked {
                Image(systemName: "checkmark")
                    .font(.body.weight(.semibold))
                    .foregroundStyle(KS.Colors.primary)
            }
        case .custom(let view):
            view
        }
    }
}

// MARK: - Preview

#if DEBUG
struct KSRow_Previews: PreviewProvider {
    static var previews: some View {
        VStack(spacing: 0) {
            KSRow(
                icon: "person.fill",
                title: "Profile",
                subtitle: "View and edit your profile"
            )

            KSRow(
                icon: "bell.fill",
                iconColor: KS.Colors.warning,
                title: "Notifications",
                value: "On"
            )

            KSRow(
                icon: "gear",
                title: "Settings",
                accessory: .none
            )

            KSRow(
                icon: "moon.fill",
                iconColor: KS.Colors.secondary,
                title: "Dark Mode",
                accessory: .toggle(.constant(true))
            )

            KSRow(
                icon: "checkmark.circle.fill",
                iconColor: KS.Colors.success,
                title: "Completed",
                accessory: .checkmark(true)
            )
        }
        .padding()
        .background(KS.Colors.surface)
    }
}
#endif
