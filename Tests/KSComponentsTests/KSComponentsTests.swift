import XCTest
@testable import KSComponents

final class KSComponentsTests: XCTestCase {
    func testPackageLoads() {
        XCTAssertTrue(true, "Package loaded successfully")
    }

    func testSpacingValues() {
        XCTAssertEqual(KS.Spacing.none, 0)
        XCTAssertEqual(KS.Spacing.xs, 4)
        XCTAssertEqual(KS.Spacing.sm, 8)
        XCTAssertEqual(KS.Spacing.md, 12)
        XCTAssertEqual(KS.Spacing.lg, 16)
    }

    func testShadowStyles() {
        let smallShadow = KS.Shadows.small
        XCTAssertEqual(smallShadow.radius, 2)
        XCTAssertEqual(smallShadow.y, 1)

        let largeShadow = KS.Shadows.large
        XCTAssertEqual(largeShadow.radius, 8)
        XCTAssertEqual(largeShadow.y, 4)
    }

    func testAnimationDurations() {
        XCTAssertEqual(KS.Animation.durationFast, 0.15)
        XCTAssertEqual(KS.Animation.durationNormal, 0.25)
        XCTAssertEqual(KS.Animation.durationSlow, 0.4)
    }

    func testThemeDefaults() {
        let theme = KSTheme.default
        XCTAssertNotNil(theme.colors)
        XCTAssertNotNil(theme.typography)
        XCTAssertNotNil(theme.spacing)
    }
}
