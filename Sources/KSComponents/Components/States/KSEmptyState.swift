import SwiftUI

// MARK: - KSEmptyState

public struct KSEmptyState: View {
    public let icon: String
    public let title: String
    public let message: String?
    public let actionTitle: String?
    public let action: (() -> Void)?

    public init(
        icon: String,
        title: String,
        message: String? = nil,
        actionTitle: String? = nil,
        action: (() -> Void)? = nil
    ) {
        self.icon = icon
        self.title = title
        self.message = message
        self.actionTitle = actionTitle
        self.action = action
    }

    public var body: some View {
        VStack(spacing: KS.Spacing.lg) {
            Image(systemName: icon)
                .font(.system(size: 64))
                .foregroundStyle(KS.Colors.textTertiary)

            VStack(spacing: KS.Spacing.xs) {
                Text(title)
                    .font(KS.Typography.headlineSmall)
                    .foregroundStyle(KS.Colors.textPrimary)
                    .multilineTextAlignment(.center)

                if let message {
                    Text(message)
                        .font(KS.Typography.bodyMedium)
                        .foregroundStyle(KS.Colors.textSecondary)
                        .multilineTextAlignment(.center)
                }
            }

            if let actionTitle, let action {
                KSButton(actionTitle, style: .primary, action: action)
            }
        }
        .padding(KS.Spacing.xl)
    }
}

// MARK: - Preset Empty States

public extension KSEmptyState {
    static func noResults(
        searchTerm: String? = nil,
        action: (() -> Void)? = nil
    ) -> KSEmptyState {
        KSEmptyState(
            icon: "magnifyingglass",
            title: "No Results Found",
            message: searchTerm != nil ? "No results for \"\(searchTerm!)\"" : "Try adjusting your search or filters",
            actionTitle: action != nil ? "Clear Filters" : nil,
            action: action
        )
    }

    static func noData(
        title: String = "No Data Yet",
        message: String = "Start adding items to see them here",
        actionTitle: String? = "Add New",
        action: (() -> Void)? = nil
    ) -> KSEmptyState {
        KSEmptyState(
            icon: "tray",
            title: title,
            message: message,
            actionTitle: actionTitle,
            action: action
        )
    }

    static func noConnection(
        action: (() -> Void)? = nil
    ) -> KSEmptyState {
        KSEmptyState(
            icon: "wifi.slash",
            title: "No Connection",
            message: "Please check your internet connection and try again",
            actionTitle: "Retry",
            action: action
        )
    }

    static func noNotifications() -> KSEmptyState {
        KSEmptyState(
            icon: "bell.slash",
            title: "No Notifications",
            message: "You're all caught up!"
        )
    }

    static func noMessages() -> KSEmptyState {
        KSEmptyState(
            icon: "bubble.left.and.bubble.right",
            title: "No Messages",
            message: "Start a conversation to see messages here"
        )
    }
}

// MARK: - Previews

#Preview("Empty State") {
    KSEmptyState(
        icon: "folder",
        title: "No Files",
        message: "Your folder is empty",
        actionTitle: "Add Files"
    ) {
        print("Add Files tapped")
    }
}

#Preview("No Results") {
    KSEmptyState.noResults(searchTerm: "Swift")
}

#Preview("No Data") {
    KSEmptyState.noData()
}

#Preview("No Connection") {
    KSEmptyState.noConnection {
        print("Retry tapped")
    }
}

#Preview("No Notifications") {
    KSEmptyState.noNotifications()
}

#Preview("No Messages") {
    KSEmptyState.noMessages()
}
