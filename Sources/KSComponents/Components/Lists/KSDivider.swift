import SwiftUI

// MARK: - KSDivider

public struct KSDivider: View {
    let inset: CGFloat

    public init(inset: CGFloat = 0) {
        self.inset = inset
    }

    public var body: some View {
        Rectangle()
            .fill(KS.Colors.border)
            .frame(height: 0.5)
            .padding(.leading, inset)
    }
}

// MARK: - Preview

#if DEBUG
struct KSDivider_Previews: PreviewProvider {
    static var previews: some View {
        VStack(spacing: KS.Spacing.lg) {
            // Full width divider
            VStack {
                Text("Item 1")
                KSDivider()
                Text("Item 2")
            }
            .padding()
            .background(KS.Colors.surface)
            .clipShape(RoundedRectangle(cornerRadius: KS.Radius.md))

            // Inset divider (like iOS Settings)
            VStack {
                HStack {
                    Image(systemName: "person.fill")
                        .frame(width: 28)
                    Text("Profile")
                    Spacer()
                }
                KSDivider(inset: 44)
                HStack {
                    Image(systemName: "gear")
                        .frame(width: 28)
                    Text("Settings")
                    Spacer()
                }
            }
            .padding()
            .background(KS.Colors.surface)
            .clipShape(RoundedRectangle(cornerRadius: KS.Radius.md))
        }
        .padding()
        .background(KS.Colors.background)
    }
}
#endif
