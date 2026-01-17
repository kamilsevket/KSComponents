import SwiftUI

// MARK: - KSAsyncImage

public struct KSAsyncImage: View {
    let url: URL?
    let contentMode: ContentMode
    let placeholder: PlaceholderStyle

    public enum PlaceholderStyle {
        case skeleton
        case icon
        case color(Color)
    }

    public init(
        url: URL?,
        contentMode: ContentMode = .fill,
        placeholder: PlaceholderStyle = .skeleton
    ) {
        self.url = url
        self.contentMode = contentMode
        self.placeholder = placeholder
    }

    public var body: some View {
        AsyncImage(url: url) { phase in
            switch phase {
            case .success(let image):
                image
                    .resizable()
                    .aspectRatio(contentMode: contentMode)
            case .failure:
                errorView
            case .empty:
                placeholderView
            @unknown default:
                placeholderView
            }
        }
    }

    @ViewBuilder
    private var placeholderView: some View {
        switch placeholder {
        case .skeleton:
            KSSkeleton()
        case .icon:
            Rectangle()
                .fill(KS.Colors.surface)
                .overlay(
                    Image(systemName: "photo")
                        .font(.title)
                        .foregroundStyle(KS.Colors.textTertiary)
                )
        case .color(let color):
            Rectangle()
                .fill(color)
        }
    }

    private var errorView: some View {
        Rectangle()
            .fill(KS.Colors.surface)
            .overlay(
                Image(systemName: "exclamationmark.triangle")
                    .font(.title)
                    .foregroundStyle(KS.Colors.textTertiary)
            )
    }
}

// MARK: - Previews

#Preview("Async Image - Loading") {
    KSAsyncImage(url: nil)
        .frame(width: 200, height: 150)
        .clipShape(RoundedRectangle(cornerRadius: KS.Radius.md))
        .padding()
}

#Preview("Async Image - Icon Placeholder") {
    KSAsyncImage(url: nil, placeholder: .icon)
        .frame(width: 200, height: 150)
        .clipShape(RoundedRectangle(cornerRadius: KS.Radius.md))
        .padding()
}

#Preview("Async Image - Color Placeholder") {
    KSAsyncImage(url: nil, placeholder: .color(KS.Colors.primary.opacity(0.2)))
        .frame(width: 200, height: 150)
        .clipShape(RoundedRectangle(cornerRadius: KS.Radius.md))
        .padding()
}

#Preview("Async Image - With URL") {
    VStack(spacing: KS.Spacing.md) {
        KSAsyncImage(url: URL(string: "https://picsum.photos/400/300"))
            .frame(width: 200, height: 150)
            .clipShape(RoundedRectangle(cornerRadius: KS.Radius.md))

        KSAsyncImage(url: URL(string: "https://picsum.photos/400/300"), contentMode: .fit)
            .frame(width: 200, height: 150)
            .background(KS.Colors.surface)
            .clipShape(RoundedRectangle(cornerRadius: KS.Radius.md))
    }
    .padding()
}
