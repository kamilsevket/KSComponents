import SwiftUI

// MARK: - KSSwipeableRow

public struct KSSwipeableRow<Content: View>: View {
    let content: Content
    let leadingActions: [SwipeAction]
    let trailingActions: [SwipeAction]

    @State private var offset: CGFloat = 0
    @GestureState private var isDragging = false

    public struct SwipeAction: Identifiable {
        public let id = UUID()
        let icon: String
        let color: Color
        let action: () -> Void

        public init(icon: String, color: Color, action: @escaping () -> Void) {
            self.icon = icon
            self.color = color
            self.action = action
        }
    }

    public init(
        leadingActions: [SwipeAction] = [],
        trailingActions: [SwipeAction] = [],
        @ViewBuilder content: () -> Content
    ) {
        self.leadingActions = leadingActions
        self.trailingActions = trailingActions
        self.content = content()
    }

    private let actionWidth: CGFloat = 70
    private let swipeThreshold: CGFloat = 100

    public var body: some View {
        ZStack {
            // Leading Actions Background
            HStack(spacing: 0) {
                ForEach(leadingActions) { action in
                    Button {
                        action.action()
                        withAnimation(.spring(response: 0.3, dampingFraction: 0.7)) {
                            offset = 0
                        }
                    } label: {
                        Image(systemName: action.icon)
                            .font(.title3)
                            .foregroundStyle(.white)
                            .frame(width: actionWidth)
                            .frame(maxHeight: .infinity)
                            .background(action.color)
                    }
                }
                Spacer()
            }

            // Trailing Actions Background
            HStack(spacing: 0) {
                Spacer()
                ForEach(trailingActions) { action in
                    Button {
                        action.action()
                        withAnimation(.spring(response: 0.3, dampingFraction: 0.7)) {
                            offset = 0
                        }
                    } label: {
                        Image(systemName: action.icon)
                            .font(.title3)
                            .foregroundStyle(.white)
                            .frame(width: actionWidth)
                            .frame(maxHeight: .infinity)
                            .background(action.color)
                    }
                }
            }

            // Content
            content
                .background(KS.Colors.surface)
                .offset(x: offset)
                .gesture(
                    DragGesture()
                        .updating($isDragging) { _, state, _ in
                            state = true
                        }
                        .onChanged { value in
                            let translation = value.translation.width

                            // Limit dragging based on available actions
                            if translation > 0 && leadingActions.isEmpty {
                                offset = 0
                            } else if translation < 0 && trailingActions.isEmpty {
                                offset = 0
                            } else {
                                // Add resistance at the edges
                                let maxLeading = CGFloat(leadingActions.count) * actionWidth
                                let maxTrailing = CGFloat(trailingActions.count) * actionWidth

                                if translation > maxLeading {
                                    offset = maxLeading + (translation - maxLeading) * 0.3
                                } else if translation < -maxTrailing {
                                    offset = -maxTrailing + (translation + maxTrailing) * 0.3
                                } else {
                                    offset = translation
                                }
                            }
                        }
                        .onEnded { value in
                            withAnimation(.spring(response: 0.3, dampingFraction: 0.7)) {
                                if value.translation.width > swipeThreshold && !leadingActions.isEmpty {
                                    offset = CGFloat(leadingActions.count) * actionWidth
                                } else if value.translation.width < -swipeThreshold && !trailingActions.isEmpty {
                                    offset = -CGFloat(trailingActions.count) * actionWidth
                                } else {
                                    offset = 0
                                }
                            }
                        }
                )
        }
        .clipShape(RoundedRectangle(cornerRadius: KS.Radius.md))
    }

    /// Resets the swipe offset to closed position
    public func reset() {
        withAnimation(.spring(response: 0.3, dampingFraction: 0.7)) {
            offset = 0
        }
    }
}

// MARK: - Preview

#if DEBUG
struct KSSwipeableRow_Previews: PreviewProvider {
    static var previews: some View {
        VStack(spacing: KS.Spacing.md) {
            KSSwipeableRow(
                leadingActions: [
                    .init(icon: "star.fill", color: KS.Colors.warning) {
                        print("Starred")
                    }
                ],
                trailingActions: [
                    .init(icon: "trash.fill", color: KS.Colors.error) {
                        print("Deleted")
                    },
                    .init(icon: "archivebox.fill", color: KS.Colors.secondary) {
                        print("Archived")
                    }
                ]
            ) {
                KSRow(
                    icon: "envelope.fill",
                    title: "Message",
                    subtitle: "Swipe to reveal actions"
                )
                .padding(.horizontal, KS.Spacing.md)
            }

            KSSwipeableRow(
                trailingActions: [
                    .init(icon: "trash.fill", color: KS.Colors.error) {
                        print("Deleted")
                    }
                ]
            ) {
                KSRow(
                    icon: "doc.fill",
                    title: "Document",
                    subtitle: "Swipe left to delete"
                )
                .padding(.horizontal, KS.Spacing.md)
            }
        }
        .padding()
        .background(KS.Colors.background)
    }
}
#endif
