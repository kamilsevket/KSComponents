import SwiftUI
import KSComponents

struct ListItem: Identifiable {
    let id = UUID()
    let name: String
}

struct AnimationShowcase: View {
    @State private var isAnimating = false
    @State private var showItem = true
    private let items = [
        ListItem(name: "Item 1"),
        ListItem(name: "Item 2"),
        ListItem(name: "Item 3"),
        ListItem(name: "Item 4"),
        ListItem(name: "Item 5")
    ]

    var body: some View {
        ScrollView {
            VStack(spacing: KS.Spacing.xl) {
                ShowcaseSection("Duration Presets", description: "Standard animation durations") {
                    VStack(alignment: .leading, spacing: KS.Spacing.sm) {
                        Text("Fast: \(KS.Animation.durationFast)s")
                        Text("Normal: \(KS.Animation.durationNormal)s")
                        Text("Slow: \(KS.Animation.durationSlow)s")
                    }
                    .font(KS.Typography.bodyMedium)
                }

                ShowcaseSection("Spring Animations", description: "Tap to see spring effects") {
                    VStack(spacing: KS.Spacing.lg) {
                        HStack(spacing: KS.Spacing.lg) {
                            VStack {
                                Circle()
                                    .fill(KS.Colors.primary)
                                    .frame(width: 50, height: 50)
                                    .scaleEffect(isAnimating ? 1.2 : 1.0)
                                    .animation(KS.Animation.springDefault, value: isAnimating)
                                Text("Default").font(KS.Typography.caption)
                            }

                            VStack {
                                Circle()
                                    .fill(KS.Colors.secondary)
                                    .frame(width: 50, height: 50)
                                    .scaleEffect(isAnimating ? 1.2 : 1.0)
                                    .animation(KS.Animation.springBouncy, value: isAnimating)
                                Text("Bouncy").font(KS.Typography.caption)
                            }

                            VStack {
                                Circle()
                                    .fill(KS.Colors.accent)
                                    .frame(width: 50, height: 50)
                                    .scaleEffect(isAnimating ? 1.2 : 1.0)
                                    .animation(KS.Animation.springStiff, value: isAnimating)
                                Text("Stiff").font(KS.Typography.caption)
                            }
                        }

                        KSButton("Toggle Animation", style: .primary) {
                            isAnimating.toggle()
                        }
                    }
                }

                ShowcaseSection("Easing Presets", description: "Different easing curves") {
                    VStack(spacing: KS.Spacing.lg) {
                        HStack(spacing: KS.Spacing.lg) {
                            VStack {
                                RoundedRectangle(cornerRadius: KS.Radius.sm)
                                    .fill(KS.Colors.success)
                                    .frame(width: 50, height: 50)
                                    .offset(x: isAnimating ? 30 : -30)
                                    .animation(KS.Animation.quick, value: isAnimating)
                                Text("Quick").font(KS.Typography.caption)
                            }

                            VStack {
                                RoundedRectangle(cornerRadius: KS.Radius.sm)
                                    .fill(KS.Colors.warning)
                                    .frame(width: 50, height: 50)
                                    .offset(x: isAnimating ? 30 : -30)
                                    .animation(KS.Animation.medium, value: isAnimating)
                                Text("Medium").font(KS.Typography.caption)
                            }

                            VStack {
                                RoundedRectangle(cornerRadius: KS.Radius.sm)
                                    .fill(KS.Colors.error)
                                    .frame(width: 50, height: 50)
                                    .offset(x: isAnimating ? 30 : -30)
                                    .animation(KS.Animation.slow, value: isAnimating)
                                Text("Slow").font(KS.Typography.caption)
                            }
                        }
                    }
                }

                ShowcaseSection("Typing Indicator", description: "Animated typing dots") {
                    HStack(spacing: KS.Spacing.lg) {
                        KSTypingIndicator()
                    }
                }

                ShowcaseSection("Staggered List", description: "Animated list appearance") {
                    VStack(spacing: KS.Spacing.md) {
                        KSButton(showItem ? "Hide Items" : "Show Items", style: .secondary) {
                            withAnimation {
                                showItem.toggle()
                            }
                        }

                        if showItem {
                            KSStaggeredList(items) { item in
                                KSCard {
                                    Text(item.name)
                                        .frame(maxWidth: .infinity, alignment: .leading)
                                }
                            }
                        }
                    }
                }

                ShowcaseSection("Appear Animations", description: "View appearance modifiers") {
                    VStack(spacing: KS.Spacing.md) {
                        if showItem {
                            Text("Fade In")
                                .padding()
                                .background(KS.Colors.primary.opacity(0.2))
                                .clipShape(RoundedRectangle(cornerRadius: KS.Radius.md))
                                .ksFadeIn()

                            Text("Slide In (Bottom)")
                                .padding()
                                .background(KS.Colors.secondary.opacity(0.2))
                                .clipShape(RoundedRectangle(cornerRadius: KS.Radius.md))
                                .ksSlideIn(from: .bottom, delay: 0.1)

                            Text("Slide In (Leading)")
                                .padding()
                                .background(KS.Colors.accent.opacity(0.2))
                                .clipShape(RoundedRectangle(cornerRadius: KS.Radius.md))
                                .ksSlideIn(from: .leading, delay: 0.2)
                        }
                    }
                }
            }
            .padding()
        }
        .background(KS.Colors.background)
        .navigationTitle("Animations")
    }
}

#Preview {
    NavigationStack {
        AnimationShowcase()
    }
}
