import SwiftUI

public struct KSFloatingTabBar: View {
    @Binding var selectedIndex: Int
    let items: [KSTabBar.TabItem]

    public init(selectedIndex: Binding<Int>, items: [KSTabBar.TabItem]) {
        self._selectedIndex = selectedIndex
        self.items = items
    }

    public var body: some View {
        HStack(spacing: KS.Spacing.lg) {
            ForEach(items.indices, id: \.self) { index in
                Button {
                    withAnimation(.spring(response: 0.3, dampingFraction: 0.7)) {
                        selectedIndex = index
                    }
                } label: {
                    VStack(spacing: KS.Spacing.xxs) {
                        Image(systemName: selectedIndex == index ? items[index].selectedIcon : items[index].icon)
                            .font(.title2)

                        if selectedIndex == index {
                            Circle()
                                .fill(KS.Colors.primary)
                                .frame(width: 4, height: 4)
                        }
                    }
                    .foregroundStyle(selectedIndex == index ? KS.Colors.primary : KS.Colors.textTertiary)
                }
                .buttonStyle(.plain)
            }
        }
        .padding(.horizontal, KS.Spacing.xl)
        .padding(.vertical, KS.Spacing.md)
        .background(
            Capsule()
                .fill(.ultraThinMaterial)
                .shadow(color: .black.opacity(0.15), radius: 20, y: 10)
        )
    }
}

#Preview {
    ZStack {
        Color.gray.opacity(0.2)
            .ignoresSafeArea()

        VStack {
            Spacer()
            KSFloatingTabBar(
                selectedIndex: .constant(1),
                items: [
                    .init(icon: "house", title: "Home"),
                    .init(icon: "magnifyingglass", selectedIcon: "magnifyingglass", title: "Search"),
                    .init(icon: "heart", title: "Favorites"),
                    .init(icon: "person", title: "Profile")
                ]
            )
            .padding(.bottom, 40)
        }
    }
}
