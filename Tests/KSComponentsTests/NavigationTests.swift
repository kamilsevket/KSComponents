import XCTest
import SwiftUI
@testable import KSComponents

final class NavigationTests: XCTestCase {

    // MARK: - KSTabBar.TabItem Tests

    func testTabItemWithDefaultSelectedIcon() {
        let item = KSTabBar.TabItem(icon: "house", title: "Home")
        XCTAssertEqual(item.icon, "house")
        XCTAssertEqual(item.selectedIcon, "house.fill")
        XCTAssertEqual(item.title, "Home")
    }

    func testTabItemWithCustomSelectedIcon() {
        let item = KSTabBar.TabItem(icon: "magnifyingglass", selectedIcon: "magnifyingglass.circle.fill", title: "Search")
        XCTAssertEqual(item.icon, "magnifyingglass")
        XCTAssertEqual(item.selectedIcon, "magnifyingglass.circle.fill")
        XCTAssertEqual(item.title, "Search")
    }

    func testTabItemWithEmptyTitle() {
        let item = KSTabBar.TabItem(icon: "star", title: "")
        XCTAssertEqual(item.title, "")
    }

    // MARK: - KSBottomSheet.Detent Tests

    func testDetentSmallHeightRatio() {
        XCTAssertEqual(KSBottomSheet<EmptyView>.Detent.small.heightRatio, 0.25)
    }

    func testDetentMediumHeightRatio() {
        XCTAssertEqual(KSBottomSheet<EmptyView>.Detent.medium.heightRatio, 0.5)
    }

    func testDetentLargeHeightRatio() {
        XCTAssertEqual(KSBottomSheet<EmptyView>.Detent.large.heightRatio, 0.9)
    }

    func testDetentEquality() {
        XCTAssertEqual(KSBottomSheet<EmptyView>.Detent.small, KSBottomSheet<EmptyView>.Detent.small)
        XCTAssertNotEqual(KSBottomSheet<EmptyView>.Detent.small, KSBottomSheet<EmptyView>.Detent.medium)
    }

    // MARK: - KS Design System Tests

    func testSpacingValues() {
        // Verifying spacing token values from KSSpacing.swift
        XCTAssertEqual(KS.Spacing.xxs, 4)
        XCTAssertEqual(KS.Spacing.xs, 8)
        XCTAssertEqual(KS.Spacing.sm, 12)
        XCTAssertEqual(KS.Spacing.md, 16)
        XCTAssertEqual(KS.Spacing.lg, 24)
        XCTAssertEqual(KS.Spacing.xl, 32)
        XCTAssertEqual(KS.Spacing.xxl, 48)
    }

    func testRadiusValues() {
        // Verifying radius token values from KSSpacing.swift
        XCTAssertEqual(KS.Radius.xs, 4)
        XCTAssertEqual(KS.Radius.sm, 8)
        XCTAssertEqual(KS.Radius.md, 12)
        XCTAssertEqual(KS.Radius.lg, 16)
        XCTAssertEqual(KS.Radius.xl, 24)
        XCTAssertEqual(KS.Radius.full, 9999)
    }

    // MARK: - KSNavBar.NavButton Tests

    func testNavButtonCreation() {
        var actionCalled = false
        let button = KSNavBar.NavButton(icon: "chevron.left") {
            actionCalled = true
        }

        XCTAssertEqual(button.icon, "chevron.left")
        button.action()
        XCTAssertTrue(actionCalled)
    }
}
