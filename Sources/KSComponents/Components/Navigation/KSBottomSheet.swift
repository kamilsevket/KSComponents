import SwiftUI

public struct KSBottomSheet<Content: View>: View {
    @Binding var isPresented: Bool
    let detents: [Detent]
    let showHandle: Bool
    let content: Content

    @State private var currentDetent: Detent = .medium
    @State private var dragOffset: CGFloat = 0

    public enum Detent: Equatable {
        case small  // 25%
        case medium // 50%
        case large  // 90%

        public var heightRatio: CGFloat {
            switch self {
            case .small: 0.25
            case .medium: 0.5
            case .large: 0.9
            }
        }
    }

    public init(
        isPresented: Binding<Bool>,
        detents: [Detent] = [.medium, .large],
        showHandle: Bool = true,
        @ViewBuilder content: () -> Content
    ) {
        self._isPresented = isPresented
        self.detents = detents
        self.showHandle = showHandle
        self.content = content()
    }

    public var body: some View {
        GeometryReader { geometry in
            ZStack(alignment: .bottom) {
                // Backdrop
                if isPresented {
                    Color.black.opacity(0.3)
                        .ignoresSafeArea()
                        .onTapGesture {
                            withAnimation(.spring()) {
                                isPresented = false
                            }
                        }
                }

                // Sheet
                if isPresented {
                    VStack(spacing: 0) {
                        // Handle
                        if showHandle {
                            Capsule()
                                .fill(KS.Colors.textTertiary)
                                .frame(width: 36, height: 5)
                                .padding(.top, KS.Spacing.sm)
                                .padding(.bottom, KS.Spacing.md)
                        }

                        content
                    }
                    .frame(maxWidth: .infinity)
                    .frame(height: geometry.size.height * currentDetent.heightRatio + dragOffset)
                    .background(KS.Colors.surface)
                    .clipShape(
                        UnevenRoundedRectangle(
                            topLeadingRadius: KS.Radius.xl,
                            bottomLeadingRadius: 0,
                            bottomTrailingRadius: 0,
                            topTrailingRadius: KS.Radius.xl
                        )
                    )
                    .gesture(
                        DragGesture()
                            .onChanged { value in
                                dragOffset = -value.translation.height
                            }
                            .onEnded { value in
                                withAnimation(.spring()) {
                                    snapToDetent(geometry: geometry, velocity: value.velocity.height)
                                    dragOffset = 0
                                }
                            }
                    )
                    .transition(.move(edge: .bottom))
                }
            }
        }
        .animation(.spring(), value: isPresented)
    }

    private func snapToDetent(geometry: GeometryProxy, velocity: CGFloat) {
        let currentHeight = geometry.size.height * currentDetent.heightRatio + dragOffset

        // Find closest detent
        var closestDetent = currentDetent
        var minDistance: CGFloat = .infinity

        for detent in detents {
            let targetHeight = geometry.size.height * detent.heightRatio
            let distance = abs(currentHeight - targetHeight)
            if distance < minDistance {
                minDistance = distance
                closestDetent = detent
            }
        }

        // Dismiss if dragged down fast
        if velocity > 1000 {
            isPresented = false
        } else {
            currentDetent = closestDetent
        }
    }
}

#Preview {
    struct PreviewWrapper: View {
        @State private var isPresented = true

        var body: some View {
            ZStack {
                VStack {
                    Button("Show Sheet") {
                        isPresented = true
                    }
                }

                KSBottomSheet(isPresented: $isPresented, detents: [.small, .medium, .large]) {
                    VStack(alignment: .leading, spacing: KS.Spacing.md) {
                        Text("Bottom Sheet")
                            .font(KS.Typography.headlineMedium)
                        Text("Drag to resize or tap outside to dismiss.")
                            .font(KS.Typography.bodyMedium)
                            .foregroundStyle(KS.Colors.textSecondary)
                        Spacer()
                    }
                    .padding(KS.Spacing.md)
                }
            }
        }
    }

    return PreviewWrapper()
}
