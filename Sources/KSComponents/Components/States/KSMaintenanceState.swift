import SwiftUI

// MARK: - KSMaintenanceState

public struct KSMaintenanceState: View {
    public let title: String
    public let message: String
    public let estimatedTime: String?

    public init(
        title: String = "Under Maintenance",
        message: String = "We're making some improvements. Please check back soon.",
        estimatedTime: String? = nil
    ) {
        self.title = title
        self.message = message
        self.estimatedTime = estimatedTime
    }

    public var body: some View {
        VStack(spacing: KS.Spacing.lg) {
            Image(systemName: "wrench.and.screwdriver")
                .font(.system(size: 64))
                .foregroundStyle(KS.Colors.warning)

            VStack(spacing: KS.Spacing.xs) {
                Text(title)
                    .font(KS.Typography.headlineSmall)
                    .foregroundStyle(KS.Colors.textPrimary)

                Text(message)
                    .font(KS.Typography.bodyMedium)
                    .foregroundStyle(KS.Colors.textSecondary)
                    .multilineTextAlignment(.center)

                if let time = estimatedTime {
                    Text("Estimated time: \(time)")
                        .font(KS.Typography.caption)
                        .foregroundStyle(KS.Colors.textTertiary)
                        .padding(.top, KS.Spacing.xs)
                }
            }
        }
        .padding(KS.Spacing.xl)
    }
}

// MARK: - Preset Maintenance States

public extension KSMaintenanceState {
    static func scheduledMaintenance(
        estimatedTime: String? = nil
    ) -> KSMaintenanceState {
        KSMaintenanceState(
            title: "Scheduled Maintenance",
            message: "We're performing scheduled maintenance to improve our services.",
            estimatedTime: estimatedTime
        )
    }

    static func updating() -> KSMaintenanceState {
        KSMaintenanceState(
            title: "Updating",
            message: "We're updating the app with new features. Please wait a moment."
        )
    }

    static func comingSoon() -> KSMaintenanceState {
        KSMaintenanceState(
            title: "Coming Soon",
            message: "This feature is under development and will be available soon."
        )
    }
}

// MARK: - Previews

#Preview("Maintenance State") {
    KSMaintenanceState()
}

#Preview("Maintenance with Time") {
    KSMaintenanceState(
        title: "Under Maintenance",
        message: "We're making some improvements. Please check back soon.",
        estimatedTime: "30 minutes"
    )
}

#Preview("Scheduled Maintenance") {
    KSMaintenanceState.scheduledMaintenance(estimatedTime: "2 hours")
}

#Preview("Updating") {
    KSMaintenanceState.updating()
}

#Preview("Coming Soon") {
    KSMaintenanceState.comingSoon()
}
