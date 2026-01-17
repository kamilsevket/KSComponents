import SwiftUI

// MARK: - Fade In Modifier

/// View modifier that fades in content on appear
public struct FadeInModifier: ViewModifier {
    @State private var opacity: Double = 0
    let delay: Double

    public init(delay: Double = 0) {
        self.delay = delay
    }

    public func body(content: Content) -> some View {
        content
            .opacity(opacity)
            .onAppear {
                withAnimation(.easeOut(duration: 0.3).delay(delay)) {
                    opacity = 1
                }
            }
    }
}

// MARK: - Slide In Modifier

/// View modifier that slides in content from a specified edge on appear
public struct SlideInModifier: ViewModifier {
    @State private var offset: CGFloat = 20
    @State private var opacity: Double = 0
    let edge: Edge
    let delay: Double

    public init(edge: Edge = .bottom, delay: Double = 0) {
        self.edge = edge
        self.delay = delay
    }

    public func body(content: Content) -> some View {
        content
            .offset(
                x: edge == .leading ? -offset : (edge == .trailing ? offset : 0),
                y: edge == .top ? -offset : (edge == .bottom ? offset : 0)
            )
            .opacity(opacity)
            .onAppear {
                withAnimation(KS.Animation.smooth.delay(delay)) {
                    offset = 0
                    opacity = 1
                }
            }
    }
}

// MARK: - View Extensions

extension View {
    /// Applies a fade-in animation on appear
    /// - Parameter delay: Delay before the animation starts
    /// - Returns: Modified view with fade-in animation
    public func ksFadeIn(delay: Double = 0) -> some View {
        modifier(FadeInModifier(delay: delay))
    }

    /// Applies a slide-in animation from a specified edge on appear
    /// - Parameters:
    ///   - edge: The edge to slide in from
    ///   - delay: Delay before the animation starts
    /// - Returns: Modified view with slide-in animation
    public func ksSlideIn(from edge: Edge = .bottom, delay: Double = 0) -> some View {
        modifier(SlideInModifier(edge: edge, delay: delay))
    }
}
