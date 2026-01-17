import SwiftUI

// MARK: - KSAvatar

public struct KSAvatar: View {
    let imageURL: URL?
    let name: String?
    let size: Size
    let showBadge: Bool
    let badgeColor: Color

    public enum Size {
        case xs, sm, md, lg, xl

        var dimension: CGFloat {
            switch self {
            case .xs: 24
            case .sm: 32
            case .md: 40
            case .lg: 56
            case .xl: 80
            }
        }

        var font: Font {
            switch self {
            case .xs: .caption2
            case .sm: .caption
            case .md: .callout
            case .lg: .title3
            case .xl: .title
            }
        }
    }

    public init(
        imageURL: URL? = nil,
        name: String? = nil,
        size: Size = .md,
        showBadge: Bool = false,
        badgeColor: Color = KS.Colors.success
    ) {
        self.imageURL = imageURL
        self.name = name
        self.size = size
        self.showBadge = showBadge
        self.badgeColor = badgeColor
    }

    public var body: some View {
        ZStack(alignment: .bottomTrailing) {
            // Avatar Image or Initials
            Group {
                if let url = imageURL {
                    AsyncImage(url: url) { phase in
                        switch phase {
                        case .success(let image):
                            image
                                .resizable()
                                .aspectRatio(contentMode: .fill)
                        case .failure:
                            initialsView
                        case .empty:
                            ProgressView()
                        @unknown default:
                            initialsView
                        }
                    }
                } else {
                    initialsView
                }
            }
            .frame(width: size.dimension, height: size.dimension)
            .clipShape(Circle())

            // Online Badge
            if showBadge {
                Circle()
                    .fill(badgeColor)
                    .frame(width: size.dimension * 0.3, height: size.dimension * 0.3)
                    .overlay(
                        Circle()
                            .stroke(KS.Colors.surface, lineWidth: 2)
                    )
            }
        }
    }

    private var initialsView: some View {
        Circle()
            .fill(KS.Colors.primary.opacity(0.2))
            .overlay(
                Text(initials)
                    .font(size.font.weight(.semibold))
                    .foregroundStyle(KS.Colors.primary)
            )
    }

    private var initials: String {
        guard let name = name else { return "?" }
        let components = name.split(separator: " ")
        let initials = components.prefix(2).compactMap { $0.first }.map(String.init)
        return initials.joined().uppercased()
    }
}

// MARK: - KSAvatarGroup

public struct KSAvatarGroup: View {
    let avatars: [AvatarData]
    let maxDisplay: Int
    let size: KSAvatar.Size

    public struct AvatarData: Identifiable {
        public let id: UUID
        public let imageURL: URL?
        public let name: String?

        public init(id: UUID = UUID(), imageURL: URL? = nil, name: String? = nil) {
            self.id = id
            self.imageURL = imageURL
            self.name = name
        }
    }

    public init(
        avatars: [AvatarData],
        maxDisplay: Int = 4,
        size: KSAvatar.Size = .md
    ) {
        self.avatars = avatars
        self.maxDisplay = maxDisplay
        self.size = size
    }

    public var body: some View {
        HStack(spacing: -size.dimension * 0.3) {
            ForEach(displayAvatars) { avatar in
                KSAvatar(imageURL: avatar.imageURL, name: avatar.name, size: size)
                    .overlay(
                        Circle()
                            .stroke(KS.Colors.surface, lineWidth: 2)
                    )
            }

            if overflow > 0 {
                Circle()
                    .fill(KS.Colors.primary)
                    .frame(width: size.dimension, height: size.dimension)
                    .overlay(
                        Text("+\(overflow)")
                            .font(size.font.weight(.semibold))
                            .foregroundStyle(.white)
                    )
                    .overlay(
                        Circle()
                            .stroke(KS.Colors.surface, lineWidth: 2)
                    )
            }
        }
    }

    private var displayAvatars: [AvatarData] {
        Array(avatars.prefix(maxDisplay))
    }

    private var overflow: Int {
        max(0, avatars.count - maxDisplay)
    }
}

// MARK: - Previews

#Preview("Avatar Sizes") {
    HStack(spacing: KS.Spacing.md) {
        VStack {
            KSAvatar(name: "John Doe", size: .xs)
            Text("XS").font(.caption)
        }
        VStack {
            KSAvatar(name: "John Doe", size: .sm)
            Text("SM").font(.caption)
        }
        VStack {
            KSAvatar(name: "John Doe", size: .md)
            Text("MD").font(.caption)
        }
        VStack {
            KSAvatar(name: "John Doe", size: .lg)
            Text("LG").font(.caption)
        }
        VStack {
            KSAvatar(name: "John Doe", size: .xl)
            Text("XL").font(.caption)
        }
    }
    .padding()
}

#Preview("Avatar with Badge") {
    HStack(spacing: KS.Spacing.lg) {
        KSAvatar(name: "Alice Smith", size: .lg, showBadge: true)
        KSAvatar(name: "Bob Jones", size: .lg, showBadge: true, badgeColor: KS.Colors.warning)
        KSAvatar(name: "Carol White", size: .lg, showBadge: true, badgeColor: KS.Colors.error)
    }
    .padding()
}

#Preview("Avatar with Image") {
    VStack(spacing: KS.Spacing.md) {
        KSAvatar(
            imageURL: URL(string: "https://picsum.photos/200"),
            name: "John Doe",
            size: .xl,
            showBadge: true
        )
        Text("With Image URL")
            .font(KS.Typography.caption)
    }
    .padding()
}

#Preview("Avatar Group") {
    VStack(spacing: KS.Spacing.lg) {
        KSAvatarGroup(avatars: [
            .init(name: "Alice"),
            .init(name: "Bob"),
            .init(name: "Carol")
        ])

        KSAvatarGroup(avatars: [
            .init(name: "Alice"),
            .init(name: "Bob"),
            .init(name: "Carol"),
            .init(name: "David"),
            .init(name: "Eve"),
            .init(name: "Frank")
        ], maxDisplay: 4)

        KSAvatarGroup(avatars: [
            .init(name: "A"),
            .init(name: "B"),
            .init(name: "C"),
            .init(name: "D"),
            .init(name: "E"),
            .init(name: "F"),
            .init(name: "G"),
            .init(name: "H"),
            .init(name: "I"),
            .init(name: "J")
        ], maxDisplay: 3, size: .lg)
    }
    .padding()
}
