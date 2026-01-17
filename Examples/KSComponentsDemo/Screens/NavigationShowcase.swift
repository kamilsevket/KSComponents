import SwiftUI
import KSComponents

struct NavigationShowcase: View {
    @State private var selectedTab = 0
    @State private var showBottomSheet = false

    var body: some View {
        ScrollView {
            VStack(spacing: KS.Spacing.xl) {
                ShowcaseSection("Tab Bar", description: "Bottom navigation with icons") {
                    KSTabBar(
                        selectedIndex: $selectedTab,
                        items: [
                            .init(icon: "house", title: "Home"),
                            .init(icon: "magnifyingglass", selectedIcon: "magnifyingglass", title: "Search"),
                            .init(icon: "heart", title: "Favorites"),
                            .init(icon: "person", title: "Profile")
                        ]
                    )
                }

                ShowcaseSection("Floating Tab Bar", description: "Floating style tab navigation") {
                    KSFloatingTabBar(
                        selectedIndex: $selectedTab,
                        items: [
                            .init(icon: "house", title: "Home"),
                            .init(icon: "magnifyingglass", title: "Search"),
                            .init(icon: "heart", title: "Favorites")
                        ]
                    )
                }

                ShowcaseSection("Navigation Bar", description: "Top navigation with actions") {
                    VStack(spacing: KS.Spacing.md) {
                        KSNavBar(
                            title: "Settings",
                            leadingButton: .init(icon: "chevron.left") { }
                        )

                        KSNavBar(
                            title: "Profile",
                            leadingButton: .init(icon: "chevron.left") { },
                            trailingButtons: [.init(icon: "gearshape") { }]
                        )

                        KSNavBar(
                            title: "Messages",
                            trailingButtons: [.init(icon: "plus") { }]
                        )
                    }
                }

                ShowcaseSection("Bottom Sheet", description: "Slide-up modal panel") {
                    KSButton("Show Bottom Sheet", style: .primary) {
                        showBottomSheet = true
                    }
                }
            }
            .padding()
        }
        .background(KS.Colors.background)
        .navigationTitle("Navigation")
        .sheet(isPresented: $showBottomSheet) {
            KSBottomSheet(isPresented: $showBottomSheet) {
                VStack(spacing: KS.Spacing.lg) {
                    Text("Bottom Sheet")
                        .font(KS.Typography.headlineSmall)

                    Text("This is a bottom sheet that can contain any content.")
                        .font(KS.Typography.bodyMedium)
                        .foregroundStyle(KS.Colors.textSecondary)

                    KSButton("Close", style: .primary, isFullWidth: true) {
                        showBottomSheet = false
                    }
                }
                .padding()
            }
            .presentationDetents([.medium, .large])
        }
    }
}

#Preview {
    NavigationStack {
        NavigationShowcase()
    }
}
