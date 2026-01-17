import SwiftUI
import KSComponents

struct ListShowcase: View {
    @State private var toggleValue = true
    @State private var swipeOffset: CGFloat = 0

    var body: some View {
        ScrollView {
            VStack(spacing: KS.Spacing.xl) {
                ShowcaseSection("Row Component", description: "Versatile list row with accessories") {
                    VStack(spacing: 0) {
                        KSRow(
                            icon: "person.fill",
                            title: "Profile",
                            subtitle: "View and edit your profile"
                        )

                        KSDivider()

                        KSRow(
                            icon: "bell.fill",
                            iconColor: KS.Colors.warning,
                            title: "Notifications",
                            value: "On"
                        )

                        KSDivider()

                        KSRow(
                            icon: "moon.fill",
                            iconColor: KS.Colors.secondary,
                            title: "Dark Mode",
                            accessory: .toggle($toggleValue)
                        )

                        KSDivider()

                        KSRow(
                            icon: "checkmark.circle.fill",
                            iconColor: KS.Colors.success,
                            title: "Completed",
                            accessory: .checkmark(true)
                        )

                        KSDivider()

                        KSRow(
                            icon: "gear",
                            title: "Settings",
                            accessory: .none
                        )
                    }
                    .background(KS.Colors.surface)
                    .clipShape(RoundedRectangle(cornerRadius: KS.Radius.md))
                }

                ShowcaseSection("Section Header", description: "Group rows with headers") {
                    VStack(spacing: 0) {
                        KSSectionHeader(title: "Account")

                        KSRow(icon: "person.fill", title: "Profile")

                        KSDivider()

                        KSRow(icon: "lock.fill", title: "Security")

                        KSSectionHeader(title: "Preferences", action: ("See All", { }))

                        KSRow(icon: "bell.fill", title: "Notifications")

                        KSDivider()

                        KSRow(icon: "globe", title: "Language", value: "English")
                    }
                }

                ShowcaseSection("Divider Styles", description: "Full and inset dividers") {
                    VStack(spacing: KS.Spacing.md) {
                        VStack(spacing: 0) {
                            Text("Item 1")
                                .frame(maxWidth: .infinity, alignment: .leading)
                                .padding(.vertical, KS.Spacing.sm)
                            KSDivider()
                            Text("Item 2")
                                .frame(maxWidth: .infinity, alignment: .leading)
                                .padding(.vertical, KS.Spacing.sm)
                            KSDivider(style: .inset)
                            Text("Item 3")
                                .frame(maxWidth: .infinity, alignment: .leading)
                                .padding(.vertical, KS.Spacing.sm)
                        }
                    }
                }

                ShowcaseSection("Grouped List", description: "List with grouped sections") {
                    KSGroupedList {
                        KSRow(icon: "star.fill", iconColor: .yellow, title: "Favorites")
                        KSRow(icon: "clock.fill", iconColor: .blue, title: "Recent")
                        KSRow(icon: "folder.fill", iconColor: .orange, title: "Documents")
                    }
                }

                ShowcaseSection("Swipeable Row", description: "Row with swipe actions") {
                    KSSwipeableRow(
                        leadingActions: [
                            .init(
                                icon: "pin.fill",
                                color: .orange,
                                action: { }
                            )
                        ],
                        trailingActions: [
                            .init(
                                icon: "trash.fill",
                                color: .red,
                                action: { }
                            ),
                            .init(
                                icon: "flag.fill",
                                color: .blue,
                                action: { }
                            )
                        ]
                    ) {
                        KSRow(
                            icon: "envelope.fill",
                            title: "Swipe Me",
                            subtitle: "Swipe left or right to see actions"
                        )
                    }
                }
            }
            .padding()
        }
        .background(KS.Colors.background)
        .navigationTitle("Lists")
    }
}

#Preview {
    NavigationStack {
        ListShowcase()
    }
}
