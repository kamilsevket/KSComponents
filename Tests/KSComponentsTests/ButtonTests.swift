import XCTest
@testable import KSComponents

final class ButtonTests: XCTestCase {
    // MARK: - Size Tests

    func testButtonSizes() {
        XCTAssertEqual(KSButton.Size.small.height, 36)
        XCTAssertEqual(KSButton.Size.medium.height, 44)
        XCTAssertEqual(KSButton.Size.large.height, 56)
    }

    func testButtonSizePadding() {
        XCTAssertEqual(KSButton.Size.small.padding, KS.Spacing.sm)
        XCTAssertEqual(KSButton.Size.medium.padding, KS.Spacing.md)
        XCTAssertEqual(KSButton.Size.large.padding, KS.Spacing.lg)
    }

    func testButtonSizeFont() {
        XCTAssertNotNil(KSButton.Size.small.font)
        XCTAssertNotNil(KSButton.Size.medium.font)
        XCTAssertNotNil(KSButton.Size.large.font)
    }

    // MARK: - Style Tests

    func testButtonStyles() {
        let styles: [KSButton.Style] = [.primary, .secondary, .ghost, .destructive, .success]
        XCTAssertEqual(styles.count, 5)
    }

    // MARK: - Icon Position Tests

    func testIconPositions() {
        let positions: [KSButton.IconPosition] = [.leading, .trailing]
        XCTAssertEqual(positions.count, 2)
    }

    // MARK: - Initialization Tests

    func testKSButtonDefaultInit() {
        var actionCalled = false
        let button = KSButton("Test") {
            actionCalled = true
        }

        XCTAssertEqual(button.title, "Test")
        XCTAssertFalse(actionCalled)
    }

    func testKSButtonCustomInit() {
        let button = KSButton(
            "Custom",
            style: .destructive,
            size: .large,
            icon: "trash",
            iconPosition: .trailing,
            isLoading: true,
            isFullWidth: true
        ) {}

        XCTAssertEqual(button.title, "Custom")
        XCTAssertEqual(button.icon, "trash")
        XCTAssertTrue(button.isLoading)
        XCTAssertTrue(button.isFullWidth)
    }

    func testKSIconButtonDefaultInit() {
        let button = KSIconButton(icon: "heart") {}
        XCTAssertEqual(button.icon, "heart")
    }

    func testKSIconButtonCustomInit() {
        let button = KSIconButton(
            icon: "star",
            size: .large,
            style: .primary
        ) {}

        XCTAssertEqual(button.icon, "star")
    }

    func testKSFloatingButtonDefaultInit() {
        let button = KSFloatingButton {}
        XCTAssertEqual(button.icon, "plus")
    }

    func testKSFloatingButtonCustomInit() {
        let button = KSFloatingButton(icon: "pencil") {}
        XCTAssertEqual(button.icon, "pencil")
    }

    // MARK: - Button Style Tests

    func testKSButtonStyleExists() {
        let style = KSButtonStyle()
        XCTAssertNotNil(style)
    }
}
