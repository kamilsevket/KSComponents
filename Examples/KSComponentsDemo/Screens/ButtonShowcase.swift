import SwiftUI
import KSComponents

struct ButtonShowcase: View {
    @State private var isLoading = false

    var body: some View {
        ScrollView {
            VStack(spacing: KS.Spacing.xl) {
                ShowcaseSection("Styles", description: "Different button styles for various use cases") {
                    VStack(spacing: KS.Spacing.md) {
                        KSButton("Primary Button", style: .primary) { }
                        KSButton("Secondary Button", style: .secondary) { }
                        KSButton("Ghost Button", style: .ghost) { }
                        KSButton("Destructive Button", style: .destructive) { }
                        KSButton("Success Button", style: .success) { }
                    }
                }

                ShowcaseSection("Sizes", description: "Available button sizes") {
                    VStack(spacing: KS.Spacing.md) {
                        KSButton("Small", size: .small) { }
                        KSButton("Medium", size: .medium) { }
                        KSButton("Large", size: .large) { }
                    }
                }

                ShowcaseSection("With Icons", description: "Buttons with leading or trailing icons") {
                    VStack(spacing: KS.Spacing.md) {
                        KSButton("Leading Icon", icon: "plus", iconPosition: .leading) { }
                        KSButton("Trailing Icon", icon: "arrow.right", iconPosition: .trailing) { }
                    }
                }

                ShowcaseSection("States", description: "Loading and full-width states") {
                    VStack(spacing: KS.Spacing.md) {
                        KSButton("Loading...", isLoading: true) { }
                        KSButton("Full Width", isFullWidth: true) { }
                    }
                }

                ShowcaseSection("Icon Buttons", description: "Circular icon-only buttons") {
                    HStack(spacing: KS.Spacing.md) {
                        KSIconButton(icon: "heart") { }
                        KSIconButton(icon: "star", style: .primary) { }
                        KSIconButton(icon: "bookmark", style: .secondary) { }
                        KSIconButton(icon: "trash", style: .destructive) { }
                    }
                }

                ShowcaseSection("Floating Action Button", description: "Material-style FAB") {
                    HStack {
                        Spacer()
                        KSFloatingButton { }
                        Spacer()
                    }
                }
            }
            .padding()
        }
        .background(KS.Colors.background)
        .navigationTitle("Buttons")
    }
}

#Preview {
    NavigationStack {
        ButtonShowcase()
    }
}
