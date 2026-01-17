import SwiftUI

public struct KSStepper: View {
    @Binding var value: Int
    let range: ClosedRange<Int>
    let label: String?

    public init(
        value: Binding<Int>,
        in range: ClosedRange<Int> = 0...100,
        label: String? = nil
    ) {
        self._value = value
        self.range = range
        self.label = label
    }

    public var body: some View {
        HStack {
            if let label {
                Text(label)
                    .font(KS.Typography.bodyLarge)
                    .foregroundStyle(KS.Colors.textPrimary)
                Spacer()
            }

            HStack(spacing: 0) {
                Button {
                    if value > range.lowerBound {
                        value -= 1
                    }
                } label: {
                    Image(systemName: "minus")
                        .font(.body.weight(.semibold))
                        .foregroundStyle(value > range.lowerBound ? KS.Colors.primary : KS.Colors.textTertiary)
                        .frame(width: 44, height: 36)
                }
                .disabled(value <= range.lowerBound)

                Text("\(value)")
                    .font(KS.Typography.titleSmall)
                    .foregroundStyle(KS.Colors.textPrimary)
                    .frame(minWidth: 44)

                Button {
                    if value < range.upperBound {
                        value += 1
                    }
                } label: {
                    Image(systemName: "plus")
                        .font(.body.weight(.semibold))
                        .foregroundStyle(value < range.upperBound ? KS.Colors.primary : KS.Colors.textTertiary)
                        .frame(width: 44, height: 36)
                }
                .disabled(value >= range.upperBound)
            }
            .background(KS.Colors.surface)
            .clipShape(RoundedRectangle(cornerRadius: KS.Radius.sm))
            .overlay(
                RoundedRectangle(cornerRadius: KS.Radius.sm)
                    .stroke(KS.Colors.border, lineWidth: 1)
            )
        }
    }
}

#Preview {
    VStack(spacing: 20) {
        KSStepper(value: .constant(5), in: 0...10, label: "Quantity")
        KSStepper(value: .constant(0), in: 0...100)
        KSStepper(value: .constant(10), in: 0...10, label: "At maximum")
    }
    .padding()
}
