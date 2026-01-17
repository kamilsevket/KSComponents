import SwiftUI
import KSComponents

struct AvatarShowcase: View {
    var body: some View {
        ScrollView {
            VStack(spacing: KS.Spacing.xl) {
                ShowcaseSection("Avatar Sizes", description: "Available avatar sizes") {
                    HStack(spacing: KS.Spacing.md) {
                        VStack {
                            KSAvatar(name: "John Doe", size: .xs)
                            Text("XS").font(KS.Typography.caption)
                        }
                        VStack {
                            KSAvatar(name: "John Doe", size: .sm)
                            Text("SM").font(KS.Typography.caption)
                        }
                        VStack {
                            KSAvatar(name: "John Doe", size: .md)
                            Text("MD").font(KS.Typography.caption)
                        }
                        VStack {
                            KSAvatar(name: "John Doe", size: .lg)
                            Text("LG").font(KS.Typography.caption)
                        }
                        VStack {
                            KSAvatar(name: "John Doe", size: .xl)
                            Text("XL").font(KS.Typography.caption)
                        }
                    }
                }

                ShowcaseSection("Initials", description: "Avatars with name initials") {
                    HStack(spacing: KS.Spacing.lg) {
                        KSAvatar(name: "Alice Smith", size: .lg)
                        KSAvatar(name: "Bob Jones", size: .lg)
                        KSAvatar(name: "Carol White", size: .lg)
                        KSAvatar(name: "X", size: .lg)
                    }
                }

                ShowcaseSection("With Badge", description: "Online status indicator") {
                    HStack(spacing: KS.Spacing.lg) {
                        KSAvatar(name: "Alice Smith", size: .lg, showBadge: true)
                        KSAvatar(name: "Bob Jones", size: .lg, showBadge: true, badgeColor: KS.Colors.warning)
                        KSAvatar(name: "Carol White", size: .lg, showBadge: true, badgeColor: KS.Colors.error)
                    }
                }

                ShowcaseSection("With Image", description: "Avatar with remote image") {
                    HStack(spacing: KS.Spacing.lg) {
                        KSAvatar(
                            imageURL: URL(string: "https://picsum.photos/200"),
                            name: "John Doe",
                            size: .lg,
                            showBadge: true
                        )

                        KSAvatar(
                            imageURL: URL(string: "https://picsum.photos/201"),
                            name: "Jane Doe",
                            size: .xl
                        )
                    }
                }

                ShowcaseSection("Avatar Group", description: "Stacked avatars with overflow") {
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
                }
            }
            .padding()
        }
        .background(KS.Colors.background)
        .navigationTitle("Avatars")
    }
}

#Preview {
    NavigationStack {
        AvatarShowcase()
    }
}
