import SwiftUI

/// A view that displays list items with staggered slide-in animations
public struct KSStaggeredList<Data: RandomAccessCollection, Content: View>: View where Data.Element: Identifiable {
    let data: Data
    let staggerDelay: Double
    let content: (Data.Element) -> Content

    /// Creates a staggered list with animated item appearance
    /// - Parameters:
    ///   - data: The collection of identifiable data to display
    ///   - staggerDelay: The delay between each item's animation (default: 0.05)
    ///   - content: A view builder that creates the view for each item
    public init(
        _ data: Data,
        staggerDelay: Double = 0.05,
        @ViewBuilder content: @escaping (Data.Element) -> Content
    ) {
        self.data = data
        self.staggerDelay = staggerDelay
        self.content = content
    }

    public var body: some View {
        ForEach(Array(data.enumerated()), id: \.element.id) { index, item in
            content(item)
                .ksSlideIn(from: .bottom, delay: Double(index) * staggerDelay)
        }
    }
}
