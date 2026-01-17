import SwiftUI
import KSComponents

struct ThemeShowcase: View {
    @State private var selectedTheme = 0
    let themes: [(String, KSThemeProtocol)] = [
        ("Default", KSDefaultTheme()),
        ("Ocean", KSOceanTheme()),
        ("Sunset", KSSunsetTheme()),
        ("Forest", KSForestTheme()),
        ("Lavender", KSLavenderTheme())
    ]

    var body: some View {
        ScrollView {
            VStack(spacing: KS.Spacing.xl) {
                ShowcaseSection("Spacing Tokens", description: "Consistent spacing values") {
                    VStack(alignment: .leading, spacing: KS.Spacing.sm) {
                        spacingRow("xxs", KS.Spacing.xxs)
                        spacingRow("xs", KS.Spacing.xs)
                        spacingRow("sm", KS.Spacing.sm)
                        spacingRow("md", KS.Spacing.md)
                        spacingRow("lg", KS.Spacing.lg)
                        spacingRow("xl", KS.Spacing.xl)
                        spacingRow("xxl", KS.Spacing.xxl)
                    }
                }

                ShowcaseSection("Radius Tokens", description: "Border radius values") {
                    HStack(spacing: KS.Spacing.md) {
                        radiusBox("xs", KS.Radius.xs)
                        radiusBox("sm", KS.Radius.sm)
                        radiusBox("md", KS.Radius.md)
                        radiusBox("lg", KS.Radius.lg)
                        radiusBox("xl", KS.Radius.xl)
                    }
                }

                ShowcaseSection("Typography", description: "Text styles hierarchy") {
                    VStack(alignment: .leading, spacing: KS.Spacing.md) {
                        Text("Display Large").font(KS.Typography.displayLarge)
                        Text("Headline Medium").font(KS.Typography.headlineMedium)
                        Text("Title Medium").font(KS.Typography.titleMedium)
                        Text("Body Large").font(KS.Typography.bodyLarge)
                        Text("Body Medium").font(KS.Typography.bodyMedium)
                        Text("Label Medium").font(KS.Typography.labelMedium)
                        Text("Caption").font(KS.Typography.caption)
                    }
                }

                ShowcaseSection("Colors", description: "Semantic color tokens") {
                    LazyVGrid(columns: [GridItem(.flexible()), GridItem(.flexible())], spacing: KS.Spacing.md) {
                        colorSwatch("Primary", KS.Colors.primary)
                        colorSwatch("Secondary", KS.Colors.secondary)
                        colorSwatch("Accent", KS.Colors.accent)
                        colorSwatch("Success", KS.Colors.success)
                        colorSwatch("Warning", KS.Colors.warning)
                        colorSwatch("Error", KS.Colors.error)
                        colorSwatch("Info", KS.Colors.info)
                        colorSwatch("Background", KS.Colors.background)
                        colorSwatch("Surface", KS.Colors.surface)
                        colorSwatch("Border", KS.Colors.border)
                    }
                }

                ShowcaseSection("Gradients", description: "Preset gradient styles") {
                    VStack(spacing: KS.Spacing.md) {
                        gradientSwatch("Primary", KS.Colors.gradientPrimary)
                        gradientSwatch("Sunrise", KS.Colors.gradientSunrise)
                        gradientSwatch("Ocean", KS.Colors.gradientOcean)
                    }
                }

                ShowcaseSection("Shadows", description: "Elevation shadow styles") {
                    HStack(spacing: KS.Spacing.lg) {
                        shadowBox("sm", KS.Shadows.sm)
                        shadowBox("md", KS.Shadows.md)
                        shadowBox("lg", KS.Shadows.lg)
                    }
                }

                ShowcaseSection("Theme Presets", description: "Built-in color themes") {
                    VStack(spacing: KS.Spacing.md) {
                        Picker("Theme", selection: $selectedTheme) {
                            ForEach(0..<themes.count, id: \.self) { index in
                                Text(themes[index].0).tag(index)
                            }
                        }
                        .pickerStyle(.segmented)

                        // Theme preview
                        VStack(spacing: KS.Spacing.sm) {
                            HStack(spacing: KS.Spacing.sm) {
                                Circle()
                                    .fill(themes[selectedTheme].1.primary)
                                    .frame(width: 40, height: 40)
                                Circle()
                                    .fill(themes[selectedTheme].1.secondary)
                                    .frame(width: 40, height: 40)
                                Circle()
                                    .fill(themes[selectedTheme].1.accent)
                                    .frame(width: 40, height: 40)
                                Circle()
                                    .fill(themes[selectedTheme].1.success)
                                    .frame(width: 40, height: 40)
                                Circle()
                                    .fill(themes[selectedTheme].1.error)
                                    .frame(width: 40, height: 40)
                            }

                            KSButton("Sample Button", style: .primary) { }
                        }
                        .padding()
                        .background(themes[selectedTheme].1.surface)
                        .clipShape(RoundedRectangle(cornerRadius: KS.Radius.lg))
                    }
                }
            }
            .padding()
        }
        .background(KS.Colors.background)
        .navigationTitle("Tokens & Theme")
    }

    private func spacingRow(_ name: String, _ value: CGFloat) -> some View {
        HStack {
            Text(name)
                .font(KS.Typography.labelMedium)
                .frame(width: 40, alignment: .leading)
            Rectangle()
                .fill(KS.Colors.primary)
                .frame(width: value, height: 20)
            Text("\(Int(value))pt")
                .font(KS.Typography.caption)
                .foregroundStyle(KS.Colors.textSecondary)
        }
    }

    private func radiusBox(_ name: String, _ radius: CGFloat) -> some View {
        VStack {
            RoundedRectangle(cornerRadius: radius)
                .fill(KS.Colors.primary)
                .frame(width: 50, height: 50)
            Text(name)
                .font(KS.Typography.caption)
        }
    }

    private func colorSwatch(_ name: String, _ color: Color) -> some View {
        HStack {
            Circle()
                .fill(color)
                .frame(width: 32, height: 32)
            Text(name)
                .font(KS.Typography.labelSmall)
            Spacer()
        }
        .padding(KS.Spacing.sm)
        .background(KS.Colors.surface)
        .clipShape(RoundedRectangle(cornerRadius: KS.Radius.sm))
    }

    private func gradientSwatch(_ name: String, _ gradient: LinearGradient) -> some View {
        HStack {
            RoundedRectangle(cornerRadius: KS.Radius.sm)
                .fill(gradient)
                .frame(width: 60, height: 32)
            Text(name)
                .font(KS.Typography.labelMedium)
            Spacer()
        }
    }

    private func shadowBox(_ name: String, _ shadow: KSShadow) -> some View {
        VStack {
            RoundedRectangle(cornerRadius: KS.Radius.md)
                .fill(KS.Colors.surface)
                .frame(width: 60, height: 60)
                .ksShadow(shadow)
            Text(name)
                .font(KS.Typography.caption)
        }
    }
}

#Preview {
    NavigationStack {
        ThemeShowcase()
    }
}
