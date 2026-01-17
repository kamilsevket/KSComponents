# KSComponents

Modern SwiftUI Component Library

## Requirements

- iOS 17.0+
- macOS 14.0+
- Xcode 15.0+
- Swift 5.9+

## Installation

### Swift Package Manager

Add the following to your `Package.swift` file:

```swift
dependencies: [
    .package(url: "https://github.com/kamilsevket/KSComponents.git", from: "1.0.0")
]
```

Or in Xcode:

1. Go to File > Add Packages...
2. Enter the repository URL
3. Select the version and add the package

## Usage

```swift
import KSComponents

struct ContentView: View {
    var body: some View {
        VStack(spacing: KS.Spacing.md) {
            Text("Hello, KSComponents!")
                .font(KS.Typography.headlineMedium)
        }
        .padding(KS.Spacing.lg)
    }
}
```

## Package Structure

```
KSComponents/
├── Sources/
│   └── KSComponents/
│       ├── KSComponents.swift       # Main exports
│       ├── Tokens/                  # Design tokens
│       │   ├── KSColors.swift
│       │   ├── KSTypography.swift
│       │   ├── KSSpacing.swift
│       │   └── KSShadows.swift
│       ├── Theme/                   # Theming support
│       │   └── KSTheme.swift
│       ├── Components/              # UI Components
│       │   ├── Buttons/
│       │   ├── Inputs/
│       │   ├── Cards/
│       │   ├── Lists/
│       │   ├── Navigation/
│       │   ├── Modals/
│       │   ├── Loading/
│       │   ├── Feedback/
│       │   └── Forms/
│       ├── Animations/              # Animation utilities
│       │   └── KSAnimations.swift
│       └── Extensions/              # View extensions
│           └── View+Extensions.swift
└── Tests/
    └── KSComponentsTests/
```

## Design Tokens

### Spacing

```swift
KS.Spacing.xs   // 4pt
KS.Spacing.sm   // 8pt
KS.Spacing.md   // 12pt
KS.Spacing.lg   // 16pt
KS.Spacing.xl   // 24pt
KS.Spacing.xxl  // 32pt
```

### Typography

```swift
KS.Typography.displayLarge
KS.Typography.headlineMedium
KS.Typography.bodyLarge
KS.Typography.labelMedium
```

### Shadows

```swift
view.ksShadow(KS.Shadows.small)
view.ksShadow(KS.Shadows.medium)
view.ksShadow(KS.Shadows.large)
```

### Animations

```swift
KS.Animation.defaultAnimation
KS.Animation.springDefault
KS.Animation.springBouncy
```

## Theming

```swift
let customTheme = KSTheme(
    colors: KSThemeColors(
        primary: .blue,
        secondary: .purple
    )
)

ContentView()
    .ksTheme(customTheme)
```

## License

MIT License
