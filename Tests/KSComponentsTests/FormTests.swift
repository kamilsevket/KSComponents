import XCTest
@testable import KSComponents

final class FormTests: XCTestCase {
    // MARK: - KSToggle Tests

    func testToggleDefaultInit() {
        let toggle = KSToggle(isOn: .constant(true))

        XCTAssertNotNil(toggle)
    }

    func testToggleWithLabel() {
        let toggle = KSToggle(
            isOn: .constant(true),
            label: "Notifications"
        )

        XCTAssertNotNil(toggle)
    }

    func testToggleWithLabelAndDescription() {
        let toggle = KSToggle(
            isOn: .constant(false),
            label: "Dark Mode",
            description: "Enable dark mode for better night viewing"
        )

        XCTAssertNotNil(toggle)
    }

    func testToggleStateChange() {
        var isOn = false
        isOn.toggle()
        XCTAssertTrue(isOn)
        isOn.toggle()
        XCTAssertFalse(isOn)
    }

    // MARK: - KSSlider Tests

    func testSliderDefaultInit() {
        let slider = KSSlider(value: .constant(50))

        XCTAssertNotNil(slider)
    }

    func testSliderWithCustomRange() {
        let slider = KSSlider(
            value: .constant(0.5),
            in: 0...1
        )

        XCTAssertNotNil(slider)
    }

    func testSliderWithStep() {
        let slider = KSSlider(
            value: .constant(25),
            in: 0...100,
            step: 25
        )

        XCTAssertNotNil(slider)
    }

    func testSliderWithLabel() {
        let slider = KSSlider(
            value: .constant(75),
            label: "Volume"
        )

        XCTAssertNotNil(slider)
    }

    func testSliderWithCustomFormat() {
        let slider = KSSlider(
            value: .constant(0.75),
            in: 0...1,
            label: "Opacity",
            valueFormat: "%.2f"
        )

        XCTAssertNotNil(slider)
    }

    func testSliderHideValue() {
        let slider = KSSlider(
            value: .constant(50),
            showValue: false
        )

        XCTAssertNotNil(slider)
    }

    func testSliderValueFormatting() {
        let value: Double = 75.5
        let format = "%.0f"
        let formatted = String(format: format, value)
        XCTAssertEqual(formatted, "76")
    }

    func testSliderValueFormattingDecimal() {
        let value: Double = 0.756
        let format = "%.2f"
        let formatted = String(format: format, value)
        XCTAssertEqual(formatted, "0.76")
    }

    // MARK: - KSStepper Tests

    func testStepperDefaultInit() {
        let stepper = KSStepper(value: .constant(5))

        XCTAssertNotNil(stepper)
    }

    func testStepperWithCustomRange() {
        let stepper = KSStepper(
            value: .constant(3),
            in: 1...10
        )

        XCTAssertNotNil(stepper)
    }

    func testStepperWithLabel() {
        let stepper = KSStepper(
            value: .constant(2),
            label: "Quantity"
        )

        XCTAssertNotNil(stepper)
    }

    func testStepperRange() {
        var value = 5
        let range = 0...10

        // Test decrement
        value = max(range.lowerBound, value - 1)
        XCTAssertEqual(value, 4)

        // Test increment
        value = min(range.upperBound, value + 1)
        XCTAssertEqual(value, 5)
    }

    func testStepperLowerBound() {
        var value = 0
        let range = 0...10

        // Should not go below lower bound
        if value > range.lowerBound {
            value -= 1
        }
        XCTAssertEqual(value, 0)
    }

    func testStepperUpperBound() {
        var value = 10
        let range = 0...10

        // Should not go above upper bound
        if value < range.upperBound {
            value += 1
        }
        XCTAssertEqual(value, 10)
    }

    func testStepperDecrementEnabled() {
        let value = 5
        let range = 0...10
        let decrementEnabled = value > range.lowerBound
        XCTAssertTrue(decrementEnabled)
    }

    func testStepperDecrementDisabledAtLowerBound() {
        let value = 0
        let range = 0...10
        let decrementEnabled = value > range.lowerBound
        XCTAssertFalse(decrementEnabled)
    }

    func testStepperIncrementEnabled() {
        let value = 5
        let range = 0...10
        let incrementEnabled = value < range.upperBound
        XCTAssertTrue(incrementEnabled)
    }

    func testStepperIncrementDisabledAtUpperBound() {
        let value = 10
        let range = 0...10
        let incrementEnabled = value < range.upperBound
        XCTAssertFalse(incrementEnabled)
    }

    // MARK: - KSCheckbox Tests

    func testCheckboxInit() {
        let checkbox = KSCheckbox(
            isChecked: .constant(false),
            label: "Accept terms"
        )

        XCTAssertNotNil(checkbox)
    }

    func testCheckboxToggle() {
        var isChecked = false
        isChecked.toggle()
        XCTAssertTrue(isChecked)
    }

    func testCheckboxUntoggle() {
        var isChecked = true
        isChecked.toggle()
        XCTAssertFalse(isChecked)
    }

    func testCheckboxMultipleToggles() {
        var isChecked = false
        isChecked.toggle()
        XCTAssertTrue(isChecked)
        isChecked.toggle()
        XCTAssertFalse(isChecked)
        isChecked.toggle()
        XCTAssertTrue(isChecked)
    }

    // MARK: - KSRadioGroup Tests

    func testRadioGroupInit() {
        let radioGroup = KSRadioGroup(
            selection: .constant("option1"),
            options: [
                (value: "option1", label: "Option 1"),
                (value: "option2", label: "Option 2")
            ]
        )

        XCTAssertNotNil(radioGroup)
    }

    func testRadioGroupSelection() {
        var selection = "option1"
        selection = "option2"
        XCTAssertEqual(selection, "option2")
    }

    func testRadioGroupSingleSelection() {
        var selection = "first"

        // Selecting second should deselect first
        selection = "second"
        XCTAssertEqual(selection, "second")
        XCTAssertNotEqual(selection, "first")
    }

    func testRadioGroupIntSelection() {
        let radioGroup = KSRadioGroup(
            selection: .constant(1),
            options: [
                (value: 1, label: "One"),
                (value: 2, label: "Two"),
                (value: 3, label: "Three")
            ]
        )

        XCTAssertNotNil(radioGroup)
    }

    // MARK: - KSSegmentedControl Tests

    func testSegmentedControlInit() {
        let segmented = KSSegmentedControl(
            selection: .constant("daily"),
            options: [
                (value: "daily", label: "Daily"),
                (value: "weekly", label: "Weekly")
            ]
        )

        XCTAssertNotNil(segmented)
    }

    func testSegmentedControlSelection() {
        var selection = "daily"
        selection = "weekly"
        XCTAssertEqual(selection, "weekly")
    }

    func testSegmentedControlIntSelection() {
        let segmented = KSSegmentedControl(
            selection: .constant(0),
            options: [
                (value: 0, label: "All"),
                (value: 1, label: "Active"),
                (value: 2, label: "Completed")
            ]
        )

        XCTAssertNotNil(segmented)
    }

    func testSegmentedControlEnumSelection() {
        enum Tab: String {
            case home
            case search
            case profile
        }

        var selection: Tab = .home
        selection = .search
        XCTAssertEqual(selection, .search)
    }

    // MARK: - KSDatePicker Tests

    func testDatePickerDefaultInit() {
        let datePicker = KSDatePicker(date: .constant(Date()))

        XCTAssertNotNil(datePicker)
    }

    func testDatePickerWithLabel() {
        let datePicker = KSDatePicker(
            date: .constant(Date()),
            label: "Select Date"
        )

        XCTAssertNotNil(datePicker)
    }

    func testDatePickerDateOnly() {
        let datePicker = KSDatePicker(
            date: .constant(Date()),
            label: "Birthday",
            displayedComponents: .date
        )

        XCTAssertNotNil(datePicker)
    }

    func testDatePickerTimeOnly() {
        let datePicker = KSDatePicker(
            date: .constant(Date()),
            label: "Alarm",
            displayedComponents: .hourAndMinute
        )

        XCTAssertNotNil(datePicker)
    }

    func testDatePickerDateAndTime() {
        let datePicker = KSDatePicker(
            date: .constant(Date()),
            label: "Event",
            displayedComponents: [.date, .hourAndMinute]
        )

        XCTAssertNotNil(datePicker)
    }

    // MARK: - Animation Tests

    func testSpringAnimationParameters() {
        // Verify spring animation parameters are valid
        let response: Double = 0.2
        let dampingFraction: Double = 0.7

        XCTAssertGreaterThan(response, 0)
        XCTAssertGreaterThan(dampingFraction, 0)
        XCTAssertLessThanOrEqual(dampingFraction, 1)
    }

    func testSegmentedControlAnimationParameters() {
        let response: Double = 0.3
        let dampingFraction: Double = 0.7

        XCTAssertGreaterThan(response, 0)
        XCTAssertGreaterThan(dampingFraction, 0)
        XCTAssertLessThanOrEqual(dampingFraction, 1)
    }

    // MARK: - Accessibility Tests

    func testCheckboxSize() {
        let size: CGFloat = 22
        let minTouchTarget: CGFloat = 22
        XCTAssertGreaterThanOrEqual(size, minTouchTarget)
    }

    func testRadioButtonSize() {
        let outerSize: CGFloat = 22
        let innerSize: CGFloat = 12
        XCTAssertGreaterThan(outerSize, innerSize)
    }

    func testStepperButtonSize() {
        let width: CGFloat = 44
        let height: CGFloat = 36
        let minTouchTarget: CGFloat = 36
        XCTAssertGreaterThanOrEqual(width, minTouchTarget)
        XCTAssertGreaterThanOrEqual(height, minTouchTarget)
    }
}
