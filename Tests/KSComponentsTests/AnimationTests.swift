import XCTest
import SwiftUI
@testable import KSComponents

final class AnimationTests: XCTestCase {

    // MARK: - Spring Presets Tests

    func testSpringPresets() {
        // Verify animation objects exist and are accessible
        _ = KS.Animation.bouncy
        _ = KS.Animation.smooth
        _ = KS.Animation.snappy
        _ = KS.Animation.gentle
        _ = KS.Animation.springDefault
        _ = KS.Animation.springBouncy
        _ = KS.Animation.springStiff
        XCTAssertTrue(true, "All spring presets should be accessible")
    }

    // MARK: - Duration Presets Tests

    func testDurationPresets() {
        // Verify duration constants exist
        XCTAssertEqual(KS.Animation.durationFast, 0.15)
        XCTAssertEqual(KS.Animation.durationNormal, 0.25)
        XCTAssertEqual(KS.Animation.durationSlow, 0.4)
    }

    // MARK: - Animation Presets Tests

    func testAnimationPresets() {
        // Verify animation presets exist
        _ = KS.Animation.defaultAnimation
        _ = KS.Animation.fastAnimation
        _ = KS.Animation.slowAnimation
        XCTAssertTrue(true, "All animation presets should be accessible")
    }

    // MARK: - Easing Presets Tests

    func testEasingPresets() {
        // Verify easing animation objects exist
        _ = KS.Animation.quick
        _ = KS.Animation.medium
        _ = KS.Animation.slow
        XCTAssertTrue(true, "All easing presets should be accessible")
    }

    // MARK: - Interactive Animation Tests

    func testInteractiveAnimation() {
        // Verify interactive animation exists
        _ = KS.Animation.interactive
        XCTAssertTrue(true, "Interactive animation should be accessible")
    }

    // MARK: - Transition Tests

    func testTransitions() {
        // Verify transitions exist and are accessible
        _ = AnyTransition.ksSlideUp
        _ = AnyTransition.ksSlideDown
        _ = AnyTransition.ksScale
        _ = AnyTransition.ksScaleFade
        _ = AnyTransition.ksFade
        _ = AnyTransition.ksFlip
        XCTAssertTrue(true, "All transitions should be accessible")
    }

    // MARK: - View Modifier Tests

    func testShakeModifier() {
        // Verify shake modifier can be applied to a view
        let view = Text("Test").ksShake(trigger: false)
        XCTAssertNotNil(view, "Shake modifier should be applicable")
    }

    func testPulseModifier() {
        // Verify pulse modifier can be applied to a view
        let viewActive = Text("Test").ksPulse(isActive: true)
        let viewInactive = Text("Test").ksPulse(isActive: false)
        XCTAssertNotNil(viewActive, "Pulse modifier should be applicable with active state")
        XCTAssertNotNil(viewInactive, "Pulse modifier should be applicable with inactive state")
    }

    func testFadeInModifier() {
        // Verify fade in modifier can be applied to a view
        let viewNoDelay = Text("Test").ksFadeIn()
        let viewWithDelay = Text("Test").ksFadeIn(delay: 0.5)
        XCTAssertNotNil(viewNoDelay, "FadeIn modifier should be applicable without delay")
        XCTAssertNotNil(viewWithDelay, "FadeIn modifier should be applicable with delay")
    }

    func testSlideInModifier() {
        // Verify slide in modifier can be applied from all edges
        let viewBottom = Text("Test").ksSlideIn(from: .bottom)
        let viewTop = Text("Test").ksSlideIn(from: .top)
        let viewLeading = Text("Test").ksSlideIn(from: .leading)
        let viewTrailing = Text("Test").ksSlideIn(from: .trailing)
        let viewWithDelay = Text("Test").ksSlideIn(from: .bottom, delay: 0.2)

        XCTAssertNotNil(viewBottom, "SlideIn from bottom should work")
        XCTAssertNotNil(viewTop, "SlideIn from top should work")
        XCTAssertNotNil(viewLeading, "SlideIn from leading should work")
        XCTAssertNotNil(viewTrailing, "SlideIn from trailing should work")
        XCTAssertNotNil(viewWithDelay, "SlideIn with delay should work")
    }

    // MARK: - Typing Indicator Tests

    func testTypingIndicator() {
        // Verify typing indicator can be instantiated
        let indicator = KSTypingIndicator()
        XCTAssertNotNil(indicator, "Typing indicator should be instantiable")
    }

    // MARK: - Colors Tests

    func testColors() {
        // Verify color definitions exist
        _ = KS.Colors.textTertiary
        XCTAssertTrue(true, "Color definitions should be accessible")
    }

    // MARK: - KS Animation View Modifier Tests

    func testKsAnimationViewModifier() {
        // Verify ksAnimation modifier can be applied to a view
        let viewDefault = Text("Test").ksAnimation()
        let viewCustom = Text("Test").ksAnimation(KS.Animation.bouncy)
        XCTAssertNotNil(viewDefault, "ksAnimation modifier should work with default animation")
        XCTAssertNotNil(viewCustom, "ksAnimation modifier should work with custom animation")
    }
}
