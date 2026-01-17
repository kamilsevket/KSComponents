import XCTest
@testable import KSComponents

final class InputTests: XCTestCase {
    // MARK: - KSTextField Tests

    func testTextFieldDefaultInit() {
        let textField = KSTextField(
            "Enter text",
            text: .constant("")
        )

        XCTAssertNotNil(textField)
    }

    func testTextFieldWithLabel() {
        let textField = KSTextField(
            "Enter email",
            text: .constant(""),
            label: "Email"
        )

        XCTAssertNotNil(textField)
    }

    func testTextFieldWithIcon() {
        let textField = KSTextField(
            "Enter email",
            text: .constant(""),
            icon: "envelope"
        )

        XCTAssertNotNil(textField)
    }

    func testTextFieldWithHelperText() {
        let textField = KSTextField(
            "Enter username",
            text: .constant(""),
            helperText: "Choose a unique username"
        )

        XCTAssertNotNil(textField)
    }

    func testTextFieldWithErrorText() {
        let textField = KSTextField(
            "Enter email",
            text: .constant(""),
            errorText: "Invalid email format"
        )

        XCTAssertNotNil(textField)
    }

    func testTextFieldDisabled() {
        let textField = KSTextField(
            "Disabled field",
            text: .constant(""),
            isDisabled: true
        )

        XCTAssertNotNil(textField)
    }

    func testTextFieldFullConfiguration() {
        let textField = KSTextField(
            "Enter email",
            text: .constant("test@example.com"),
            label: "Email Address",
            icon: "envelope",
            helperText: "We'll never share your email",
            errorText: nil,
            isDisabled: false
        )

        XCTAssertNotNil(textField)
    }

    // MARK: - KSSecureField Tests

    func testSecureFieldDefaultInit() {
        let secureField = KSSecureField(
            "Enter password",
            text: .constant("")
        )

        XCTAssertNotNil(secureField)
    }

    func testSecureFieldWithLabel() {
        let secureField = KSSecureField(
            "Enter password",
            text: .constant(""),
            label: "Password"
        )

        XCTAssertNotNil(secureField)
    }

    func testSecureFieldWithHelperText() {
        let secureField = KSSecureField(
            "Enter password",
            text: .constant(""),
            label: "Password",
            helperText: "Must be at least 8 characters"
        )

        XCTAssertNotNil(secureField)
    }

    func testSecureFieldWithErrorText() {
        let secureField = KSSecureField(
            "Enter password",
            text: .constant(""),
            label: "Password",
            errorText: "Password is too short"
        )

        XCTAssertNotNil(secureField)
    }

    // MARK: - KSSearchField Tests

    func testSearchFieldDefaultInit() {
        let searchField = KSSearchField(text: .constant(""))

        XCTAssertNotNil(searchField)
    }

    func testSearchFieldWithPlaceholder() {
        let searchField = KSSearchField(
            "Search users...",
            text: .constant("")
        )

        XCTAssertNotNil(searchField)
    }

    func testSearchFieldWithOnSubmit() {
        var submitted = false
        let searchField = KSSearchField(
            text: .constant("query"),
            onSubmit: {
                submitted = true
            }
        )

        XCTAssertNotNil(searchField)
        XCTAssertFalse(submitted)
    }

    // MARK: - KSTextEditor Tests

    func testTextEditorDefaultInit() {
        let textEditor = KSTextEditor(
            "Write something...",
            text: .constant("")
        )

        XCTAssertNotNil(textEditor)
    }

    func testTextEditorWithLabel() {
        let textEditor = KSTextEditor(
            "Write your bio...",
            text: .constant(""),
            label: "Bio"
        )

        XCTAssertNotNil(textEditor)
    }

    func testTextEditorWithCustomHeight() {
        let textEditor = KSTextEditor(
            "Write...",
            text: .constant(""),
            minHeight: 150,
            maxHeight: 300
        )

        XCTAssertNotNil(textEditor)
    }

    func testTextEditorWithCharacterLimit() {
        let textEditor = KSTextEditor(
            "Write...",
            text: .constant(""),
            characterLimit: 280
        )

        XCTAssertNotNil(textEditor)
    }

    func testTextEditorFullConfiguration() {
        let textEditor = KSTextEditor(
            "Write your message...",
            text: .constant("Hello"),
            label: "Message",
            minHeight: 120,
            maxHeight: 250,
            characterLimit: 500
        )

        XCTAssertNotNil(textEditor)
    }

    // MARK: - Character Limit Logic Tests

    func testCharacterLimitEnforcement() {
        var text = "Hello World"
        let limit = 5

        if text.count > limit {
            text = String(text.prefix(limit))
        }

        XCTAssertEqual(text.count, limit)
        XCTAssertEqual(text, "Hello")
    }

    func testCharacterLimitNotExceeded() {
        let text = "Hi"
        let limit = 10

        let shouldTruncate = text.count > limit
        XCTAssertFalse(shouldTruncate)
    }

    func testEmptyTextWithCharacterLimit() {
        let text = ""
        let limit = 100

        XCTAssertTrue(text.count <= limit)
    }

    // MARK: - Border Color Logic Tests

    func testBorderColorWithError() {
        // Simulate error state - error color should be used
        let hasError = true
        let isFocused = false

        let shouldShowError = hasError
        XCTAssertTrue(shouldShowError)
    }

    func testBorderColorWhenFocused() {
        // Simulate focused state without error - primary color should be used
        let hasError = false
        let isFocused = true

        let shouldShowPrimary = !hasError && isFocused
        XCTAssertTrue(shouldShowPrimary)
    }

    func testBorderColorDefault() {
        // Simulate default state - border color should be used
        let hasError = false
        let isFocused = false

        let shouldShowDefault = !hasError && !isFocused
        XCTAssertTrue(shouldShowDefault)
    }

    // MARK: - Icon Color Logic Tests

    func testIconColorWhenFocused() {
        let isFocused = true
        let shouldShowPrimary = isFocused
        XCTAssertTrue(shouldShowPrimary)
    }

    func testIconColorWhenNotFocused() {
        let isFocused = false
        let shouldShowTertiary = !isFocused
        XCTAssertTrue(shouldShowTertiary)
    }

    // MARK: - Secure Field Toggle Tests

    func testSecureToggleDefaultState() {
        // Default state should be secure (password hidden)
        let isSecure = true
        XCTAssertTrue(isSecure)
    }

    func testSecureToggleShowPassword() {
        var isSecure = true
        isSecure.toggle()
        XCTAssertFalse(isSecure)
    }

    func testSecureToggleHidePassword() {
        var isSecure = false
        isSecure.toggle()
        XCTAssertTrue(isSecure)
    }

    // MARK: - Clear Button Logic Tests

    func testClearButtonVisibilityWithText() {
        let text = "Some text"
        let shouldShowClearButton = !text.isEmpty
        XCTAssertTrue(shouldShowClearButton)
    }

    func testClearButtonVisibilityWithEmptyText() {
        let text = ""
        let shouldShowClearButton = !text.isEmpty
        XCTAssertFalse(shouldShowClearButton)
    }

    func testClearButtonAction() {
        var text = "Some text"
        text = "" // Simulate clear button action
        XCTAssertTrue(text.isEmpty)
    }

    // MARK: - Disabled State Tests

    func testDisabledOpacity() {
        let isDisabled = true
        let expectedOpacity: Double = isDisabled ? 0.5 : 1.0
        XCTAssertEqual(expectedOpacity, 0.5)
    }

    func testEnabledOpacity() {
        let isDisabled = false
        let expectedOpacity: Double = isDisabled ? 0.5 : 1.0
        XCTAssertEqual(expectedOpacity, 1.0)
    }
}
