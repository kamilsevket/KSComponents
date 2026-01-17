import SwiftUI

// MARK: - KSImageViewer

#if os(iOS)
public struct KSImageViewer: View {
    @Binding var isPresented: Bool
    let images: [URL]
    @State private var currentIndex: Int
    @State private var scale: CGFloat = 1.0
    @State private var offset: CGSize = .zero

    public init(
        isPresented: Binding<Bool>,
        images: [URL],
        initialIndex: Int = 0
    ) {
        self._isPresented = isPresented
        self.images = images
        self._currentIndex = State(initialValue: initialIndex)
    }

    public var body: some View {
        ZStack {
            Color.black.ignoresSafeArea()

            TabView(selection: $currentIndex) {
                ForEach(images.indices, id: \.self) { index in
                    AsyncImage(url: images[index]) { image in
                        image
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .scaleEffect(scale)
                            .offset(offset)
                            .gesture(
                                MagnificationGesture()
                                    .onChanged { value in
                                        scale = value
                                    }
                                    .onEnded { _ in
                                        withAnimation {
                                            scale = 1.0
                                        }
                                    }
                            )
                            .gesture(
                                DragGesture()
                                    .onChanged { value in
                                        if scale > 1.0 {
                                            offset = value.translation
                                        }
                                    }
                                    .onEnded { _ in
                                        withAnimation {
                                            offset = .zero
                                        }
                                    }
                            )
                            .gesture(
                                TapGesture(count: 2)
                                    .onEnded {
                                        withAnimation {
                                            scale = scale > 1.0 ? 1.0 : 2.0
                                        }
                                    }
                            )
                    } placeholder: {
                        ProgressView()
                            .tint(.white)
                    }
                    .tag(index)
                }
            }
            .tabViewStyle(.page(indexDisplayMode: .automatic))

            // Close Button
            VStack {
                HStack {
                    Spacer()
                    Button {
                        isPresented = false
                    } label: {
                        Image(systemName: "xmark")
                            .font(.title3.weight(.semibold))
                            .foregroundStyle(.white)
                            .padding(KS.Spacing.sm)
                            .background(.ultraThinMaterial)
                            .clipShape(Circle())
                    }
                    .padding()
                }
                Spacer()
            }

            // Page Indicator
            if images.count > 1 {
                VStack {
                    Spacer()
                    Text("\(currentIndex + 1) / \(images.count)")
                        .font(KS.Typography.caption)
                        .foregroundStyle(.white)
                        .padding(.horizontal, KS.Spacing.md)
                        .padding(.vertical, KS.Spacing.xs)
                        .background(.ultraThinMaterial)
                        .clipShape(Capsule())
                        .padding(.bottom, KS.Spacing.xl)
                }
            }
        }
    }
}

// MARK: - View Modifier for Image Viewer

public extension View {
    func ksImageViewer(
        isPresented: Binding<Bool>,
        images: [URL],
        initialIndex: Int = 0
    ) -> some View {
        fullScreenCover(isPresented: isPresented) {
            KSImageViewer(
                isPresented: isPresented,
                images: images,
                initialIndex: initialIndex
            )
        }
    }
}

// MARK: - Previews

#Preview("Image Viewer") {
    struct PreviewWrapper: View {
        @State private var isPresented = true

        var body: some View {
            Button("Show Image Viewer") {
                isPresented = true
            }
            .ksImageViewer(
                isPresented: $isPresented,
                images: [
                    URL(string: "https://picsum.photos/800/600?random=1")!,
                    URL(string: "https://picsum.photos/800/600?random=2")!,
                    URL(string: "https://picsum.photos/800/600?random=3")!
                ]
            )
        }
    }
    return PreviewWrapper()
}

#Preview("Single Image Viewer") {
    struct PreviewWrapper: View {
        @State private var isPresented = true

        var body: some View {
            Button("Show Single Image") {
                isPresented = true
            }
            .ksImageViewer(
                isPresented: $isPresented,
                images: [
                    URL(string: "https://picsum.photos/800/600")!
                ]
            )
        }
    }
    return PreviewWrapper()
}
#endif
