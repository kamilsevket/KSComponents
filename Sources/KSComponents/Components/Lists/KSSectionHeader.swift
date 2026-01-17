import SwiftUI

// MARK: - KSSectionHeader

public struct KSSectionHeader: View {
    let title: String
    let action: (() -> Void)?
    let actionTitle: String?

    public init(
        _ title: String,
        action: (() -> Void)? = nil,
        actionTitle: String? = nil
    ) {
        self.title = title
        self.action = action
        self.actionTitle = actionTitle
    }

    public var body: some View {
        HStack {
            Text(title.uppercased())
                .font(KS.Typography.labelSmall)
                .foregroundStyle(KS.Colors.textSecondary)
                .tracking(0.5)

            Spacer()

            if let action, let actionTitle {
                Button(action: action) {
                    Text(actionTitle)
                        .font(KS.Typography.labelMedium)
                        .foregroundStyle(KS.Colors.primary)
                }
            }
        }
        .padding(.horizontal, KS.Spacing.md)
        .padding(.vertical, KS.Spacing.sm)
    }
}

// MARK: - Preview

#if DEBUG
struct KSSectionHeader_Previews: PreviewProvider {
    static var previews: some View {
        VStack(spacing: KS.Spacing.lg) {
            KSSectionHeader("Account")

            KSSectionHeader("Notifications", action: {
                print("See All tapped")
            }, actionTitle: "See All")

            KSSectionHeader("Recent Items", action: {
                print("Clear tapped")
            }, actionTitle: "Clear")
        }
        .padding()
        .background(KS.Colors.background)
    }
}
#endif
