import SwiftUI

// MARK: - KSCard

public struct KSCard<Content: View>: View {
    public enum Style {
        case flat
        case elevated
        case outlined
    }

    let style: Style
    let padding: CGFloat
    let content: Content

    public init(
        style: Style = .elevated,
        padding: CGFloat = KS.Spacing.md,
        @ViewBuilder content: () -> Content
    ) {
        self.style = style
        self.padding = padding
        self.content = content()
    }

    public var body: some View {
        content
            .padding(padding)
            .background(KS.Colors.surface)
            .clipShape(RoundedRectangle(cornerRadius: KS.Radius.lg))
            .overlay(
                RoundedRectangle(cornerRadius: KS.Radius.lg)
                    .stroke(style == .outlined ? KS.Colors.border : .clear, lineWidth: 1)
            )
            .modifier(CardShadowModifier(style: style))
    }
}

struct CardShadowModifier: ViewModifier {
    let style: KSCard<EmptyView>.Style

    func body(content: Content) -> some View {
        switch style {
        case .flat, .outlined:
            content
        case .elevated:
            content.ksShadow(KS.Shadows.md)
        }
    }
}

// MARK: - KSInteractiveCard

public struct KSInteractiveCard<Content: View>: View {
    let content: Content
    let action: () -> Void
    @State private var isPressed = false

    public init(
        action: @escaping () -> Void,
        @ViewBuilder content: () -> Content
    ) {
        self.action = action
        self.content = content()
    }

    public var body: some View {
        Button(action: action) {
            content
                .padding(KS.Spacing.md)
                .background(KS.Colors.surface)
                .clipShape(RoundedRectangle(cornerRadius: KS.Radius.lg))
                .ksShadow(KS.Shadows.md)
                .scaleEffect(isPressed ? 0.98 : 1.0)
                .animation(.spring(response: 0.2, dampingFraction: 0.7), value: isPressed)
        }
        .buttonStyle(.plain)
        .simultaneousGesture(
            DragGesture(minimumDistance: 0)
                .onChanged { _ in isPressed = true }
                .onEnded { _ in isPressed = false }
        )
    }
}

// MARK: - KSImageCard

public struct KSImageCard: View {
    let imageURL: URL?
    let title: String
    let subtitle: String?
    let aspectRatio: CGFloat
    let action: (() -> Void)?

    public init(
        imageURL: URL?,
        title: String,
        subtitle: String? = nil,
        aspectRatio: CGFloat = 16 / 9,
        action: (() -> Void)? = nil
    ) {
        self.imageURL = imageURL
        self.title = title
        self.subtitle = subtitle
        self.aspectRatio = aspectRatio
        self.action = action
    }

    public var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            // Image
            AsyncImage(url: imageURL) { phase in
                switch phase {
                case .empty:
                    Rectangle()
                        .fill(KS.Colors.surface)
                        .overlay(ProgressView())
                case .success(let image):
                    image
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                case .failure:
                    Rectangle()
                        .fill(KS.Colors.surface)
                        .overlay(
                            Image(systemName: "photo")
                                .foregroundStyle(KS.Colors.textTertiary)
                        )
                @unknown default:
                    EmptyView()
                }
            }
            .aspectRatio(aspectRatio, contentMode: .fill)
            .clipped()

            // Content
            VStack(alignment: .leading, spacing: KS.Spacing.xxs) {
                Text(title)
                    .font(KS.Typography.titleMedium)
                    .foregroundStyle(KS.Colors.textPrimary)
                    .lineLimit(2)

                if let subtitle {
                    Text(subtitle)
                        .font(KS.Typography.bodySmall)
                        .foregroundStyle(KS.Colors.textSecondary)
                        .lineLimit(2)
                }
            }
            .padding(KS.Spacing.md)
        }
        .background(KS.Colors.surface)
        .clipShape(RoundedRectangle(cornerRadius: KS.Radius.lg))
        .ksShadow(KS.Shadows.md)
        .onTapGesture {
            action?()
        }
    }
}

// MARK: - KSGradientCard

public struct KSGradientCard<Content: View>: View {
    let gradient: LinearGradient
    let content: Content

    public init(
        gradient: LinearGradient = KS.Colors.gradientPrimary,
        @ViewBuilder content: () -> Content
    ) {
        self.gradient = gradient
        self.content = content()
    }

    public var body: some View {
        content
            .padding(KS.Spacing.lg)
            .background(gradient)
            .clipShape(RoundedRectangle(cornerRadius: KS.Radius.xl))
            .ksShadow(KS.Shadows.lg)
    }
}

// MARK: - KSListCard

public struct KSListCard: View {
    let icon: String?
    let title: String
    let subtitle: String?
    let trailing: String?
    let showChevron: Bool
    let action: (() -> Void)?

    public init(
        icon: String? = nil,
        title: String,
        subtitle: String? = nil,
        trailing: String? = nil,
        showChevron: Bool = true,
        action: (() -> Void)? = nil
    ) {
        self.icon = icon
        self.title = title
        self.subtitle = subtitle
        self.trailing = trailing
        self.showChevron = showChevron
        self.action = action
    }

    public var body: some View {
        Button {
            action?()
        } label: {
            HStack(spacing: KS.Spacing.md) {
                if let icon {
                    Image(systemName: icon)
                        .font(.title3)
                        .foregroundStyle(KS.Colors.primary)
                        .frame(width: 40, height: 40)
                        .background(KS.Colors.primary.opacity(0.1))
                        .clipShape(RoundedRectangle(cornerRadius: KS.Radius.sm))
                }

                VStack(alignment: .leading, spacing: KS.Spacing.xxs) {
                    Text(title)
                        .font(KS.Typography.bodyLarge)
                        .foregroundStyle(KS.Colors.textPrimary)

                    if let subtitle {
                        Text(subtitle)
                            .font(KS.Typography.bodySmall)
                            .foregroundStyle(KS.Colors.textSecondary)
                    }
                }

                Spacer()

                if let trailing {
                    Text(trailing)
                        .font(KS.Typography.bodyMedium)
                        .foregroundStyle(KS.Colors.textSecondary)
                }

                if showChevron {
                    Image(systemName: "chevron.right")
                        .font(.caption.weight(.semibold))
                        .foregroundStyle(KS.Colors.textTertiary)
                }
            }
            .padding(KS.Spacing.md)
            .background(KS.Colors.surface)
            .clipShape(RoundedRectangle(cornerRadius: KS.Radius.md))
        }
        .buttonStyle(KSButtonStyle())
    }
}

// MARK: - Previews

#Preview("Card Styles") {
    VStack(spacing: 16) {
        KSCard(style: .flat) {
            Text("Flat Card")
                .frame(maxWidth: .infinity)
        }

        KSCard(style: .elevated) {
            Text("Elevated Card")
                .frame(maxWidth: .infinity)
        }

        KSCard(style: .outlined) {
            Text("Outlined Card")
                .frame(maxWidth: .infinity)
        }
    }
    .padding()
}

#Preview("Interactive Card") {
    KSInteractiveCard(action: { print("Tapped") }) {
        VStack(alignment: .leading, spacing: 8) {
            Text("Interactive Card")
                .font(KS.Typography.titleMedium)
            Text("Tap me to see the animation")
                .font(KS.Typography.bodySmall)
                .foregroundStyle(KS.Colors.textSecondary)
        }
        .frame(maxWidth: .infinity, alignment: .leading)
    }
    .padding()
}

#Preview("Image Card") {
    VStack(spacing: 16) {
        KSImageCard(
            imageURL: URL(string: "https://picsum.photos/400/200"),
            title: "Beautiful Landscape",
            subtitle: "A stunning view of nature"
        )

        KSImageCard(
            imageURL: nil,
            title: "No Image",
            subtitle: "This card has no image"
        )
    }
    .padding()
}

#Preview("Gradient Card") {
    VStack(spacing: 16) {
        KSGradientCard(gradient: KS.Colors.gradientPrimary) {
            VStack(alignment: .leading, spacing: 8) {
                Text("Premium Feature")
                    .font(KS.Typography.titleMedium)
                    .foregroundStyle(.white)
                Text("Upgrade to unlock")
                    .font(KS.Typography.bodySmall)
                    .foregroundStyle(.white.opacity(0.8))
            }
            .frame(maxWidth: .infinity, alignment: .leading)
        }

        KSGradientCard(gradient: KS.Colors.gradientSunrise) {
            Text("Sunrise Gradient")
                .foregroundStyle(.white)
        }

        KSGradientCard(gradient: KS.Colors.gradientOcean) {
            Text("Ocean Gradient")
                .foregroundStyle(.white)
        }
    }
    .padding()
}

#Preview("List Card") {
    VStack(spacing: 12) {
        KSListCard(
            icon: "person.fill",
            title: "Profile",
            subtitle: "View and edit your profile"
        )

        KSListCard(
            icon: "gear",
            title: "Settings",
            trailing: "3"
        )

        KSListCard(
            icon: "bell.fill",
            title: "Notifications",
            subtitle: "Manage your notifications",
            trailing: "5 new",
            showChevron: true
        )

        KSListCard(
            title: "Simple List Item",
            showChevron: false
        )
    }
    .padding()
}
