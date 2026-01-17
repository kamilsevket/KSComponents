import SwiftUI
import KSComponents

struct LoadingShowcase: View {
    @State private var progress: Double = 0.6
    @State private var isLoading = false

    var body: some View {
        ScrollView {
            VStack(spacing: KS.Spacing.xl) {
                ShowcaseSection("Spinners", description: "Circular loading indicators") {
                    HStack(spacing: KS.Spacing.xl) {
                        VStack {
                            KSSpinner(size: .small)
                            Text("Small").font(KS.Typography.caption)
                        }
                        VStack {
                            KSSpinner(size: .medium)
                            Text("Medium").font(KS.Typography.caption)
                        }
                        VStack {
                            KSSpinner(size: .large)
                            Text("Large").font(KS.Typography.caption)
                        }
                    }
                }

                ShowcaseSection("Spinner Colors", description: "Customizable spinner colors") {
                    HStack(spacing: KS.Spacing.xl) {
                        KSSpinner(color: KS.Colors.primary)
                        KSSpinner(color: KS.Colors.success)
                        KSSpinner(color: KS.Colors.warning)
                        KSSpinner(color: KS.Colors.error)
                    }
                }

                ShowcaseSection("Pulsing Dots", description: "Animated dot loader") {
                    VStack(spacing: KS.Spacing.md) {
                        KSPulsingDots()
                        KSPulsingDots(color: KS.Colors.secondary)
                        KSPulsingDots(color: KS.Colors.success)
                    }
                }

                ShowcaseSection("Skeleton Loader", description: "Content placeholder animation") {
                    VStack(alignment: .leading, spacing: KS.Spacing.sm) {
                        KSSkeleton(width: 200, height: 24)
                        KSSkeleton(height: 16)
                        KSSkeleton(width: 150, height: 16)
                    }
                }

                ShowcaseSection("Skeleton Card", description: "Full card skeleton placeholder") {
                    VStack(spacing: KS.Spacing.md) {
                        KSSkeletonCard()
                        KSSkeletonCard(hasImage: false, lines: 4)
                    }
                }

                ShowcaseSection("Progress Bar", description: "Linear progress indicator") {
                    VStack(spacing: KS.Spacing.lg) {
                        KSProgressBar(progress: 0.3)
                        KSProgressBar(progress: progress, showLabel: true)
                        KSProgressBar(progress: 0.8, height: 12, color: KS.Colors.success)

                        Slider(value: $progress, in: 0...1)
                            .tint(KS.Colors.primary)
                    }
                }

                ShowcaseSection("Circular Progress", description: "Circular progress indicator") {
                    HStack(spacing: KS.Spacing.lg) {
                        KSCircularProgress(progress: 0.25)
                        KSCircularProgress(progress: 0.5, color: KS.Colors.warning)
                        KSCircularProgress(progress: 0.75, size: 80, lineWidth: 8)
                        KSCircularProgress(progress: 1.0, showLabel: false, color: KS.Colors.success)
                    }
                }

                ShowcaseSection("Loading Overlay", description: "Full-screen loading state") {
                    KSButton("Toggle Loading Overlay", style: .primary) {
                        isLoading = true
                        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                            isLoading = false
                        }
                    }
                }
            }
            .padding()
        }
        .background(KS.Colors.background)
        .navigationTitle("Loading")
        .ksLoadingOverlay(isLoading: isLoading, message: "Please wait...")
    }
}

#Preview {
    NavigationStack {
        LoadingShowcase()
    }
}
