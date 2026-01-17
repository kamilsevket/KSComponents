import SwiftUI

// MARK: - KSSpinner

public struct KSSpinner: View {
    public enum Size {
        case small
        case medium
        case large

        var dimension: CGFloat {
            switch self {
            case .small: 20
            case .medium: 32
            case .large: 48
            }
        }

        var scale: CGFloat {
            switch self {
            case .small: 0.8
            case .medium: 1.0
            case .large: 1.5
            }
        }
    }

    let size: Size
    let color: Color

    public init(size: Size = .medium, color: Color = KS.Colors.primary) {
        self.size = size
        self.color = color
    }

    public var body: some View {
        ProgressView()
            .progressViewStyle(CircularProgressViewStyle(tint: color))
            .scaleEffect(size.scale)
            .frame(width: size.dimension, height: size.dimension)
    }
}

// MARK: - KSPulsingDots

public struct KSPulsingDots: View {
    @State private var isAnimating = false
    let color: Color

    public init(color: Color = KS.Colors.primary) {
        self.color = color
    }

    public var body: some View {
        HStack(spacing: KS.Spacing.xs) {
            ForEach(0..<3, id: \.self) { index in
                Circle()
                    .fill(color)
                    .frame(width: 8, height: 8)
                    .scaleEffect(isAnimating ? 1.0 : 0.5)
                    .animation(
                        .easeInOut(duration: 0.6)
                            .repeatForever()
                            .delay(Double(index) * 0.2),
                        value: isAnimating
                    )
            }
        }
        .onAppear {
            isAnimating = true
        }
    }
}

// MARK: - KSSkeleton

public struct KSSkeleton: View {
    let width: CGFloat?
    let height: CGFloat
    let cornerRadius: CGFloat

    @State private var isAnimating = false

    public init(
        width: CGFloat? = nil,
        height: CGFloat = 20,
        cornerRadius: CGFloat = KS.Radius.sm
    ) {
        self.width = width
        self.height = height
        self.cornerRadius = cornerRadius
    }

    public var body: some View {
        RoundedRectangle(cornerRadius: cornerRadius)
            .fill(KS.Colors.border)
            .frame(width: width, height: height)
            .overlay(
                GeometryReader { geometry in
                    shimmerOverlay(width: geometry.size.width)
                }
                .mask(RoundedRectangle(cornerRadius: cornerRadius))
            )
    }

    private func shimmerOverlay(width: CGFloat) -> some View {
        LinearGradient(
            colors: [
                .clear,
                KS.Colors.surface.opacity(0.5),
                .clear
            ],
            startPoint: .leading,
            endPoint: .trailing
        )
        .frame(width: width * 0.6)
        .offset(x: isAnimating ? width : -width)
        .animation(
            .linear(duration: 1.5)
                .repeatForever(autoreverses: false),
            value: isAnimating
        )
        .onAppear {
            isAnimating = true
        }
    }
}

// MARK: - KSSkeletonCard

public struct KSSkeletonCard: View {
    let hasImage: Bool
    let lines: Int

    public init(hasImage: Bool = true, lines: Int = 3) {
        self.hasImage = hasImage
        self.lines = lines
    }

    public var body: some View {
        VStack(alignment: .leading, spacing: KS.Spacing.md) {
            if hasImage {
                KSSkeleton(height: 180, cornerRadius: KS.Radius.md)
            }

            VStack(alignment: .leading, spacing: KS.Spacing.sm) {
                KSSkeleton(width: 200, height: 20)

                ForEach(0..<lines, id: \.self) { index in
                    KSSkeleton(
                        width: index == lines - 1 ? 150 : nil,
                        height: 14
                    )
                }
            }
        }
        .padding(KS.Spacing.md)
        .background(KS.Colors.surface)
        .clipShape(RoundedRectangle(cornerRadius: KS.Radius.lg))
    }
}

// MARK: - KSProgressBar

public struct KSProgressBar: View {
    let progress: Double
    let height: CGFloat
    let showLabel: Bool
    let color: Color

    public init(
        progress: Double,
        height: CGFloat = 8,
        showLabel: Bool = false,
        color: Color = KS.Colors.primary
    ) {
        self.progress = min(max(progress, 0), 1)
        self.height = height
        self.showLabel = showLabel
        self.color = color
    }

    public var body: some View {
        VStack(alignment: .trailing, spacing: KS.Spacing.xxs) {
            GeometryReader { geometry in
                ZStack(alignment: .leading) {
                    // Background
                    RoundedRectangle(cornerRadius: height / 2)
                        .fill(KS.Colors.border)

                    // Progress
                    RoundedRectangle(cornerRadius: height / 2)
                        .fill(color)
                        .frame(width: geometry.size.width * progress)
                        .animation(.spring(), value: progress)
                }
            }
            .frame(height: height)

            if showLabel {
                Text("\(Int(progress * 100))%")
                    .font(KS.Typography.caption)
                    .foregroundStyle(KS.Colors.textSecondary)
            }
        }
    }
}

// MARK: - KSCircularProgress

public struct KSCircularProgress: View {
    let progress: Double
    let lineWidth: CGFloat
    let size: CGFloat
    let showLabel: Bool
    let color: Color

    public init(
        progress: Double,
        size: CGFloat = 60,
        lineWidth: CGFloat = 6,
        showLabel: Bool = true,
        color: Color = KS.Colors.primary
    ) {
        self.progress = min(max(progress, 0), 1)
        self.size = size
        self.lineWidth = lineWidth
        self.showLabel = showLabel
        self.color = color
    }

    public var body: some View {
        ZStack {
            // Background Circle
            Circle()
                .stroke(KS.Colors.border, lineWidth: lineWidth)

            // Progress Circle
            Circle()
                .trim(from: 0, to: progress)
                .stroke(color, style: StrokeStyle(lineWidth: lineWidth, lineCap: .round))
                .rotationEffect(.degrees(-90))
                .animation(.spring(), value: progress)

            // Label
            if showLabel {
                Text("\(Int(progress * 100))%")
                    .font(KS.Typography.titleSmall)
                    .foregroundStyle(KS.Colors.textPrimary)
            }
        }
        .frame(width: size, height: size)
    }
}

// MARK: - KSLoadingOverlay

public struct KSLoadingOverlay: View {
    let message: String?

    public init(message: String? = nil) {
        self.message = message
    }

    public var body: some View {
        ZStack {
            Color.black.opacity(0.3)
                .ignoresSafeArea()

            VStack(spacing: KS.Spacing.md) {
                KSSpinner(size: .large)

                if let message {
                    Text(message)
                        .font(KS.Typography.bodyMedium)
                        .foregroundStyle(KS.Colors.textPrimary)
                }
            }
            .padding(KS.Spacing.xl)
            .background(KS.Colors.surface)
            .clipShape(RoundedRectangle(cornerRadius: KS.Radius.lg))
            .ksShadow(KS.Shadows.lg)
        }
    }
}

// MARK: - View Modifier for Loading Overlay

public extension View {
    func ksLoadingOverlay(isLoading: Bool, message: String? = nil) -> some View {
        ZStack {
            self
            if isLoading {
                KSLoadingOverlay(message: message)
            }
        }
    }
}

// MARK: - Previews

#Preview("Spinners") {
    VStack(spacing: 24) {
        HStack(spacing: 32) {
            VStack {
                KSSpinner(size: .small)
                Text("Small").font(.caption)
            }
            VStack {
                KSSpinner(size: .medium)
                Text("Medium").font(.caption)
            }
            VStack {
                KSSpinner(size: .large)
                Text("Large").font(.caption)
            }
        }

        HStack(spacing: 32) {
            KSSpinner(size: .medium, color: KS.Colors.success)
            KSSpinner(size: .medium, color: KS.Colors.warning)
            KSSpinner(size: .medium, color: KS.Colors.error)
        }
    }
    .padding()
}

#Preview("Pulsing Dots") {
    VStack(spacing: 24) {
        KSPulsingDots()
        KSPulsingDots(color: KS.Colors.secondary)
        KSPulsingDots(color: KS.Colors.success)
    }
    .padding()
}

#Preview("Skeleton") {
    VStack(alignment: .leading, spacing: 16) {
        KSSkeleton(width: 200, height: 24)
        KSSkeleton(height: 16)
        KSSkeleton(width: 150, height: 16)
        KSSkeleton(height: 100, cornerRadius: KS.Radius.lg)
    }
    .padding()
}

#Preview("Skeleton Card") {
    ScrollView {
        VStack(spacing: 16) {
            KSSkeletonCard()
            KSSkeletonCard(hasImage: false, lines: 4)
        }
        .padding()
    }
}

#Preview("Progress Bar") {
    VStack(spacing: 24) {
        KSProgressBar(progress: 0.3)
        KSProgressBar(progress: 0.6, showLabel: true)
        KSProgressBar(progress: 0.8, height: 12, color: KS.Colors.success)
        KSProgressBar(progress: 1.0, showLabel: true, color: KS.Colors.info)
    }
    .padding()
}

#Preview("Circular Progress") {
    HStack(spacing: 24) {
        KSCircularProgress(progress: 0.25)
        KSCircularProgress(progress: 0.5, color: KS.Colors.warning)
        KSCircularProgress(progress: 0.75, size: 80, lineWidth: 8)
        KSCircularProgress(progress: 1.0, showLabel: false, color: KS.Colors.success)
    }
    .padding()
}

#Preview("Loading Overlay") {
    ZStack {
        VStack {
            Text("Content behind overlay")
            Button("Action") {}
        }

        KSLoadingOverlay(message: "Loading...")
    }
}

#Preview("Loading Overlay Modifier") {
    VStack {
        Text("Main Content")
        Button("Submit") {}
    }
    .frame(maxWidth: .infinity, maxHeight: .infinity)
    .ksLoadingOverlay(isLoading: true, message: "Please wait...")
}
