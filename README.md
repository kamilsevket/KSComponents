# KSComponents

A modern, customizable SwiftUI component library for iOS 17+.

## Requirements

- iOS 17.0+
- macOS 14.0+
- Xcode 15.0+
- Swift 5.9+

## Installation

### Swift Package Manager

Add to your `Package.swift`:

```swift
dependencies: [
    .package(url: "https://github.com/kamilsevket/KSComponents.git", from: "1.0.0")
]
```

Or in Xcode:

1. Go to File > Add Packages...
2. Enter the repository URL
3. Select the version and add the package

## Quick Start

```swift
import KSComponents

struct ContentView: View {
    @State private var email = ""

    var body: some View {
        VStack(spacing: KS.Spacing.md) {
            KSButton("Get Started", style: .primary) {
                print("Tapped!")
            }

            KSTextField("Email", text: $email, icon: "envelope")

            KSCard {
                Text("Hello, World!")
            }
        }
        .padding(KS.Spacing.lg)
    }
}
```

## Components

### Buttons

| Component | Description |
|-----------|-------------|
| `KSButton` | Customizable button with multiple styles and sizes |
| `KSIconButton` | Circular icon-only button |
| `KSFloatingButton` | Floating action button (FAB) |

```swift
// Primary button
KSButton("Submit", style: .primary) { }

// Button with icon
KSButton("Add Item", icon: "plus", iconPosition: .leading) { }

// Loading state
KSButton("Loading...", isLoading: true) { }

// Icon button
KSIconButton(icon: "heart", style: .primary) { }

// FAB
KSFloatingButton { }
```

**Button Styles:** `.primary`, `.secondary`, `.ghost`, `.destructive`, `.success`

**Button Sizes:** `.small`, `.medium`, `.large`

### Inputs

| Component | Description |
|-----------|-------------|
| `KSTextField` | Text input with label, icon, and validation |
| `KSSecureField` | Password input with show/hide toggle |
| `KSSearchField` | Search input with clear button |
| `KSTextEditor` | Multi-line text input |

```swift
// Basic text field
KSTextField("Email", text: $email, label: "Email", icon: "envelope")

// With validation error
KSTextField("Email", text: $email, errorText: "Invalid email")

// Password field
KSSecureField("Password", text: $password, label: "Password")

// Search field
KSSearchField("Search...", text: $searchText)

// Multi-line editor
KSTextEditor("Message", text: $message, label: "Your Message")
```

### Cards

| Component | Description |
|-----------|-------------|
| `KSCard` | Basic card container with styles |
| `KSInteractiveCard` | Tappable card with animation |
| `KSImageCard` | Card with async image loading |
| `KSGradientCard` | Gradient background card |
| `KSListCard` | List-style card item |

```swift
// Basic card
KSCard(style: .elevated) {
    Text("Card content")
}

// Interactive card
KSInteractiveCard(action: { }) {
    Text("Tap me")
}

// Image card
KSImageCard(
    imageURL: URL(string: "https://example.com/image.jpg"),
    title: "Title",
    subtitle: "Subtitle"
)

// Gradient card
KSGradientCard(gradient: KS.Colors.gradientPrimary) {
    Text("Premium").foregroundStyle(.white)
}
```

**Card Styles:** `.flat`, `.elevated`, `.outlined`

### Lists

| Component | Description |
|-----------|-------------|
| `KSRow` | List row with icon, title, and accessories |
| `KSGroupedList` | Grouped list container |
| `KSSwipeableRow` | Row with swipe actions |
| `KSDivider` | List divider |
| `KSSectionHeader` | Section header |

```swift
// Basic row
KSRow(icon: "person", title: "Profile", subtitle: "Edit profile")

// Row with toggle
KSRow(icon: "moon", title: "Dark Mode", accessory: .toggle($isDark))

// Swipeable row
KSSwipeableRow(
    trailingActions: [
        .init(icon: "trash", color: .red, action: { })
    ]
) {
    KSRow(title: "Swipe me")
}
```

**Accessory Types:** `.none`, `.chevron`, `.toggle(Binding<Bool>)`, `.checkmark(Bool)`, `.custom(AnyView)`

### Navigation

| Component | Description |
|-----------|-------------|
| `KSTabBar` | Bottom tab navigation |
| `KSFloatingTabBar` | Floating tab bar style |
| `KSNavBar` | Top navigation bar |
| `KSBottomSheet` | Bottom sheet modal |

```swift
// Tab bar
KSTabBar(
    selectedIndex: $selectedTab,
    items: [
        .init(icon: "house", title: "Home"),
        .init(icon: "person", title: "Profile")
    ]
)

// Navigation bar
KSNavBar(
    title: "Settings",
    leadingIcon: "chevron.left",
    leadingAction: { }
)
```

### Modals

| Component | Description |
|-----------|-------------|
| `KSAlert` | Custom alert dialog |
| `KSConfirmationDialog` | Confirmation dialog |
| `KSToast` | Toast notification |

```swift
// Alert
KSAlert(
    isPresented: $showAlert,
    icon: "checkmark.circle.fill",
    iconColor: KS.Colors.success,
    title: "Success!",
    message: "Your changes have been saved.",
    primaryButton: .init(title: "OK", action: { })
)

// Using modifier
.ksAlert(
    isPresented: $showAlert,
    title: "Delete?",
    primaryButton: .init(title: "Delete", style: .destructive, action: { }),
    secondaryButton: .init(title: "Cancel", style: .ghost, action: { })
)
```

### Loading

| Component | Description |
|-----------|-------------|
| `KSSpinner` | Activity indicator |
| `KSPulsingDots` | Animated pulsing dots |
| `KSSkeleton` | Skeleton loader with shimmer |
| `KSSkeletonCard` | Card skeleton placeholder |
| `KSProgressBar` | Linear progress indicator |
| `KSCircularProgress` | Circular progress indicator |
| `KSLoadingOverlay` | Full-screen loading overlay |

```swift
// Spinner
KSSpinner(size: .large, color: KS.Colors.primary)

// Progress bar
KSProgressBar(progress: 0.6, showLabel: true)

// Circular progress
KSCircularProgress(progress: 0.75)

// Loading overlay modifier
.ksLoadingOverlay(isLoading: isLoading, message: "Please wait...")
```

### Feedback

| Component | Description |
|-----------|-------------|
| `KSBadge` | Notification count badge |
| `KSDot` | Status indicator dot |
| `KSTag` | Tag/label component |
| `KSChip` | Selectable chip |
| `KSChipGroup` | Multi-select chip group |
| `KSStatusBadge` | Labeled status indicator |

```swift
// Badge on icon
Image(systemName: "bell")
    .ksBadge(5)

// Status dot
KSDot(color: KS.Colors.success, isPulsing: true)

// Tags
KSTag("Swift", icon: "swift", color: .orange)
KSTag("Removable", isRemovable: true, onRemove: { })

// Chip group
KSChipGroup(
    chips: ["Swift", "Kotlin", "JavaScript"],
    selectedChips: $selectedChips
)
```

### Media

| Component | Description |
|-----------|-------------|
| `KSAvatar` | User avatar with initials/image |
| `KSAvatarGroup` | Stacked avatar group |
| `KSAsyncImage` | Async image loader |

```swift
// Avatar with initials
KSAvatar(name: "John Doe", size: .lg, showBadge: true)

// Avatar with image
KSAvatar(imageURL: url, name: "John", size: .xl)

// Avatar group
KSAvatarGroup(
    avatars: [.init(name: "Alice"), .init(name: "Bob")],
    maxDisplay: 4
)
```

**Avatar Sizes:** `.xs`, `.sm`, `.md`, `.lg`, `.xl`

### Forms

| Component | Description |
|-----------|-------------|
| `KSToggle` | Toggle switch |
| `KSCheckbox` | Checkbox with label |
| `KSRadioGroup` | Radio button group |
| `KSSegmentedControl` | Segmented picker |
| `KSSlider` | Slider control |
| `KSStepper` | Stepper control |
| `KSDatePicker` | Date picker |

```swift
// Toggle
KSToggle(isOn: $isOn, label: "Dark Mode", description: "Enable dark theme")

// Checkbox
KSCheckbox(isChecked: $agreed, label: "I agree to terms")

// Radio group
KSRadioGroup(options: ["Option 1", "Option 2"], selectedOption: $selected)

// Slider
KSSlider(value: $volume, label: "Volume", showValue: true)
```

### States

| Component | Description |
|-----------|-------------|
| `KSEmptyState` | Empty state placeholder |
| `KSErrorState` | Error state view |
| `KSMaintenanceState` | Maintenance mode view |
| `KSOfflineBar` | Offline indicator bar |

```swift
// Custom empty state
KSEmptyState(
    icon: "folder",
    title: "No Files",
    message: "Add files to get started",
    actionTitle: "Add Files",
    action: { }
)

// Preset empty states
KSEmptyState.noResults(searchTerm: "Swift")
KSEmptyState.noData()
KSEmptyState.noConnection { }
KSEmptyState.noNotifications()
```

## Design Tokens

### Spacing

```swift
KS.Spacing.xxs   // 4pt
KS.Spacing.xs    // 8pt
KS.Spacing.sm    // 12pt
KS.Spacing.md    // 16pt
KS.Spacing.lg    // 24pt
KS.Spacing.xl    // 32pt
KS.Spacing.xxl   // 48pt
KS.Spacing.xxxl  // 64pt
```

### Radius

```swift
KS.Radius.xs     // 4pt
KS.Radius.sm     // 8pt
KS.Radius.md     // 12pt
KS.Radius.lg     // 16pt
KS.Radius.xl     // 24pt
KS.Radius.full   // 9999pt (circular)
```

### Typography

```swift
KS.Typography.displayLarge   // 57pt
KS.Typography.displayMedium  // 45pt
KS.Typography.headlineLarge  // 32pt
KS.Typography.headlineMedium // 28pt
KS.Typography.titleLarge     // 22pt
KS.Typography.titleMedium    // 18pt
KS.Typography.bodyLarge      // 16pt
KS.Typography.bodyMedium     // 14pt
KS.Typography.labelMedium    // 12pt
KS.Typography.caption        // 12pt
```

### Colors

```swift
// Brand
KS.Colors.primary
KS.Colors.secondary
KS.Colors.accent

// Semantic
KS.Colors.success
KS.Colors.warning
KS.Colors.error
KS.Colors.info

// Neutral
KS.Colors.background
KS.Colors.surface
KS.Colors.surfaceElevated

// Text
KS.Colors.textPrimary
KS.Colors.textSecondary
KS.Colors.textTertiary

// Gradients
KS.Colors.gradientPrimary
KS.Colors.gradientSunrise
KS.Colors.gradientOcean
```

### Shadows

```swift
view.ksShadow(KS.Shadows.sm)
view.ksShadow(KS.Shadows.md)
view.ksShadow(KS.Shadows.lg)
```

### Animations

```swift
// Durations
KS.Animation.durationFast    // 0.15s
KS.Animation.durationNormal  // 0.25s
KS.Animation.durationSlow    // 0.4s

// Animation presets
KS.Animation.defaultAnimation
KS.Animation.fastAnimation
KS.Animation.slowAnimation

// Spring presets
KS.Animation.springDefault
KS.Animation.springBouncy
KS.Animation.springStiff
KS.Animation.bouncy
KS.Animation.smooth
KS.Animation.snappy
```

## Theming

### Using Preset Themes

```swift
ContentView()
    .ksTheme(KSOceanTheme())
```

**Available Themes:**
- `KSDefaultTheme` - Default light theme
- `KSOceanTheme` - Blue/cyan colors
- `KSSunsetTheme` - Orange/golden colors
- `KSForestTheme` - Green colors
- `KSLavenderTheme` - Purple colors

### Creating Custom Theme

```swift
struct MyTheme: KSThemeProtocol {
    var primary: Color { Color.purple }
    var secondary: Color { Color.pink }
    var accent: Color { Color.cyan }
    var background: Color { Color(hex: "#F5F5F5") }
    var surface: Color { .white }
    var textPrimary: Color { .black }
    var textSecondary: Color { .gray }
    var border: Color { Color.gray.opacity(0.3) }
    var success: Color { .green }
    var warning: Color { .orange }
    var error: Color { .red }
}

ContentView()
    .ksTheme(MyTheme())
```

## Demo App

Run the demo app to see all components in action:

```bash
swift run KSComponentsDemo
```

Or open in Xcode and select the `KSComponentsDemo` scheme.

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
│       │   ├── Media/
│       │   ├── Forms/
│       │   └── States/
│       ├── Animations/              # Animation utilities
│       └── Extensions/              # View extensions
├── Examples/
│   └── KSComponentsDemo/            # Demo app
└── Tests/
    └── KSComponentsTests/
```

## License

MIT License
