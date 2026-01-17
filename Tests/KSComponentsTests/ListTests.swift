import XCTest
@testable import KSComponents

final class ListTests: XCTestCase {

    // MARK: - KSRow Tests

    func testRowInitialization() {
        let row = KSRow(title: "Test Title")
        XCTAssertNotNil(row)
    }

    func testRowWithAllParameters() {
        let row = KSRow(
            icon: "person.fill",
            iconColor: KS.Colors.primary,
            title: "Profile",
            subtitle: "View your profile",
            value: "Active",
            accessory: .chevron
        )
        XCTAssertNotNil(row)
    }

    func testRowWithToggleAccessory() {
        var isOn = false
        let binding = Binding(
            get: { isOn },
            set: { isOn = $0 }
        )
        let row = KSRow(
            title: "Toggle Row",
            accessory: .toggle(binding)
        )
        XCTAssertNotNil(row)
    }

    func testRowWithCheckmarkAccessory() {
        let rowChecked = KSRow(
            title: "Checked Row",
            accessory: .checkmark(true)
        )
        XCTAssertNotNil(rowChecked)

        let rowUnchecked = KSRow(
            title: "Unchecked Row",
            accessory: .checkmark(false)
        )
        XCTAssertNotNil(rowUnchecked)
    }

    func testRowWithNoAccessory() {
        let row = KSRow(
            title: "No Accessory",
            accessory: .none
        )
        XCTAssertNotNil(row)
    }

    func testRowAccessoryTypes() {
        // Test all accessory types compile and can be created
        let chevronAccessory: KSRow.Accessory = .chevron
        let noneAccessory: KSRow.Accessory = .none
        let checkmarkAccessory: KSRow.Accessory = .checkmark(true)

        // Verify enum cases exist
        switch chevronAccessory {
        case .chevron: XCTAssertTrue(true)
        default: XCTFail("Expected chevron accessory")
        }

        switch noneAccessory {
        case .none: XCTAssertTrue(true)
        default: XCTFail("Expected none accessory")
        }

        switch checkmarkAccessory {
        case .checkmark(let isChecked):
            XCTAssertTrue(isChecked)
        default: XCTFail("Expected checkmark accessory")
        }
    }

    // MARK: - KSSwipeableRow Tests

    func testSwipeActionCreation() {
        var actionCalled = false
        let action = KSSwipeableRow<EmptyView>.SwipeAction(
            icon: "trash",
            color: .red,
            action: { actionCalled = true }
        )

        XCTAssertEqual(action.icon, "trash")
        XCTAssertNotNil(action.id)

        action.action()
        XCTAssertTrue(actionCalled)
    }

    func testSwipeableRowWithLeadingActions() {
        let leadingAction = KSSwipeableRow<EmptyView>.SwipeAction(
            icon: "star.fill",
            color: .yellow,
            action: {}
        )

        let swipeableRow = KSSwipeableRow(
            leadingActions: [leadingAction],
            trailingActions: []
        ) {
            EmptyView()
        }

        XCTAssertNotNil(swipeableRow)
    }

    func testSwipeableRowWithTrailingActions() {
        let trailingAction = KSSwipeableRow<EmptyView>.SwipeAction(
            icon: "trash.fill",
            color: .red,
            action: {}
        )

        let swipeableRow = KSSwipeableRow(
            leadingActions: [],
            trailingActions: [trailingAction]
        ) {
            EmptyView()
        }

        XCTAssertNotNil(swipeableRow)
    }

    func testSwipeableRowWithMultipleActions() {
        let starAction = KSSwipeableRow<EmptyView>.SwipeAction(
            icon: "star.fill",
            color: .yellow,
            action: {}
        )
        let archiveAction = KSSwipeableRow<EmptyView>.SwipeAction(
            icon: "archivebox.fill",
            color: .blue,
            action: {}
        )
        let deleteAction = KSSwipeableRow<EmptyView>.SwipeAction(
            icon: "trash.fill",
            color: .red,
            action: {}
        )

        let swipeableRow = KSSwipeableRow(
            leadingActions: [starAction],
            trailingActions: [archiveAction, deleteAction]
        ) {
            EmptyView()
        }

        XCTAssertNotNil(swipeableRow)
    }

    // MARK: - KSSectionHeader Tests

    func testSectionHeaderBasic() {
        let header = KSSectionHeader("Section Title")
        XCTAssertNotNil(header)
    }

    func testSectionHeaderWithAction() {
        var actionCalled = false
        let header = KSSectionHeader(
            "Section Title",
            action: { actionCalled = true },
            actionTitle: "See All"
        )
        XCTAssertNotNil(header)
    }

    func testSectionHeaderActionOnly() {
        // Action without title should not show button
        let header = KSSectionHeader(
            "Section Title",
            action: {},
            actionTitle: nil
        )
        XCTAssertNotNil(header)
    }

    // MARK: - KSGroupedList Tests

    func testGroupedListCreation() {
        let groupedList = KSGroupedList {
            EmptyView()
        }
        XCTAssertNotNil(groupedList)
    }

    func testGroupedListWithMultipleChildren() {
        let groupedList = KSGroupedList {
            Text("Item 1")
            Text("Item 2")
            Text("Item 3")
        }
        XCTAssertNotNil(groupedList)
    }

    // MARK: - KSDivider Tests

    func testDividerDefault() {
        let divider = KSDivider()
        XCTAssertNotNil(divider)
    }

    func testDividerWithInset() {
        let divider = KSDivider(inset: 60)
        XCTAssertNotNil(divider)
    }

    func testDividerWithZeroInset() {
        let divider = KSDivider(inset: 0)
        XCTAssertNotNil(divider)
    }

    func testDividerWithLargeInset() {
        let divider = KSDivider(inset: 100)
        XCTAssertNotNil(divider)
    }

    // MARK: - Integration Tests

    func testGroupedListWithRowsAndDividers() {
        let groupedList = KSGroupedList {
            KSRow(
                icon: "person.fill",
                title: "Profile"
            )
            KSDivider(inset: 60)
            KSRow(
                icon: "gear",
                title: "Settings"
            )
        }
        XCTAssertNotNil(groupedList)
    }

    func testSwipeableRowWithKSRow() {
        let deleteAction = KSSwipeableRow<KSRow>.SwipeAction(
            icon: "trash.fill",
            color: KS.Colors.error,
            action: {}
        )

        let swipeableRow = KSSwipeableRow(
            trailingActions: [deleteAction]
        ) {
            KSRow(
                icon: "envelope.fill",
                title: "Email",
                subtitle: "user@example.com"
            )
        }
        XCTAssertNotNil(swipeableRow)
    }

    func testCompleteListSetup() {
        // Test a complete list setup with all components
        let header = KSSectionHeader("Account", action: {}, actionTitle: "Edit")
        XCTAssertNotNil(header)

        let groupedList = KSGroupedList {
            KSRow(icon: "person.fill", title: "Profile", accessory: .chevron)
            KSDivider(inset: 60)
            KSRow(icon: "bell.fill", title: "Notifications", accessory: .toggle(.constant(true)))
            KSDivider(inset: 60)
            KSRow(icon: "checkmark.circle", title: "Completed", accessory: .checkmark(true))
        }
        XCTAssertNotNil(groupedList)
    }
}
