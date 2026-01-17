import SwiftUI

public struct KSTabBar: View {
    @Binding var selectedIndex: Int
    let items: [TabItem]

    public struct TabItem {
        let icon: String
        let selectedIcon: String
        let title: String

        public init(icon: String, selectedIcon: String? = nil, title: String) {
            self.icon = icon
            self.selectedIcon = selectedIcon ?? icon + ".fill"
            self.title = title
        }
    }

    public init(selectedIndex: Binding<Int>, items: [TabItem]) {
        self._selectedIndex = selectedIndex
        self.items = items
    }

    public var body: some View {
        HStack {
            ForEach(items.indices, id: \.self) { index in
                Button {
                    withAnimation(.spring(response: 0.3, dampingFraction: 0.7)) {
                        selectedIndex = index
                    }
                } label: {
                    VStack(spacing: KS.Spacing.xxs) {
                        Image(systemName: selectedIndex == index ? items[index].selectedIcon : items[index].icon)
                            .font(.title3)
                            .symbolEffect(.bounce, value: selectedIndex == index)

                        Text(items[index].title)
                            .font(KS.Typography.caption)
                    }
                    .foregroundStyle(selectedIndex == index ? KS.Colors.primary : KS.Colors.textTertiary)
                    .frame(maxWidth: .infinity)
                }
                .buttonStyle(.plain)
            }
        }
        .padding(.top, KS.Spacing.sm)
        .padding(.bottom, KS.Spacing.md)
        .background(
            KS.Colors.surface
                .shadow(color: .black.opacity(0.05), radius: 10, y: -5)
        )
    }
}

#Preview {
    VStack {
        Spacer()
        KSTabBar(
            selectedIndex: .constant(0),
            items: [
                .init(icon: "house", title: "Home"),
                .init(icon: "magnifyingglass", selectedIcon: "magnifyingglass", title: "Search"),
                .init(icon: "heart", title: "Favorites"),
                .init(icon: "person", title: "Profile")
            ]
        )
    }
}
