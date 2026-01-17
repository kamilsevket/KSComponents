import SwiftUI

/// A confirmation dialog component styled as an action sheet
public struct KSConfirmationDialog: View {
    @Binding var isPresented: Bool
    let title: String
    let message: String?
    let actions: [DialogAction]
    let cancelTitle: String

    public struct DialogAction {
        let title: String
        let icon: String?
        let isDestructive: Bool
        let action: () -> Void

        public init(
            title: String,
            icon: String? = nil,
            isDestructive: Bool = false,
            action: @escaping () -> Void
        ) {
            self.title = title
            self.icon = icon
            self.isDestructive = isDestructive
            self.action = action
        }
    }

    public init(
        isPresented: Binding<Bool>,
        title: String,
        message: String? = nil,
        actions: [DialogAction],
        cancelTitle: String = "Cancel"
    ) {
        self._isPresented = isPresented
        self.title = title
        self.message = message
        self.actions = actions
        self.cancelTitle = cancelTitle
    }

    public var body: some View {
        ZStack(alignment: .bottom) {
            // Backdrop
            Color.black.opacity(0.4)
                .ignoresSafeArea()
                .onTapGesture {
                    withAnimation(.spring()) {
                        isPresented = false
                    }
                }

            // Dialog
            VStack(spacing: KS.Spacing.xs) {
                // Main Sheet
                VStack(spacing: 0) {
                    // Header
                    VStack(spacing: KS.Spacing.xxs) {
                        Text(title)
                            .font(KS.Typography.labelLarge)
                            .foregroundStyle(KS.Colors.textSecondary)

                        if let message {
                            Text(message)
                                .font(KS.Typography.caption)
                                .foregroundStyle(KS.Colors.textTertiary)
                        }
                    }
                    .padding(.vertical, KS.Spacing.md)

                    KSDivider()

                    // Actions
                    ForEach(actions.indices, id: \.self) { index in
                        Button {
                            actions[index].action()
                            withAnimation { isPresented = false }
                        } label: {
                            HStack {
                                if let icon = actions[index].icon {
                                    Image(systemName: icon)
                                }
                                Text(actions[index].title)
                            }
                            .font(KS.Typography.titleSmall)
                            .foregroundStyle(actions[index].isDestructive ? KS.Colors.error : KS.Colors.primary)
                            .frame(maxWidth: .infinity)
                            .padding(.vertical, KS.Spacing.md)
                        }

                        if index < actions.count - 1 {
                            KSDivider()
                        }
                    }
                }
                .background(KS.Colors.surface)
                .clipShape(RoundedRectangle(cornerRadius: KS.Radius.lg))

                // Cancel Button
                Button {
                    withAnimation { isPresented = false }
                } label: {
                    Text(cancelTitle)
                        .font(KS.Typography.titleSmall.weight(.semibold))
                        .foregroundStyle(KS.Colors.primary)
                        .frame(maxWidth: .infinity)
                        .padding(.vertical, KS.Spacing.md)
                        .background(KS.Colors.surface)
                        .clipShape(RoundedRectangle(cornerRadius: KS.Radius.lg))
                }
            }
            .padding(.horizontal, KS.Spacing.xs)
            .padding(.bottom, KS.Spacing.lg)
            .transition(.move(edge: .bottom).combined(with: .opacity))
        }
        .opacity(isPresented ? 1 : 0)
        .animation(.spring(response: 0.3, dampingFraction: 0.8), value: isPresented)
    }
}

// MARK: - View Modifier for presenting KSConfirmationDialog

public struct KSConfirmationDialogModifier: ViewModifier {
    @Binding var isPresented: Bool
    let title: String
    let message: String?
    let actions: [KSConfirmationDialog.DialogAction]
    let cancelTitle: String

    public func body(content: Content) -> some View {
        ZStack {
            content

            if isPresented {
                KSConfirmationDialog(
                    isPresented: $isPresented,
                    title: title,
                    message: message,
                    actions: actions,
                    cancelTitle: cancelTitle
                )
            }
        }
    }
}

public extension View {
    func ksConfirmationDialog(
        isPresented: Binding<Bool>,
        title: String,
        message: String? = nil,
        actions: [KSConfirmationDialog.DialogAction],
        cancelTitle: String = "Cancel"
    ) -> some View {
        modifier(KSConfirmationDialogModifier(
            isPresented: isPresented,
            title: title,
            message: message,
            actions: actions,
            cancelTitle: cancelTitle
        ))
    }
}

// MARK: - Previews

#Preview("Confirmation Dialog") {
    ZStack {
        Color.gray.opacity(0.3)
            .ignoresSafeArea()

        KSConfirmationDialog(
            isPresented: .constant(true),
            title: "Choose Action",
            message: "What would you like to do with this item?",
            actions: [
                .init(title: "Share", icon: "square.and.arrow.up", action: {}),
                .init(title: "Edit", icon: "pencil", action: {}),
                .init(title: "Delete", icon: "trash", isDestructive: true, action: {})
            ]
        )
    }
}

#Preview("Simple Dialog") {
    ZStack {
        Color.gray.opacity(0.3)
            .ignoresSafeArea()

        KSConfirmationDialog(
            isPresented: .constant(true),
            title: "Sort By",
            actions: [
                .init(title: "Date", action: {}),
                .init(title: "Name", action: {}),
                .init(title: "Size", action: {})
            ]
        )
    }
}
