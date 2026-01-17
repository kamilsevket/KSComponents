import XCTest
@testable import KSComponents

final class LoadingTests: XCTestCase {
    // MARK: - KSSpinner Tests

    func testSpinnerSizes() {
        XCTAssertEqual(KSSpinner.Size.small.dimension, 20)
        XCTAssertEqual(KSSpinner.Size.medium.dimension, 32)
        XCTAssertEqual(KSSpinner.Size.large.dimension, 48)
    }

    func testSpinnerScales() {
        XCTAssertEqual(KSSpinner.Size.small.scale, 0.8)
        XCTAssertEqual(KSSpinner.Size.medium.scale, 1.0)
        XCTAssertEqual(KSSpinner.Size.large.scale, 1.5)
    }

    func testKSSpinnerDefaultInit() {
        let spinner = KSSpinner()
        XCTAssertNotNil(spinner)
    }

    func testKSSpinnerCustomInit() {
        let spinner = KSSpinner(size: .large, color: KS.Colors.success)
        XCTAssertNotNil(spinner)
    }

    // MARK: - KSPulsingDots Tests

    func testKSPulsingDotsDefaultInit() {
        let dots = KSPulsingDots()
        XCTAssertNotNil(dots)
    }

    func testKSPulsingDotsCustomInit() {
        let dots = KSPulsingDots(color: KS.Colors.error)
        XCTAssertNotNil(dots)
    }

    // MARK: - KSSkeleton Tests

    func testKSSkeletonDefaultInit() {
        let skeleton = KSSkeleton()
        XCTAssertEqual(skeleton.height, 20)
        XCTAssertEqual(skeleton.cornerRadius, KS.Radius.sm)
        XCTAssertNil(skeleton.width)
    }

    func testKSSkeletonCustomInit() {
        let skeleton = KSSkeleton(width: 200, height: 40, cornerRadius: KS.Radius.lg)
        XCTAssertEqual(skeleton.width, 200)
        XCTAssertEqual(skeleton.height, 40)
        XCTAssertEqual(skeleton.cornerRadius, KS.Radius.lg)
    }

    // MARK: - KSSkeletonCard Tests

    func testKSSkeletonCardDefaultInit() {
        let card = KSSkeletonCard()
        XCTAssertTrue(card.hasImage)
        XCTAssertEqual(card.lines, 3)
    }

    func testKSSkeletonCardCustomInit() {
        let card = KSSkeletonCard(hasImage: false, lines: 5)
        XCTAssertFalse(card.hasImage)
        XCTAssertEqual(card.lines, 5)
    }

    // MARK: - KSProgressBar Tests

    func testKSProgressBarDefaultInit() {
        let progressBar = KSProgressBar(progress: 0.5)
        XCTAssertEqual(progressBar.progress, 0.5)
        XCTAssertEqual(progressBar.height, 8)
        XCTAssertFalse(progressBar.showLabel)
    }

    func testKSProgressBarCustomInit() {
        let progressBar = KSProgressBar(
            progress: 0.75,
            height: 12,
            showLabel: true,
            color: KS.Colors.success
        )
        XCTAssertEqual(progressBar.progress, 0.75)
        XCTAssertEqual(progressBar.height, 12)
        XCTAssertTrue(progressBar.showLabel)
    }

    func testProgressBarClamping() {
        // Test clamping above 1
        let progressAbove = KSProgressBar(progress: 1.5)
        XCTAssertEqual(progressAbove.progress, 1.0)

        // Test clamping below 0
        let progressBelow = KSProgressBar(progress: -0.5)
        XCTAssertEqual(progressBelow.progress, 0.0)

        // Test normal range
        let progressNormal = KSProgressBar(progress: 0.5)
        XCTAssertEqual(progressNormal.progress, 0.5)
    }

    // MARK: - KSCircularProgress Tests

    func testKSCircularProgressDefaultInit() {
        let progress = KSCircularProgress(progress: 0.5)
        XCTAssertEqual(progress.progress, 0.5)
        XCTAssertEqual(progress.size, 60)
        XCTAssertEqual(progress.lineWidth, 6)
        XCTAssertTrue(progress.showLabel)
    }

    func testKSCircularProgressCustomInit() {
        let progress = KSCircularProgress(
            progress: 0.8,
            size: 100,
            lineWidth: 10,
            showLabel: false,
            color: KS.Colors.warning
        )
        XCTAssertEqual(progress.progress, 0.8)
        XCTAssertEqual(progress.size, 100)
        XCTAssertEqual(progress.lineWidth, 10)
        XCTAssertFalse(progress.showLabel)
    }

    func testCircularProgressClamping() {
        // Test clamping above 1
        let progressAbove = KSCircularProgress(progress: 2.0)
        XCTAssertEqual(progressAbove.progress, 1.0)

        // Test clamping below 0
        let progressBelow = KSCircularProgress(progress: -1.0)
        XCTAssertEqual(progressBelow.progress, 0.0)

        // Test normal range
        let progressNormal = KSCircularProgress(progress: 0.75)
        XCTAssertEqual(progressNormal.progress, 0.75)
    }

    // MARK: - KSLoadingOverlay Tests

    func testKSLoadingOverlayDefaultInit() {
        let overlay = KSLoadingOverlay()
        XCTAssertNil(overlay.message)
    }

    func testKSLoadingOverlayWithMessage() {
        let overlay = KSLoadingOverlay(message: "Loading...")
        XCTAssertEqual(overlay.message, "Loading...")
    }

    // MARK: - Edge Cases

    func testProgressBoundaryValues() {
        // Test exact boundary values
        let progressZero = KSProgressBar(progress: 0.0)
        XCTAssertEqual(progressZero.progress, 0.0)

        let progressOne = KSProgressBar(progress: 1.0)
        XCTAssertEqual(progressOne.progress, 1.0)
    }

    func testCircularProgressBoundaryValues() {
        let progressZero = KSCircularProgress(progress: 0.0)
        XCTAssertEqual(progressZero.progress, 0.0)

        let progressOne = KSCircularProgress(progress: 1.0)
        XCTAssertEqual(progressOne.progress, 1.0)
    }
}
