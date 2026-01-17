import SwiftUI

public struct KSSlider: View {
    @Binding var value: Double
    let range: ClosedRange<Double>
    let step: Double?
    let label: String?
    let showValue: Bool
    let valueFormat: String

    public init(
        value: Binding<Double>,
        in range: ClosedRange<Double> = 0...100,
        step: Double? = nil,
        label: String? = nil,
        showValue: Bool = true,
        valueFormat: String = "%.0f"
    ) {
        self._value = value
        self.range = range
        self.step = step
        self.label = label
        self.showValue = showValue
        self.valueFormat = valueFormat
    }

    public var body: some View {
        VStack(alignment: .leading, spacing: KS.Spacing.sm) {
            if label != nil || showValue {
                HStack {
                    if let label {
                        Text(label)
                            .font(KS.Typography.labelMedium)
                            .foregroundStyle(KS.Colors.textPrimary)
                    }
                    Spacer()
                    if showValue {
                        Text(String(format: valueFormat, value))
                            .font(KS.Typography.labelMedium)
                            .foregroundStyle(KS.Colors.primary)
                    }
                }
            }

            if let step {
                Slider(value: $value, in: range, step: step)
                    .tint(KS.Colors.primary)
            } else {
                Slider(value: $value, in: range)
                    .tint(KS.Colors.primary)
            }
        }
    }
}

#Preview {
    VStack(spacing: 30) {
        KSSlider(value: .constant(50), label: "Volume")
        KSSlider(value: .constant(75), in: 0...100, step: 25, label: "Brightness")
        KSSlider(value: .constant(0.5), in: 0...1, label: "Opacity", valueFormat: "%.2f")
    }
    .padding()
}
