import XCTest
@testable import KSComponents

final class BadgeTests: XCTestCase {

    // MARK: - KSBadge Tests

    func testBadgeMaxCount() {
        let count = 150
        let maxCount = 99
        let display = count > maxCount ? "\(maxCount)+" : "\(count)"
        XCTAssertEqual(display, "99+")
    }

    func testBadgeCountUnderMax() {
        let count = 50
        let maxCount = 99
        let display = count > maxCount ? "\(maxCount)+" : "\(count)"
        XCTAssertEqual(display, "50")
    }

    func testBadgeCountAtMax() {
        let count = 99
        let maxCount = 99
        let display = count > maxCount ? "\(maxCount)+" : "\(count)"
        XCTAssertEqual(display, "99")
    }

    func testBadgeCountJustOverMax() {
        let count = 100
        let maxCount = 99
        let display = count > maxCount ? "\(maxCount)+" : "\(count)"
        XCTAssertEqual(display, "99+")
    }

    func testBadgeSizeDimensions() {
        XCTAssertEqual(KSBadge.Size.small.dimension, 18)
        XCTAssertEqual(KSBadge.Size.medium.dimension, 24)
    }

    func testBadgeInitializationDefaults() {
        let badge = KSBadge(count: 5)
        XCTAssertEqual(badge.count, 5)
        XCTAssertEqual(badge.maxCount, 99)
        XCTAssertEqual(badge.size, .medium)
    }

    func testBadgeInitializationCustomValues() {
        let badge = KSBadge(count: 10, maxCount: 50, size: .small)
        XCTAssertEqual(badge.count, 10)
        XCTAssertEqual(badge.maxCount, 50)
        XCTAssertEqual(badge.size, .small)
    }

    // MARK: - KSStatusBadge Tests

    func testStatusBadgeActiveLabel() {
        XCTAssertEqual(KSStatusBadge.Status.active.label, "Active")
    }

    func testStatusBadgeInactiveLabel() {
        XCTAssertEqual(KSStatusBadge.Status.inactive.label, "Inactive")
    }

    func testStatusBadgePendingLabel() {
        XCTAssertEqual(KSStatusBadge.Status.pending.label, "Pending")
    }

    func testStatusBadgeErrorLabel() {
        XCTAssertEqual(KSStatusBadge.Status.error.label, "Error")
    }

    func testStatusBadgeColors() {
        XCTAssertEqual(KSStatusBadge.Status.active.color, KS.Colors.success)
        XCTAssertEqual(KSStatusBadge.Status.inactive.color, KS.Colors.textTertiary)
        XCTAssertEqual(KSStatusBadge.Status.pending.color, KS.Colors.warning)
        XCTAssertEqual(KSStatusBadge.Status.error.color, KS.Colors.error)
    }

    // MARK: - KSDot Tests

    func testDotInitializationDefaults() {
        let dot = KSDot()
        XCTAssertEqual(dot.color, KS.Colors.success)
        XCTAssertEqual(dot.size, 8)
        XCTAssertFalse(dot.isPulsing)
    }

    func testDotInitializationCustomValues() {
        let dot = KSDot(color: KS.Colors.error, size: 12, isPulsing: true)
        XCTAssertEqual(dot.color, KS.Colors.error)
        XCTAssertEqual(dot.size, 12)
        XCTAssertTrue(dot.isPulsing)
    }

    // MARK: - KSTag Tests

    func testTagInitializationDefaults() {
        let tag = KSTag("Swift")
        XCTAssertEqual(tag.text, "Swift")
        XCTAssertNil(tag.icon)
        XCTAssertFalse(tag.isRemovable)
        XCTAssertNil(tag.onRemove)
    }

    func testTagInitializationWithIcon() {
        let tag = KSTag("iOS", icon: "apple.logo")
        XCTAssertEqual(tag.text, "iOS")
        XCTAssertEqual(tag.icon, "apple.logo")
    }

    func testTagInitializationRemovable() {
        var removeWasCalled = false
        let tag = KSTag("Test", isRemovable: true) {
            removeWasCalled = true
        }
        XCTAssertTrue(tag.isRemovable)
        XCTAssertNotNil(tag.onRemove)
        tag.onRemove?()
        XCTAssertTrue(removeWasCalled)
    }

    // MARK: - KSChip Tests

    func testChipInitialization() {
        var isSelected = false
        _ = KSChip("Option", isSelected: .constant(false))
        XCTAssertFalse(isSelected)
    }

    func testChipWithIcon() {
        let chip = KSChip("Starred", icon: "star.fill", isSelected: .constant(true))
        XCTAssertEqual(chip.text, "Starred")
        XCTAssertEqual(chip.icon, "star.fill")
    }

    // MARK: - KSChipGroup Tests

    func testChipGroupInitialization() {
        var selectedChips: Set<String> = ["Swift"]
        let chips = ["Swift", "SwiftUI", "Combine"]
        let group = KSChipGroup(
            chips: chips,
            selectedChips: .constant(selectedChips),
            allowMultiple: true
        )
        XCTAssertEqual(group.chips.count, 3)
        XCTAssertTrue(group.allowMultiple)
    }

    func testChipGroupSingleSelect() {
        let selectedChips: Set<String> = []
        let group = KSChipGroup(
            chips: ["A", "B", "C"],
            selectedChips: .constant(selectedChips),
            allowMultiple: false
        )
        XCTAssertFalse(group.allowMultiple)
    }

    // MARK: - FlowLayout Tests

    func testFlowLayoutInitialization() {
        let layout = FlowLayout(spacing: 16)
        XCTAssertEqual(layout.spacing, 16)
    }

    func testFlowLayoutDefaultSpacing() {
        let layout = FlowLayout()
        XCTAssertEqual(layout.spacing, 8)
    }
}
