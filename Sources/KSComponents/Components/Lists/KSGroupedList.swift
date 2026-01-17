import SwiftUI

// MARK: - KSGroupedList

public struct KSGroupedList<Content: View>: View {
    let content: Content

    public init(@ViewBuilder content: () -> Content) {
        self.content = content()
    }

    public var body: some View {
        VStack(spacing: 0) {
            content
        }
        .background(KS.Colors.surface)
        .clipShape(RoundedRectangle(cornerRadius: KS.Radius.lg))
    }
}

// MARK: - Preview

#if DEBUG
struct KSGroupedList_Previews: PreviewProvider {
    static var previews: some View {
        VStack(spacing: KS.Spacing.lg) {
            KSSectionHeader("General")

            KSGroupedList {
                KSRow(
                    icon: "person.fill",
                    title: "Profile",
                    subtitle: "View your profile"
                )
                .padding(.horizontal, KS.Spacing.md)

                KSDivider(inset: 60)

                KSRow(
                    icon: "gear",
                    title: "Settings"
                )
                .padding(.horizontal, KS.Spacing.md)

                KSDivider(inset: 60)

                KSRow(
                    icon: "bell.fill",
                    title: "Notifications",
                    accessory: .toggle(.constant(true))
                )
                .padding(.horizontal, KS.Spacing.md)
            }

            KSSectionHeader("Privacy", action: {}, actionTitle: "Learn More")

            KSGroupedList {
                KSRow(
                    icon: "lock.fill",
                    iconColor: KS.Colors.success,
                    title: "Privacy Settings"
                )
                .padding(.horizontal, KS.Spacing.md)

                KSDivider(inset: 60)

                KSRow(
                    icon: "hand.raised.fill",
                    iconColor: KS.Colors.warning,
                    title: "Data & Permissions"
                )
                .padding(.horizontal, KS.Spacing.md)
            }
        }
        .padding()
        .background(KS.Colors.background)
    }
}
#endif
