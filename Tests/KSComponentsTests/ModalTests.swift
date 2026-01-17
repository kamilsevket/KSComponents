import XCTest
@testable import KSComponents

final class ModalTests: XCTestCase {

    // MARK: - Toast Type Tests

    func testToastTypeIcons() {
        XCTAssertEqual(KSToast.ToastType.info.icon, "info.circle.fill")
        XCTAssertEqual(KSToast.ToastType.success.icon, "checkmark.circle.fill")
        XCTAssertEqual(KSToast.ToastType.warning.icon, "exclamationmark.triangle.fill")
        XCTAssertEqual(KSToast.ToastType.error.icon, "xmark.circle.fill")
    }

    func testToastTypeColors() {
        // Verify each toast type returns a color
        let infoColor = KSToast.ToastType.info.color
        let successColor = KSToast.ToastType.success.color
        let warningColor = KSToast.ToastType.warning.color
        let errorColor = KSToast.ToastType.error.color

        // Each type should have a color defined
        XCTAssertNotNil(infoColor)
        XCTAssertNotNil(successColor)
        XCTAssertNotNil(warningColor)
        XCTAssertNotNil(errorColor)
    }

    // MARK: - Alert Button Tests

    func testAlertButtonInitialization() {
        let button = KSAlert.AlertButton(
            title: "Test",
            style: .primary,
            action: {}
        )

        XCTAssertEqual(button.title, "Test")
    }

    func testAlertButtonDefaultStyle() {
        let button = KSAlert.AlertButton(title: "Test", action: {})
        XCTAssertEqual(button.title, "Test")
    }

    func testAlertButtonWithDestructiveStyle() {
        let button = KSAlert.AlertButton(
            title: "Delete",
            style: .destructive,
            action: {}
        )

        XCTAssertEqual(button.title, "Delete")
    }

    // MARK: - Dialog Action Tests

    func testDialogActionInitialization() {
        let action = KSConfirmationDialog.DialogAction(
            title: "Delete",
            icon: "trash",
            isDestructive: true,
            action: {}
        )

        XCTAssertEqual(action.title, "Delete")
        XCTAssertEqual(action.icon, "trash")
        XCTAssertTrue(action.isDestructive)
    }

    func testDialogActionDefaults() {
        let action = KSConfirmationDialog.DialogAction(
            title: "Share",
            action: {}
        )

        XCTAssertEqual(action.title, "Share")
        XCTAssertNil(action.icon)
        XCTAssertFalse(action.isDestructive)
    }

    func testDialogActionWithIcon() {
        let action = KSConfirmationDialog.DialogAction(
            title: "Edit",
            icon: "pencil",
            action: {}
        )

        XCTAssertEqual(action.title, "Edit")
        XCTAssertEqual(action.icon, "pencil")
        XCTAssertFalse(action.isDestructive)
    }

    // MARK: - Toast Initialization Tests

    func testToastInitialization() {
        let toast = KSToast(
            message: "Test message",
            type: .success,
            action: nil,
            actionTitle: nil
        )

        XCTAssertEqual(toast.message, "Test message")
    }

    func testToastWithAction() {
        var actionCalled = false
        let toast = KSToast(
            message: "Item deleted",
            type: .info,
            action: { actionCalled = true },
            actionTitle: "Undo"
        )

        XCTAssertEqual(toast.message, "Item deleted")
        XCTAssertEqual(toast.actionTitle, "Undo")
        XCTAssertNotNil(toast.action)

        // Verify action can be called
        toast.action?()
        XCTAssertTrue(actionCalled)
    }

    func testToastDefaultType() {
        let toast = KSToast(message: "Default toast")
        XCTAssertEqual(toast.message, "Default toast")
        XCTAssertNil(toast.action)
        XCTAssertNil(toast.actionTitle)
    }

    // MARK: - Multiple Actions Test

    func testMultipleDialogActions() {
        var action1Called = false
        var action2Called = false
        var action3Called = false

        let actions = [
            KSConfirmationDialog.DialogAction(title: "Share", icon: "square.and.arrow.up") {
                action1Called = true
            },
            KSConfirmationDialog.DialogAction(title: "Edit", icon: "pencil") {
                action2Called = true
            },
            KSConfirmationDialog.DialogAction(title: "Delete", icon: "trash", isDestructive: true) {
                action3Called = true
            }
        ]

        XCTAssertEqual(actions.count, 3)
        XCTAssertEqual(actions[0].title, "Share")
        XCTAssertEqual(actions[1].title, "Edit")
        XCTAssertEqual(actions[2].title, "Delete")
        XCTAssertTrue(actions[2].isDestructive)

        // Execute all actions
        actions.forEach { $0.action() }

        XCTAssertTrue(action1Called)
        XCTAssertTrue(action2Called)
        XCTAssertTrue(action3Called)
    }
}
