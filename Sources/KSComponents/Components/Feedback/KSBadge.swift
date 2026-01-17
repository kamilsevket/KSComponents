import SwiftUI

// MARK: - KSBadge

public struct KSBadge: View {
    let count: Int
    let maxCount: Int
    let color: Color
    let size: Size

    public enum Size {
        case small, medium

        var dimension: CGFloat {
            switch self {
            case .small: 18
            case .medium: 24
            }
        }

        var font: Font {
            switch self {
            case .small: KS.Typography.caption
            case .medium: KS.Typography.labelSmall
            }
        }
    }

    public init(
        count: Int,
        maxCount: Int = 99,
        color: Color = KS.Colors.error,
        size: Size = .medium
    ) {
        self.count = count
        self.maxCount = maxCount
        self.color = color
        self.size = size
    }

    public var body: some View {
        // swiftlint:disable:next empty_count
        if count > 0 {
            Text(count > maxCount ? "\(maxCount)+" : "\(count)")
                .font(size.font)
                .foregroundStyle(.white)
                .frame(minWidth: size.dimension, minHeight: size.dimension)
                .padding(.horizontal, count > 9 ? 6 : 0)
                .background(color)
                .clipShape(Capsule())
        }
    }
}

// MARK: - Badge Overlay Modifier

public extension View {
    func ksBadge(_ count: Int, color: Color = KS.Colors.error) -> some View {
        overlay(alignment: .topTrailing) {
            KSBadge(count: count, color: color)
                .offset(x: 8, y: -8)
        }
    }
}

// MARK: - KSDot (Status Indicator)

public struct KSDot: View {
    let color: Color
    let size: CGFloat
    let isPulsing: Bool

    @State private var isAnimating = false

    public init(
        color: Color = KS.Colors.success,
        size: CGFloat = 8,
        isPulsing: Bool = false
    ) {
        self.color = color
        self.size = size
        self.isPulsing = isPulsing
    }

    public var body: some View {
        ZStack {
            if isPulsing {
                Circle()
                    .fill(color.opacity(0.3))
                    .frame(width: size * 2, height: size * 2)
                    .scaleEffect(isAnimating ? 1.5 : 1.0)
                    .opacity(isAnimating ? 0 : 0.5)
                    .animation(
                        .easeInOut(duration: 1.5)
                            .repeatForever(autoreverses: false),
                        value: isAnimating
                    )
            }

            Circle()
                .fill(color)
                .frame(width: size, height: size)
        }
        .onAppear {
            if isPulsing {
                isAnimating = true
            }
        }
    }
}

// MARK: - KSTag

public struct KSTag: View {
    let text: String
    let icon: String?
    let color: Color
    let isRemovable: Bool
    let onRemove: (() -> Void)?

    public init(
        _ text: String,
        icon: String? = nil,
        color: Color = KS.Colors.primary,
        isRemovable: Bool = false,
        onRemove: (() -> Void)? = nil
    ) {
        self.text = text
        self.icon = icon
        self.color = color
        self.isRemovable = isRemovable
        self.onRemove = onRemove
    }

    public var body: some View {
        HStack(spacing: KS.Spacing.xxs) {
            if let icon {
                Image(systemName: icon)
                    .font(.caption2)
            }

            Text(text)
                .font(KS.Typography.labelSmall)

            if isRemovable {
                Button {
                    onRemove?()
                } label: {
                    Image(systemName: "xmark")
                        .font(.caption2.weight(.bold))
                }
            }
        }
        .foregroundStyle(color)
        .padding(.horizontal, KS.Spacing.sm)
        .padding(.vertical, KS.Spacing.xxs)
        .background(color.opacity(0.1))
        .clipShape(Capsule())
    }
}

// MARK: - KSChip

public struct KSChip: View {
    let text: String
    let icon: String?
    @Binding var isSelected: Bool
    let onTap: (() -> Void)?

    public init(
        _ text: String,
        icon: String? = nil,
        isSelected: Binding<Bool>,
        onTap: (() -> Void)? = nil
    ) {
        self.text = text
        self.icon = icon
        self._isSelected = isSelected
        self.onTap = onTap
    }

    public var body: some View {
        Button {
            withAnimation(.spring(response: 0.2, dampingFraction: 0.7)) {
                isSelected.toggle()
            }
            onTap?()
        } label: {
            HStack(spacing: KS.Spacing.xs) {
                if let icon {
                    Image(systemName: icon)
                        .font(.caption)
                }

                Text(text)
                    .font(KS.Typography.labelMedium)

                if isSelected {
                    Image(systemName: "checkmark")
                        .font(.caption.weight(.bold))
                        .transition(.scale.combined(with: .opacity))
                }
            }
            .foregroundStyle(isSelected ? .white : KS.Colors.textPrimary)
            .padding(.horizontal, KS.Spacing.md)
            .padding(.vertical, KS.Spacing.sm)
            .background(isSelected ? KS.Colors.primary : KS.Colors.surface)
            .clipShape(Capsule())
            .overlay(
                Capsule()
                    .stroke(isSelected ? .clear : KS.Colors.border, lineWidth: 1)
            )
        }
        .buttonStyle(.plain)
    }
}

// MARK: - KSChipGroup

public struct KSChipGroup: View {
    let chips: [String]
    @Binding var selectedChips: Set<String>
    let allowMultiple: Bool

    public init(
        chips: [String],
        selectedChips: Binding<Set<String>>,
        allowMultiple: Bool = true
    ) {
        self.chips = chips
        self._selectedChips = selectedChips
        self.allowMultiple = allowMultiple
    }

    public var body: some View {
        FlowLayout(spacing: KS.Spacing.sm) {
            ForEach(chips, id: \.self) { chip in
                KSChip(
                    chip,
                    isSelected: Binding(
                        get: { selectedChips.contains(chip) },
                        set: { isSelected in
                            if isSelected {
                                if !allowMultiple {
                                    selectedChips.removeAll()
                                }
                                selectedChips.insert(chip)
                            } else {
                                selectedChips.remove(chip)
                            }
                        }
                    )
                )
            }
        }
    }
}

// MARK: - FlowLayout

public struct FlowLayout: Layout {
    var spacing: CGFloat = 8

    public init(spacing: CGFloat = 8) {
        self.spacing = spacing
    }

    public func sizeThatFits(
        proposal: ProposedViewSize,
        subviews: Subviews,
        cache: inout ()
    ) -> CGSize {
        let result = FlowResult(
            in: proposal.width ?? 0,
            spacing: spacing,
            subviews: subviews
        )
        return CGSize(width: proposal.width ?? 0, height: result.height)
    }

    public func placeSubviews(
        in bounds: CGRect,
        proposal: ProposedViewSize,
        subviews: Subviews,
        cache: inout ()
    ) {
        let result = FlowResult(
            in: bounds.width,
            spacing: spacing,
            subviews: subviews
        )
        for (index, subview) in subviews.enumerated() {
            subview.place(
                at: CGPoint(
                    x: bounds.minX + result.positions[index].x,
                    y: bounds.minY + result.positions[index].y
                ),
                proposal: .unspecified
            )
        }
    }

    struct FlowResult {
        var positions: [CGPoint] = []
        var height: CGFloat = 0

        init(in width: CGFloat, spacing: CGFloat, subviews: Subviews) {
            var xPosition: CGFloat = 0
            var yPosition: CGFloat = 0
            var rowHeight: CGFloat = 0

            for subview in subviews {
                let size = subview.sizeThatFits(.unspecified)

                if xPosition + size.width > width && xPosition > 0 {
                    xPosition = 0
                    yPosition += rowHeight + spacing
                    rowHeight = 0
                }

                positions.append(CGPoint(x: xPosition, y: yPosition))
                rowHeight = max(rowHeight, size.height)
                xPosition += size.width + spacing
            }

            height = yPosition + rowHeight
        }
    }
}

// MARK: - KSStatusBadge

public struct KSStatusBadge: View {
    let status: Status

    public enum Status {
        case active
        case inactive
        case pending
        case error

        var color: Color {
            switch self {
            case .active: KS.Colors.success
            case .inactive: KS.Colors.textTertiary
            case .pending: KS.Colors.warning
            case .error: KS.Colors.error
            }
        }

        var label: String {
            switch self {
            case .active: "Active"
            case .inactive: "Inactive"
            case .pending: "Pending"
            case .error: "Error"
            }
        }
    }

    public init(_ status: Status) {
        self.status = status
    }

    public var body: some View {
        HStack(spacing: KS.Spacing.xxs) {
            KSDot(color: status.color, size: 6)

            Text(status.label)
                .font(KS.Typography.labelSmall)
                .foregroundStyle(status.color)
        }
        .padding(.horizontal, KS.Spacing.sm)
        .padding(.vertical, KS.Spacing.xxs)
        .background(status.color.opacity(0.1))
        .clipShape(Capsule())
    }
}

