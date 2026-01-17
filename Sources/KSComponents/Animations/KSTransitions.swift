import SwiftUI

// MARK: - Flip Modifier

/// View modifier for 3D flip effect
struct FlipModifier: ViewModifier {
    let angle: Double

    func body(content: Content) -> some View {
        content
            .rotation3DEffect(.degrees(angle), axis: (x: 0, y: 1, z: 0))
            .opacity(abs(angle) < 90 ? 1 : 0)
    }
}

// MARK: - Transition Presets

extension AnyTransition {
    /// Slide up transition with opacity
    public static var ksSlideUp: AnyTransition {
        .asymmetric(
            insertion: .move(edge: .bottom).combined(with: .opacity),
            removal: .move(edge: .bottom).combined(with: .opacity)
        )
    }

    /// Slide down transition with opacity
    public static var ksSlideDown: AnyTransition {
        .asymmetric(
            insertion: .move(edge: .top).combined(with: .opacity),
            removal: .move(edge: .top).combined(with: .opacity)
        )
    }

    /// Scale transition with opacity (scales from 0.8)
    public static var ksScale: AnyTransition {
        .asymmetric(
            insertion: .scale(scale: 0.8).combined(with: .opacity),
            removal: .scale(scale: 0.8).combined(with: .opacity)
        )
    }

    /// Scale fade transition (scales from 0.9 on insert, to 1.1 on removal)
    public static var ksScaleFade: AnyTransition {
        .asymmetric(
            insertion: .scale(scale: 0.9).combined(with: .opacity),
            removal: .scale(scale: 1.1).combined(with: .opacity)
        )
    }

    /// Simple fade transition
    public static var ksFade: AnyTransition {
        .opacity
    }

    /// 3D flip transition
    public static var ksFlip: AnyTransition {
        .asymmetric(
            insertion: .modifier(
                active: FlipModifier(angle: -90),
                identity: FlipModifier(angle: 0)
            ),
            removal: .modifier(
                active: FlipModifier(angle: 90),
                identity: FlipModifier(angle: 0)
            )
        )
    }
}
