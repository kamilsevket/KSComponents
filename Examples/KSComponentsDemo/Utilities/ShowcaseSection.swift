import SwiftUI
import KSComponents

struct ShowcaseSection<Content: View>: View {
    let title: String
    let description: String?
    let content: Content

    init(
        _ title: String,
        description: String? = nil,
        @ViewBuilder content: () -> Content
    ) {
        self.title = title
        self.description = description
        self.content = content()
    }

    var body: some View {
        VStack(alignment: .leading, spacing: KS.Spacing.md) {
            VStack(alignment: .leading, spacing: KS.Spacing.xxs) {
                Text(title)
                    .font(KS.Typography.titleMedium)

                if let description {
                    Text(description)
                        .font(KS.Typography.bodySmall)
                        .foregroundStyle(KS.Colors.textSecondary)
                }
            }

            content
        }
        .padding(KS.Spacing.md)
        .frame(maxWidth: .infinity, alignment: .leading)
        .background(KS.Colors.surface)
        .clipShape(RoundedRectangle(cornerRadius: KS.Radius.lg))
    }
}

#Preview {
    ScrollView {
        VStack(spacing: KS.Spacing.md) {
            ShowcaseSection("Example Section", description: "This is a description") {
                Text("Content goes here")
            }

            ShowcaseSection("No Description") {
                Text("Just title")
            }
        }
        .padding()
    }
    .background(KS.Colors.background)
}
