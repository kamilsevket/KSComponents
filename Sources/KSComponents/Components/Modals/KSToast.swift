import SwiftUI

/// A toast notification component with multiple type variants
public struct KSToast: View {
    let message: String
    let type: ToastType
    let action: (() -> Void)?
    let actionTitle: String?

    public enum ToastType {
        case info
        case success
        case warning
        case error

        var icon: String {
            switch self {
            case .info: return "info.circle.fill"
            case .success: return "checkmark.circle.fill"
            case .warning: return "exclamationmark.triangle.fill"
            case .error: return "xmark.circle.fill"
            }
        }

        var color: Color {
            switch self {
            case .info: return KS.Colors.info
            case .success: return KS.Colors.success
            case .warning: return KS.Colors.warning
            case .error: return KS.Colors.error
            }
        }
    }

    public init(
        message: String,
        type: ToastType = .info,
        action: (() -> Void)? = nil,
        actionTitle: String? = nil
    ) {
        self.message = message
        self.type = type
        self.action = action
        self.actionTitle = actionTitle
    }

    public var body: some View {
        HStack(spacing: KS.Spacing.md) {
            Image(systemName: type.icon)
                .foregroundStyle(type.color)

            Text(message)
                .font(KS.Typography.bodyMedium)
                .foregroundStyle(KS.Colors.textPrimary)

            Spacer()

            if let action, let title = actionTitle {
                Button(action: action) {
                    Text(title)
                        .font(KS.Typography.labelMedium)
                        .foregroundStyle(type.color)
                }
            }
        }
        .padding(KS.Spacing.md)
        .background(KS.Colors.surface)
        .clipShape(RoundedRectangle(cornerRadius: KS.Radius.md))
        .ksShadow(KS.Shadows.lg)
        .padding(.horizontal, KS.Spacing.md)
    }
}

// MARK: - Toast View Modifier

public struct ToastModifier: ViewModifier {
    @Binding var isPresented: Bool
    let toast: KSToast
    let duration: TimeInterval

    public func body(content: Content) -> some View {
        ZStack {
            content

            VStack {
                if isPresented {
                    toast
                        .transition(.move(edge: .top).combined(with: .opacity))
                        .onAppear {
                            DispatchQueue.main.asyncAfter(deadline: .now() + duration) {
                                withAnimation {
                                    isPresented = false
                                }
                            }
                        }
                }
                Spacer()
            }
            .animation(.spring(), value: isPresented)
        }
    }
}

public extension View {
    /// Presents a toast notification at the top of the view
    func ksToast(
        isPresented: Binding<Bool>,
        message: String,
        type: KSToast.ToastType = .info,
        duration: TimeInterval = 3
    ) -> some View {
        modifier(ToastModifier(
            isPresented: isPresented,
            toast: KSToast(message: message, type: type),
            duration: duration
        ))
    }

    /// Presents a toast notification with action button at the top of the view
    func ksToast(
        isPresented: Binding<Bool>,
        message: String,
        type: KSToast.ToastType = .info,
        duration: TimeInterval = 3,
        actionTitle: String,
        action: @escaping () -> Void
    ) -> some View {
        modifier(ToastModifier(
            isPresented: isPresented,
            toast: KSToast(message: message, type: type, action: action, actionTitle: actionTitle),
            duration: duration
        ))
    }
}

// MARK: - Previews

#Preview("Toast Types") {
    VStack(spacing: 16) {
        KSToast(message: "This is an info message", type: .info)
        KSToast(message: "Operation successful!", type: .success)
        KSToast(message: "Please check your input", type: .warning)
        KSToast(message: "Something went wrong", type: .error)
    }
    .padding(.vertical)
    .background(Color.gray.opacity(0.2))
}

#Preview("Toast with Action") {
    KSToast(
        message: "Item deleted",
        type: .info,
        action: {},
        actionTitle: "Undo"
    )
    .padding(.vertical)
    .background(Color.gray.opacity(0.2))
}
