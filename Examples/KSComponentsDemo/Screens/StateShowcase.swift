import SwiftUI
import KSComponents

struct StateShowcase: View {
    @State private var showOfflineBar = true

    var body: some View {
        ScrollView {
            VStack(spacing: KS.Spacing.xl) {
                ShowcaseSection("Empty State", description: "Custom empty state view") {
                    KSEmptyState(
                        icon: "folder",
                        title: "No Files",
                        message: "Your folder is empty",
                        actionTitle: "Add Files"
                    ) {
                        // Action
                    }
                }

                ShowcaseSection("Preset: No Results", description: "Search with no results") {
                    KSEmptyState.noResults(searchTerm: "Swift")
                }

                ShowcaseSection("Preset: No Data", description: "Empty list state") {
                    KSEmptyState.noData()
                }

                ShowcaseSection("Preset: No Connection", description: "Offline state") {
                    KSEmptyState.noConnection {
                        // Retry action
                    }
                }

                ShowcaseSection("Preset: No Notifications", description: "All caught up state") {
                    KSEmptyState.noNotifications()
                }

                ShowcaseSection("Preset: No Messages", description: "Empty inbox state") {
                    KSEmptyState.noMessages()
                }

                ShowcaseSection("Error State", description: "Error with retry action") {
                    KSErrorState(
                        title: "Something went wrong",
                        message: "We couldn't load your data. Please try again.",
                        retryAction: {
                            // Retry
                        }
                    )
                }

                ShowcaseSection("Maintenance State", description: "Scheduled maintenance") {
                    KSMaintenanceState(
                        title: "Under Maintenance",
                        message: "We're making some improvements. Please check back soon.",
                        estimatedTime: "2 hours"
                    )
                }

                ShowcaseSection("Offline Bar", description: "Inline offline indicator") {
                    VStack(spacing: KS.Spacing.md) {
                        KSButton(showOfflineBar ? "Hide Offline Bar" : "Show Offline Bar", style: .secondary) {
                            withAnimation {
                                showOfflineBar.toggle()
                            }
                        }

                        if showOfflineBar {
                            KSOfflineBar()
                        }
                    }
                }
            }
            .padding()
        }
        .background(KS.Colors.background)
        .navigationTitle("States")
    }
}

#Preview {
    NavigationStack {
        StateShowcase()
    }
}
