import SwiftUI

public struct KSNavBar: View {
    let title: String
    let subtitle: String?
    let leadingButton: NavButton?
    let trailingButtons: [NavButton]

    public struct NavButton {
        let icon: String
        let action: () -> Void

        public init(icon: String, action: @escaping () -> Void) {
            self.icon = icon
            self.action = action
        }
    }

    public init(
        title: String,
        subtitle: String? = nil,
        leadingButton: NavButton? = nil,
        trailingButtons: [NavButton] = []
    ) {
        self.title = title
        self.subtitle = subtitle
        self.leadingButton = leadingButton
        self.trailingButtons = trailingButtons
    }

    public var body: some View {
        HStack(spacing: KS.Spacing.md) {
            // Leading
            if let button = leadingButton {
                Button(action: button.action) {
                    Image(systemName: button.icon)
                        .font(.title3)
                        .foregroundStyle(KS.Colors.textPrimary)
                }
            }

            // Title
            VStack(alignment: leadingButton == nil ? .leading : .center, spacing: 2) {
                Text(title)
                    .font(KS.Typography.titleMedium)
                    .foregroundStyle(KS.Colors.textPrimary)

                if let subtitle {
                    Text(subtitle)
                        .font(KS.Typography.caption)
                        .foregroundStyle(KS.Colors.textSecondary)
                }
            }
            .frame(maxWidth: .infinity, alignment: leadingButton == nil ? .leading : .center)

            // Trailing
            HStack(spacing: KS.Spacing.sm) {
                ForEach(trailingButtons.indices, id: \.self) { index in
                    Button(action: trailingButtons[index].action) {
                        Image(systemName: trailingButtons[index].icon)
                            .font(.title3)
                            .foregroundStyle(KS.Colors.textPrimary)
                    }
                }
            }
        }
        .padding(.horizontal, KS.Spacing.md)
        .padding(.vertical, KS.Spacing.sm)
        .background(KS.Colors.surface)
    }
}

#Preview {
    VStack(spacing: 20) {
        // Simple title
        KSNavBar(title: "Home")

        Divider()

        // With subtitle
        KSNavBar(
            title: "Messages",
            subtitle: "3 unread"
        )

        Divider()

        // With leading button (back)
        KSNavBar(
            title: "Details",
            leadingButton: .init(icon: "chevron.left") {
                print("Back tapped")
            }
        )

        Divider()

        // Full navigation bar
        KSNavBar(
            title: "Profile",
            subtitle: "Online",
            leadingButton: .init(icon: "chevron.left") {
                print("Back tapped")
            },
            trailingButtons: [
                .init(icon: "bell") { print("Notifications") },
                .init(icon: "gearshape") { print("Settings") }
            ]
        )

        Spacer()
    }
}
