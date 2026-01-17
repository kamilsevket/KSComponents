import SwiftUI

// MARK: - KSOfflineBar

public struct KSOfflineBar: View {
    public let isOffline: Bool
    public let retryAction: (() -> Void)?

    public init(
        isOffline: Bool,
        retryAction: (() -> Void)? = nil
    ) {
        self.isOffline = isOffline
        self.retryAction = retryAction
    }

    public var body: some View {
        if isOffline {
            Button(action: { retryAction?() }) {
                HStack(spacing: KS.Spacing.sm) {
                    Image(systemName: "wifi.slash")
                        .font(.caption)

                    Text("You're offline")
                        .font(KS.Typography.caption)

                    Spacer()

                    if retryAction != nil {
                        Text("Tap to retry")
                            .font(KS.Typography.caption)
                    }
                }
                .foregroundStyle(.white)
                .padding(.horizontal, KS.Spacing.md)
                .padding(.vertical, KS.Spacing.sm)
                .background(KS.Colors.error)
            }
            .buttonStyle(.plain)
            .transition(.move(edge: .top).combined(with: .opacity))
        }
    }
}

// MARK: - KSOfflineBar Modifier

public extension View {
    func offlineBar(isOffline: Bool, retryAction: (() -> Void)? = nil) -> some View {
        VStack(spacing: 0) {
            KSOfflineBar(isOffline: isOffline, retryAction: retryAction)
            self
        }
        .animation(.easeInOut(duration: 0.3), value: isOffline)
    }
}

// MARK: - Previews

#Preview("Offline Bar - Visible") {
    VStack {
        KSOfflineBar(isOffline: true, retryAction: { print("Retry") })
        Spacer()
    }
}

#Preview("Offline Bar - Hidden") {
    VStack {
        KSOfflineBar(isOffline: false)
        Spacer()
    }
}

#Preview("Offline Bar Modifier") {
    NavigationStack {
        List {
            ForEach(1..<10) { i in
                Text("Item \(i)")
            }
        }
        .navigationTitle("My List")
    }
    .offlineBar(isOffline: true, retryAction: { print("Retry") })
}
