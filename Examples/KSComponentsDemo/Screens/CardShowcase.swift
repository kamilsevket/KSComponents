import SwiftUI
import KSComponents

struct CardShowcase: View {
    var body: some View {
        ScrollView {
            VStack(spacing: KS.Spacing.xl) {
                ShowcaseSection("Card Styles", description: "Flat, elevated, and outlined styles") {
                    VStack(spacing: KS.Spacing.md) {
                        KSCard(style: .flat) {
                            Text("Flat Card")
                                .frame(maxWidth: .infinity)
                        }

                        KSCard(style: .elevated) {
                            Text("Elevated Card")
                                .frame(maxWidth: .infinity)
                        }

                        KSCard(style: .outlined) {
                            Text("Outlined Card")
                                .frame(maxWidth: .infinity)
                        }
                    }
                }

                ShowcaseSection("Interactive Card", description: "Tappable card with animation") {
                    KSInteractiveCard(action: { }) {
                        VStack(alignment: .leading, spacing: KS.Spacing.xs) {
                            Text("Interactive Card")
                                .font(KS.Typography.titleMedium)
                            Text("Tap me to see the animation")
                                .font(KS.Typography.bodySmall)
                                .foregroundStyle(KS.Colors.textSecondary)
                        }
                        .frame(maxWidth: .infinity, alignment: .leading)
                    }
                }

                ShowcaseSection("Image Card", description: "Card with async image loading") {
                    KSImageCard(
                        imageURL: URL(string: "https://picsum.photos/400/200"),
                        title: "Beautiful Landscape",
                        subtitle: "A stunning view of nature"
                    )
                }

                ShowcaseSection("Gradient Cards", description: "Cards with gradient backgrounds") {
                    VStack(spacing: KS.Spacing.md) {
                        KSGradientCard(gradient: KS.Colors.gradientPrimary) {
                            VStack(alignment: .leading, spacing: KS.Spacing.xs) {
                                Text("Premium Feature")
                                    .font(KS.Typography.titleMedium)
                                    .foregroundStyle(.white)
                                Text("Upgrade to unlock")
                                    .font(KS.Typography.bodySmall)
                                    .foregroundStyle(.white.opacity(0.8))
                            }
                            .frame(maxWidth: .infinity, alignment: .leading)
                        }

                        KSGradientCard(gradient: KS.Colors.gradientSunrise) {
                            Text("Sunrise Gradient")
                                .foregroundStyle(.white)
                        }

                        KSGradientCard(gradient: KS.Colors.gradientOcean) {
                            Text("Ocean Gradient")
                                .foregroundStyle(.white)
                        }
                    }
                }

                ShowcaseSection("List Card", description: "Card styled as list item") {
                    VStack(spacing: KS.Spacing.sm) {
                        KSListCard(
                            icon: "person.fill",
                            title: "Profile",
                            subtitle: "View and edit your profile"
                        )

                        KSListCard(
                            icon: "gear",
                            title: "Settings",
                            trailing: "3"
                        )

                        KSListCard(
                            icon: "bell.fill",
                            title: "Notifications",
                            subtitle: "Manage notifications",
                            trailing: "5 new"
                        )
                    }
                }
            }
            .padding()
        }
        .background(KS.Colors.background)
        .navigationTitle("Cards")
    }
}

#Preview {
    NavigationStack {
        CardShowcase()
    }
}
