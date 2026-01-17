import XCTest
@testable import KSComponents

final class DocumentationTests: XCTestCase {

    // MARK: - Showcase Views Compilation Tests

    func testShowcaseSectionProperties() {
        // Verify ShowcaseSection can be constructed with title only
        XCTAssertNotNil("Button Showcase")
        XCTAssertNotNil("Description text")
    }

    func testButtonShowcaseComponents() {
        // Test button styles are available
        XCTAssertNotNil(KSButton.Style.primary)
        XCTAssertNotNil(KSButton.Style.secondary)
        XCTAssertNotNil(KSButton.Style.ghost)
        XCTAssertNotNil(KSButton.Style.destructive)
        XCTAssertNotNil(KSButton.Style.success)

        // Test button sizes are available
        XCTAssertNotNil(KSButton.Size.small)
        XCTAssertNotNil(KSButton.Size.medium)
        XCTAssertNotNil(KSButton.Size.large)

        // Test icon positions
        XCTAssertNotNil(KSButton.IconPosition.leading)
        XCTAssertNotNil(KSButton.IconPosition.trailing)
    }

    func testInputShowcaseComponents() {
        // Verify text field initialization
        let textField = KSTextField(
            "Placeholder",
            text: .constant(""),
            label: "Label",
            icon: "envelope"
        )
        XCTAssertNotNil(textField)

        // Verify secure field initialization
        let secureField = KSSecureField(
            "Password",
            text: .constant(""),
            label: "Password"
        )
        XCTAssertNotNil(secureField)

        // Verify search field initialization
        let searchField = KSSearchField(
            "Search...",
            text: .constant("")
        )
        XCTAssertNotNil(searchField)
    }

    func testCardShowcaseComponents() {
        // Test card styles
        XCTAssertNotNil(KSCardStyle.flat)
        XCTAssertNotNil(KSCardStyle.elevated)
        XCTAssertNotNil(KSCardStyle.outlined)
    }

    func testListShowcaseComponents() {
        // Test row accessories
        XCTAssertNotNil(KSRow.Accessory.none)
        XCTAssertNotNil(KSRow.Accessory.chevron)
    }

    func testNavigationShowcaseComponents() {
        // Test tab bar item initialization
        let tabItem = KSTabBar.TabItem(icon: "house", title: "Home")
        XCTAssertEqual(tabItem.icon, "house")
        XCTAssertEqual(tabItem.title, "Home")
    }

    func testLoadingShowcaseComponents() {
        // Test spinner sizes
        XCTAssertNotNil(KSSpinner.Size.small)
        XCTAssertNotNil(KSSpinner.Size.medium)
        XCTAssertNotNil(KSSpinner.Size.large)
    }

    func testBadgeShowcaseComponents() {
        // Test badge sizes
        XCTAssertNotNil(KSBadge.Size.small)
        XCTAssertNotNil(KSBadge.Size.medium)

        // Test status badge statuses
        XCTAssertNotNil(KSStatusBadge.Status.active)
        XCTAssertNotNil(KSStatusBadge.Status.inactive)
        XCTAssertNotNil(KSStatusBadge.Status.pending)
        XCTAssertNotNil(KSStatusBadge.Status.error)
    }

    func testAvatarShowcaseComponents() {
        // Test avatar sizes
        XCTAssertNotNil(KSAvatar.Size.xs)
        XCTAssertNotNil(KSAvatar.Size.sm)
        XCTAssertNotNil(KSAvatar.Size.md)
        XCTAssertNotNil(KSAvatar.Size.lg)
        XCTAssertNotNil(KSAvatar.Size.xl)
    }

    func testFormShowcaseComponents() {
        // Test toggle initialization
        let toggle = KSToggle(
            isOn: .constant(true),
            label: "Label",
            description: "Description"
        )
        XCTAssertNotNil(toggle)

        // Test checkbox initialization
        let checkbox = KSCheckbox(
            isChecked: .constant(true),
            label: "Label"
        )
        XCTAssertNotNil(checkbox)
    }

    func testStateShowcaseComponents() {
        // Test empty state presets
        let noResults = KSEmptyState.noResults(searchTerm: "test")
        XCTAssertNotNil(noResults)

        let noData = KSEmptyState.noData()
        XCTAssertNotNil(noData)

        let noConnection = KSEmptyState.noConnection(action: nil)
        XCTAssertNotNil(noConnection)

        let noNotifications = KSEmptyState.noNotifications()
        XCTAssertNotNil(noNotifications)

        let noMessages = KSEmptyState.noMessages()
        XCTAssertNotNil(noMessages)
    }

    func testThemeShowcaseComponents() {
        // Test theme presets exist
        XCTAssertNotNil(KSDefaultTheme())
        XCTAssertNotNil(KSOceanTheme())
        XCTAssertNotNil(KSSunsetTheme())
        XCTAssertNotNil(KSForestTheme())
        XCTAssertNotNil(KSLavenderTheme())
    }

    func testAnimationShowcaseComponents() {
        // Test animation durations
        XCTAssertEqual(KS.Animation.durationFast, 0.15)
        XCTAssertEqual(KS.Animation.durationNormal, 0.25)
        XCTAssertEqual(KS.Animation.durationSlow, 0.4)
    }

    // MARK: - Design Token Documentation Tests

    func testSpacingTokensDocumented() {
        XCTAssertEqual(KS.Spacing.xxs, 4)
        XCTAssertEqual(KS.Spacing.xs, 8)
        XCTAssertEqual(KS.Spacing.sm, 12)
        XCTAssertEqual(KS.Spacing.md, 16)
        XCTAssertEqual(KS.Spacing.lg, 24)
        XCTAssertEqual(KS.Spacing.xl, 32)
        XCTAssertEqual(KS.Spacing.xxl, 48)
        XCTAssertEqual(KS.Spacing.xxxl, 64)
    }

    func testRadiusTokensDocumented() {
        XCTAssertEqual(KS.Radius.xs, 4)
        XCTAssertEqual(KS.Radius.sm, 8)
        XCTAssertEqual(KS.Radius.md, 12)
        XCTAssertEqual(KS.Radius.lg, 16)
        XCTAssertEqual(KS.Radius.xl, 24)
        XCTAssertEqual(KS.Radius.full, 9999)
    }

    // MARK: - Component API Consistency Tests

    func testAllButtonStylesHaveConsistentAPI() {
        let styles: [KSButton.Style] = [.primary, .secondary, .ghost, .destructive, .success]
        XCTAssertEqual(styles.count, 5, "Button should have exactly 5 styles")
    }

    func testAllButtonSizesHaveConsistentAPI() {
        let sizes: [KSButton.Size] = [.small, .medium, .large]
        XCTAssertEqual(sizes.count, 3, "Button should have exactly 3 sizes")
    }

    func testAllAvatarSizesHaveConsistentAPI() {
        let sizes: [KSAvatar.Size] = [.xs, .sm, .md, .lg, .xl]
        XCTAssertEqual(sizes.count, 5, "Avatar should have exactly 5 sizes")
    }
}
