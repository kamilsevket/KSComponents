import XCTest
@testable import KSComponents

final class KSComponentsTests: XCTestCase {
    func testPackageLoads() {
        XCTAssertTrue(true, "Package loaded successfully")
    }

    func testSpacingValues() {
        XCTAssertEqual(KS.Spacing.xxs, 4)
        XCTAssertEqual(KS.Spacing.xs, 8)
        XCTAssertEqual(KS.Spacing.sm, 12)
        XCTAssertEqual(KS.Spacing.md, 16)
        XCTAssertEqual(KS.Spacing.lg, 24)
        XCTAssertEqual(KS.Spacing.xl, 32)
        XCTAssertEqual(KS.Spacing.xxl, 48)
        XCTAssertEqual(KS.Spacing.xxxl, 64)
    }

    func testRadiusValues() {
        XCTAssertEqual(KS.Radius.xs, 4)
        XCTAssertEqual(KS.Radius.sm, 8)
        XCTAssertEqual(KS.Radius.md, 12)
        XCTAssertEqual(KS.Radius.lg, 16)
        XCTAssertEqual(KS.Radius.xl, 24)
        XCTAssertEqual(KS.Radius.full, 9999)
    }

    func testShadowStyles() {
        let smShadow = KS.Shadows.sm
        XCTAssertEqual(smShadow.radius, 2)
        XCTAssertEqual(smShadow.y, 1)

        let lgShadow = KS.Shadows.lg
        XCTAssertEqual(lgShadow.radius, 8)
        XCTAssertEqual(lgShadow.y, 4)

        let xlShadow = KS.Shadows.xl
        XCTAssertEqual(xlShadow.radius, 16)
        XCTAssertEqual(xlShadow.y, 8)
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

    func testTypographyExists() {
        // Display
        XCTAssertNotNil(KS.Typography.displayLarge)
        XCTAssertNotNil(KS.Typography.displayMedium)
        XCTAssertNotNil(KS.Typography.displaySmall)

        // Headline
        XCTAssertNotNil(KS.Typography.headlineLarge)
        XCTAssertNotNil(KS.Typography.headlineMedium)
        XCTAssertNotNil(KS.Typography.headlineSmall)

        // Title
        XCTAssertNotNil(KS.Typography.titleLarge)
        XCTAssertNotNil(KS.Typography.titleMedium)
        XCTAssertNotNil(KS.Typography.titleSmall)

        // Body
        XCTAssertNotNil(KS.Typography.bodyLarge)
        XCTAssertNotNil(KS.Typography.bodyMedium)
        XCTAssertNotNil(KS.Typography.bodySmall)

        // Label
        XCTAssertNotNil(KS.Typography.labelLarge)
        XCTAssertNotNil(KS.Typography.labelMedium)
        XCTAssertNotNil(KS.Typography.labelSmall)

        // Caption
        XCTAssertNotNil(KS.Typography.caption)
        XCTAssertNotNil(KS.Typography.captionBold)
    }

    func testSemanticColorsExist() {
        XCTAssertNotNil(KS.Colors.success)
        XCTAssertNotNil(KS.Colors.warning)
        XCTAssertNotNil(KS.Colors.error)
        XCTAssertNotNil(KS.Colors.info)
    }

    func testGradientsExist() {
        XCTAssertNotNil(KS.Colors.gradientPrimary)
        XCTAssertNotNil(KS.Colors.gradientSunrise)
        XCTAssertNotNil(KS.Colors.gradientOcean)
    }
}
