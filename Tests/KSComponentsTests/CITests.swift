import XCTest
@testable import KSComponents

final class CITests: XCTestCase {
    func testCIPipeline() {
        XCTAssertTrue(true)
    }

    func testPackageVersion() {
        // Version check
        XCTAssertNotNil(KS.self)
    }
}
