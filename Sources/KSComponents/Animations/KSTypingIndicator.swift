import SwiftUI

/// A typing indicator view that displays animated bouncing dots
public struct KSTypingIndicator: View {
    @State private var animationPhase = 0

    public init() {}

    public var body: some View {
        HStack(spacing: 4) {
            ForEach(0..<3, id: \.self) { index in
                Circle()
                    .fill(KS.Colors.textTertiary)
                    .frame(width: 8, height: 8)
                    .offset(y: animationPhase == index ? -4 : 0)
            }
        }
        .onAppear {
            startAnimation()
        }
    }

    private func startAnimation() {
        Timer.scheduledTimer(withTimeInterval: 0.3, repeats: true) { _ in
            withAnimation(.easeInOut(duration: 0.3)) {
                animationPhase = (animationPhase + 1) % 3
            }
        }
    }
}

#if DEBUG
struct KSTypingIndicator_Previews: PreviewProvider {
    static var previews: some View {
        KSTypingIndicator()
            .padding()
            .previewLayout(.sizeThatFits)
    }
}
#endif
