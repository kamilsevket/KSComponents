import SwiftUI
import KSComponents

struct BadgeShowcase: View {
    @State private var selectedChips: Set<String> = ["Swift"]
    @State private var chipSelected = false

    var body: some View {
        ScrollView {
            VStack(spacing: KS.Spacing.xl) {
                ShowcaseSection("Notification Badge", description: "Count badges for notifications") {
                    HStack(spacing: KS.Spacing.xl) {
                        VStack {
                            Image(systemName: "bell.fill")
                                .font(.title2)
                                .ksBadge(3)
                            Text("3").font(KS.Typography.caption)
                        }

                        VStack {
                            Image(systemName: "envelope.fill")
                                .font(.title2)
                                .ksBadge(25)
                            Text("25").font(KS.Typography.caption)
                        }

                        VStack {
                            Image(systemName: "message.fill")
                                .font(.title2)
                                .ksBadge(150)
                            Text("99+").font(KS.Typography.caption)
                        }
                    }
                }

                ShowcaseSection("Badge Sizes", description: "Small and medium badge sizes") {
                    HStack(spacing: KS.Spacing.xl) {
                        KSBadge(count: 5, size: .small)
                        KSBadge(count: 5, size: .medium)
                    }
                }

                ShowcaseSection("Status Dots", description: "Status indicator dots") {
                    HStack(spacing: KS.Spacing.xl) {
                        VStack {
                            KSDot(color: KS.Colors.success)
                            Text("Online").font(KS.Typography.caption)
                        }

                        VStack {
                            KSDot(color: KS.Colors.warning)
                            Text("Away").font(KS.Typography.caption)
                        }

                        VStack {
                            KSDot(color: KS.Colors.error)
                            Text("Busy").font(KS.Typography.caption)
                        }

                        VStack {
                            KSDot(color: KS.Colors.success, isPulsing: true)
                            Text("Pulsing").font(KS.Typography.caption)
                        }
                    }
                }

                ShowcaseSection("Tags", description: "Labeled tags with optional icons") {
                    VStack(spacing: KS.Spacing.md) {
                        HStack(spacing: KS.Spacing.sm) {
                            KSTag("Swift", icon: "swift", color: .orange)
                            KSTag("iOS", color: KS.Colors.primary)
                            KSTag("SwiftUI", color: .purple)
                        }

                        HStack(spacing: KS.Spacing.sm) {
                            KSTag("Removable", isRemovable: true, onRemove: { })
                            KSTag("Another", color: KS.Colors.success, isRemovable: true, onRemove: { })
                        }
                    }
                }

                ShowcaseSection("Chips", description: "Selectable filter chips") {
                    VStack(spacing: KS.Spacing.md) {
                        KSChip("Single Chip", isSelected: $chipSelected)

                        Text("Selected: \(chipSelected ? "Yes" : "No")")
                            .font(KS.Typography.bodySmall)
                            .foregroundStyle(KS.Colors.textSecondary)
                    }
                }

                ShowcaseSection("Chip Group", description: "Multi-select chip group") {
                    VStack(spacing: KS.Spacing.md) {
                        KSChipGroup(
                            chips: ["Swift", "Kotlin", "JavaScript", "Python", "Go", "Rust"],
                            selectedChips: $selectedChips
                        )

                        Text("Selected: \(selectedChips.sorted().joined(separator: ", "))")
                            .font(KS.Typography.bodySmall)
                            .foregroundStyle(KS.Colors.textSecondary)
                    }
                }

                ShowcaseSection("Status Badge", description: "Labeled status indicators") {
                    HStack(spacing: KS.Spacing.md) {
                        KSStatusBadge(.active)
                        KSStatusBadge(.pending)
                        KSStatusBadge(.inactive)
                        KSStatusBadge(.error)
                    }
                }
            }
            .padding()
        }
        .background(KS.Colors.background)
        .navigationTitle("Badges & Tags")
    }
}

#Preview {
    NavigationStack {
        BadgeShowcase()
    }
}
