import SwiftUI
import XCTest
@testable import KSComponents

final class ThemeTests: XCTestCase {

    // MARK: - Default Theme Tests

    func testDefaultTheme() {
        let theme = KSDefaultTheme()
        XCTAssertNotNil(theme.primary)
        XCTAssertNotNil(theme.secondary)
        XCTAssertNotNil(theme.accent)
        XCTAssertNotNil(theme.background)
        XCTAssertNotNil(theme.surface)
        XCTAssertNotNil(theme.textPrimary)
        XCTAssertNotNil(theme.textSecondary)
        XCTAssertNotNil(theme.border)
        XCTAssertNotNil(theme.success)
        XCTAssertNotNil(theme.warning)
        XCTAssertNotNil(theme.error)
    }

    // MARK: - Theme Manager Tests

    func testThemeManagerSingleton() {
        let manager1 = KSThemeManager.shared
        let manager2 = KSThemeManager.shared
        XCTAssertTrue(manager1 === manager2)
    }

    func testThemeManagerDefaultTheme() {
        let manager = KSThemeManager.shared
        XCTAssertTrue(manager.currentTheme is KSDefaultTheme)
    }

    func testThemeManagerSetOceanTheme() {
        let manager = KSThemeManager.shared
        manager.setTheme(KSOceanTheme())
        XCTAssertTrue(manager.currentTheme is KSOceanTheme)
        // Reset to default
        manager.setTheme(KSDefaultTheme())
    }

    func testThemeManagerSetSunsetTheme() {
        let manager = KSThemeManager.shared
        manager.setTheme(KSSunsetTheme())
        XCTAssertTrue(manager.currentTheme is KSSunsetTheme)
        // Reset to default
        manager.setTheme(KSDefaultTheme())
    }

    func testThemeManagerSetForestTheme() {
        let manager = KSThemeManager.shared
        manager.setTheme(KSForestTheme())
        XCTAssertTrue(manager.currentTheme is KSForestTheme)
        // Reset to default
        manager.setTheme(KSDefaultTheme())
    }

    func testThemeManagerSetLavenderTheme() {
        let manager = KSThemeManager.shared
        manager.setTheme(KSLavenderTheme())
        XCTAssertTrue(manager.currentTheme is KSLavenderTheme)
        // Reset to default
        manager.setTheme(KSDefaultTheme())
    }

    // MARK: - Preset Theme Tests

    func testOceanTheme() {
        let theme = KSOceanTheme()
        XCTAssertNotNil(theme.primary)
        XCTAssertNotNil(theme.secondary)
        XCTAssertNotNil(theme.accent)
        XCTAssertNotNil(theme.background)
        XCTAssertNotNil(theme.surface)
        XCTAssertNotNil(theme.textPrimary)
        XCTAssertNotNil(theme.textSecondary)
        XCTAssertNotNil(theme.border)
        XCTAssertNotNil(theme.success)
        XCTAssertNotNil(theme.warning)
        XCTAssertNotNil(theme.error)
    }

    func testSunsetTheme() {
        let theme = KSSunsetTheme()
        XCTAssertNotNil(theme.primary)
        XCTAssertNotNil(theme.secondary)
        XCTAssertNotNil(theme.accent)
        XCTAssertNotNil(theme.background)
        XCTAssertNotNil(theme.surface)
        XCTAssertNotNil(theme.textPrimary)
        XCTAssertNotNil(theme.textSecondary)
        XCTAssertNotNil(theme.border)
        XCTAssertNotNil(theme.success)
        XCTAssertNotNil(theme.warning)
        XCTAssertNotNil(theme.error)
    }

    func testForestTheme() {
        let theme = KSForestTheme()
        XCTAssertNotNil(theme.primary)
        XCTAssertNotNil(theme.secondary)
        XCTAssertNotNil(theme.accent)
        XCTAssertNotNil(theme.background)
        XCTAssertNotNil(theme.surface)
        XCTAssertNotNil(theme.textPrimary)
        XCTAssertNotNil(theme.textSecondary)
        XCTAssertNotNil(theme.border)
        XCTAssertNotNil(theme.success)
        XCTAssertNotNil(theme.warning)
        XCTAssertNotNil(theme.error)
    }

    func testLavenderTheme() {
        let theme = KSLavenderTheme()
        XCTAssertNotNil(theme.primary)
        XCTAssertNotNil(theme.secondary)
        XCTAssertNotNil(theme.accent)
        XCTAssertNotNil(theme.background)
        XCTAssertNotNil(theme.surface)
        XCTAssertNotNil(theme.textPrimary)
        XCTAssertNotNil(theme.textSecondary)
        XCTAssertNotNil(theme.border)
        XCTAssertNotNil(theme.success)
        XCTAssertNotNil(theme.warning)
        XCTAssertNotNil(theme.error)
    }

    // MARK: - Color Hex Extension Tests

    func testColorHex6Digit() {
        let color = Color(hex: "#FF5733")
        XCTAssertNotNil(color)
    }

    func testColorHex3Digit() {
        let color = Color(hex: "#F53")
        XCTAssertNotNil(color)
    }

    func testColorHex8Digit() {
        let color = Color(hex: "#80FF5733")
        XCTAssertNotNil(color)
    }

    func testColorHexWithoutHash() {
        let color = Color(hex: "FF5733")
        XCTAssertNotNil(color)
    }

    func testColorHexInvalidLength() {
        // Invalid hex should default to black
        let color = Color(hex: "#12345")
        XCTAssertNotNil(color)
    }

    // MARK: - Theme Protocol Conformance Tests

    func testAllThemesConformToProtocol() {
        let themes: [KSThemeProtocol] = [
            KSDefaultTheme(),
            KSOceanTheme(),
            KSSunsetTheme(),
            KSForestTheme(),
            KSLavenderTheme()
        ]

        for theme in themes {
            XCTAssertNotNil(theme.primary)
            XCTAssertNotNil(theme.secondary)
            XCTAssertNotNil(theme.accent)
            XCTAssertNotNil(theme.background)
            XCTAssertNotNil(theme.surface)
            XCTAssertNotNil(theme.textPrimary)
            XCTAssertNotNil(theme.textSecondary)
            XCTAssertNotNil(theme.border)
            XCTAssertNotNil(theme.success)
            XCTAssertNotNil(theme.warning)
            XCTAssertNotNil(theme.error)
        }
    }
}
