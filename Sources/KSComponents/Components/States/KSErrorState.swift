import SwiftUI

// MARK: - KSErrorState

public struct KSErrorState: View {
    public let icon: String
    public let title: String
    public let message: String?
    public let errorCode: String?
    public let retryAction: (() -> Void)?
    public let helpAction: (() -> Void)?

    public init(
        icon: String = "exclamationmark.triangle",
        title: String = "Something went wrong",
        message: String? = nil,
        errorCode: String? = nil,
        retryAction: (() -> Void)? = nil,
        helpAction: (() -> Void)? = nil
    ) {
        self.icon = icon
        self.title = title
        self.message = message
        self.errorCode = errorCode
        self.retryAction = retryAction
        self.helpAction = helpAction
    }

    public var body: some View {
        VStack(spacing: KS.Spacing.lg) {
            Image(systemName: icon)
                .font(.system(size: 64))
                .foregroundStyle(KS.Colors.error)

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

                if let errorCode {
                    Text("Error: \(errorCode)")
                        .font(KS.Typography.caption)
                        .foregroundStyle(KS.Colors.textTertiary)
                        .padding(.top, KS.Spacing.xxs)
                }
            }

            VStack(spacing: KS.Spacing.sm) {
                if let retryAction {
                    KSButton("Try Again", style: .primary, icon: "arrow.clockwise", action: retryAction)
                }

                if let helpAction {
                    KSButton("Get Help", style: .ghost, action: helpAction)
                }
            }
        }
        .padding(KS.Spacing.xl)
    }
}

// MARK: - Preset Error States

public extension KSErrorState {
    static func networkError(
        retryAction: (() -> Void)? = nil,
        helpAction: (() -> Void)? = nil
    ) -> KSErrorState {
        KSErrorState(
            icon: "wifi.exclamationmark",
            title: "Network Error",
            message: "Unable to connect to the server. Please check your connection and try again.",
            retryAction: retryAction,
            helpAction: helpAction
        )
    }

    static func serverError(
        errorCode: String? = nil,
        retryAction: (() -> Void)? = nil,
        helpAction: (() -> Void)? = nil
    ) -> KSErrorState {
        KSErrorState(
            icon: "server.rack",
            title: "Server Error",
            message: "Our servers are having trouble. Please try again later.",
            errorCode: errorCode,
            retryAction: retryAction,
            helpAction: helpAction
        )
    }

    static func permissionDenied(
        helpAction: (() -> Void)? = nil
    ) -> KSErrorState {
        KSErrorState(
            icon: "lock.shield",
            title: "Access Denied",
            message: "You don't have permission to access this content.",
            helpAction: helpAction
        )
    }

    static func notFound() -> KSErrorState {
        KSErrorState(
            icon: "questionmark.folder",
            title: "Not Found",
            message: "The content you're looking for doesn't exist or has been removed."
        )
    }
}

// MARK: - Previews

#Preview("Error State") {
    KSErrorState(
        title: "Something went wrong",
        message: "An unexpected error occurred. Please try again.",
        errorCode: "ERR_500",
        retryAction: {
            print("Retry tapped")
        },
        helpAction: {
            print("Help tapped")
        }
    )
}

#Preview("Network Error") {
    KSErrorState.networkError(
        retryAction: { print("Retry") },
        helpAction: { print("Help") }
    )
}

#Preview("Server Error") {
    KSErrorState.serverError(
        errorCode: "500",
        retryAction: { print("Retry") }
    )
}

#Preview("Permission Denied") {
    KSErrorState.permissionDenied()
}

#Preview("Not Found") {
    KSErrorState.notFound()
}
