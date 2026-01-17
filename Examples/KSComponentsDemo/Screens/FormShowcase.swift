import SwiftUI
import KSComponents

struct FormShowcase: View {
    @State private var toggleValue = true
    @State private var checkboxValue = false
    @State private var sliderValue: Double = 0.5
    @State private var stepperValue = 5
    @State private var selectedOption = "Option 1"
    @State private var selectedSegment = "daily"
    @State private var selectedDate = Date()

    var body: some View {
        ScrollView {
            VStack(spacing: KS.Spacing.xl) {
                ShowcaseSection("Toggle", description: "On/off switch control") {
                    VStack(spacing: KS.Spacing.md) {
                        KSToggle(
                            isOn: $toggleValue,
                            label: "Notifications",
                            description: "Enable push notifications"
                        )

                        KSToggle(
                            isOn: $toggleValue,
                            label: "Dark Mode"
                        )

                        KSToggle(isOn: $toggleValue)
                    }
                }

                ShowcaseSection("Checkbox", description: "Checkable option with label") {
                    VStack(alignment: .leading, spacing: KS.Spacing.md) {
                        KSCheckbox(
                            isChecked: $checkboxValue,
                            label: "I agree to the terms and conditions"
                        )

                        KSCheckbox(
                            isChecked: .constant(true),
                            label: "Already checked"
                        )

                        KSCheckbox(
                            isChecked: .constant(false),
                            label: "Unchecked item"
                        )
                    }
                }

                ShowcaseSection("Radio Group", description: "Single selection from options") {
                    KSRadioGroup(
                        selection: $selectedOption,
                        options: [
                            (value: "Option 1", label: "Option 1"),
                            (value: "Option 2", label: "Option 2"),
                            (value: "Option 3", label: "Option 3")
                        ]
                    )
                }

                ShowcaseSection("Segmented Control", description: "Horizontal segment picker") {
                    VStack(spacing: KS.Spacing.md) {
                        KSSegmentedControl(
                            selection: $selectedSegment,
                            options: [
                                (value: "daily", label: "Daily"),
                                (value: "weekly", label: "Weekly"),
                                (value: "monthly", label: "Monthly")
                            ]
                        )

                        Text("Selected: \(selectedSegment)")
                            .font(KS.Typography.bodySmall)
                            .foregroundStyle(KS.Colors.textSecondary)
                    }
                }

                ShowcaseSection("Slider", description: "Value range selection") {
                    VStack(spacing: KS.Spacing.md) {
                        KSSlider(
                            value: $sliderValue,
                            label: "Volume",
                            showValue: true
                        )

                        KSSlider(
                            value: $sliderValue,
                            in: 0...1,
                            label: "Opacity",
                            showValue: true,
                            valueFormat: "%.2f"
                        )
                    }
                }

                ShowcaseSection("Stepper", description: "Increment/decrement control") {
                    VStack(spacing: KS.Spacing.md) {
                        KSStepper(
                            value: $stepperValue,
                            label: "Quantity"
                        )

                        KSStepper(
                            value: $stepperValue,
                            in: 0...10,
                            label: "Limited (0-10)"
                        )
                    }
                }

                ShowcaseSection("Date Picker", description: "Date selection control") {
                    KSDatePicker(
                        date: $selectedDate,
                        label: "Select Date"
                    )
                }
            }
            .padding()
        }
        .background(KS.Colors.background)
        .navigationTitle("Forms")
    }
}

#Preview {
    NavigationStack {
        FormShowcase()
    }
}
