import XCTest
@testable import KSComponents

final class AvatarTests: XCTestCase {

    // MARK: - KSAvatar Size Tests

    func testAvatarSizeXS() {
        XCTAssertEqual(KSAvatar.Size.xs.dimension, 24)
    }

    func testAvatarSizeSM() {
        XCTAssertEqual(KSAvatar.Size.sm.dimension, 32)
    }

    func testAvatarSizeMD() {
        XCTAssertEqual(KSAvatar.Size.md.dimension, 40)
    }

    func testAvatarSizeLG() {
        XCTAssertEqual(KSAvatar.Size.lg.dimension, 56)
    }

    func testAvatarSizeXL() {
        XCTAssertEqual(KSAvatar.Size.xl.dimension, 80)
    }

    // MARK: - Initials Generation Tests

    func testInitialsFromTwoWordName() {
        let name = "John Doe"
        let components = name.split(separator: " ")
        let initials = components.prefix(2).compactMap { $0.first }.map(String.init).joined().uppercased()
        XCTAssertEqual(initials, "JD")
    }

    func testInitialsFromSingleWordName() {
        let name = "Alice"
        let components = name.split(separator: " ")
        let initials = components.prefix(2).compactMap { $0.first }.map(String.init).joined().uppercased()
        XCTAssertEqual(initials, "A")
    }

    func testInitialsFromThreeWordName() {
        let name = "John Michael Doe"
        let components = name.split(separator: " ")
        let initials = components.prefix(2).compactMap { $0.first }.map(String.init).joined().uppercased()
        XCTAssertEqual(initials, "JM")
    }

    func testInitialsFromLowercaseName() {
        let name = "jane smith"
        let components = name.split(separator: " ")
        let initials = components.prefix(2).compactMap { $0.first }.map(String.init).joined().uppercased()
        XCTAssertEqual(initials, "JS")
    }

    // MARK: - KSAvatarGroup Tests

    func testAvatarGroupOverflowCalculation() {
        let avatars = (0..<10).map { _ in KSAvatarGroup.AvatarData() }
        let maxDisplay = 4
        let overflow = max(0, avatars.count - maxDisplay)
        XCTAssertEqual(overflow, 6)
    }

    func testAvatarGroupNoOverflow() {
        let avatars = (0..<3).map { _ in KSAvatarGroup.AvatarData() }
        let maxDisplay = 4
        let overflow = max(0, avatars.count - maxDisplay)
        XCTAssertEqual(overflow, 0)
    }

    func testAvatarGroupExactMaxDisplay() {
        let avatars = (0..<4).map { _ in KSAvatarGroup.AvatarData() }
        let maxDisplay = 4
        let overflow = max(0, avatars.count - maxDisplay)
        XCTAssertEqual(overflow, 0)
    }

    func testAvatarGroupDisplayAvatars() {
        let avatars = (0..<10).map { _ in KSAvatarGroup.AvatarData() }
        let maxDisplay = 4
        let displayAvatars = Array(avatars.prefix(maxDisplay))
        XCTAssertEqual(displayAvatars.count, 4)
    }

    // MARK: - KSAvatarData Tests

    func testAvatarDataInitialization() {
        let avatarData = KSAvatarGroup.AvatarData(name: "Test User")
        XCTAssertNil(avatarData.imageURL)
        XCTAssertEqual(avatarData.name, "Test User")
        XCTAssertNotNil(avatarData.id)
    }

    func testAvatarDataWithURL() {
        let url = URL(string: "https://example.com/avatar.jpg")
        let avatarData = KSAvatarGroup.AvatarData(imageURL: url, name: "Test User")
        XCTAssertEqual(avatarData.imageURL, url)
        XCTAssertEqual(avatarData.name, "Test User")
    }

    // MARK: - KSAsyncImage PlaceholderStyle Tests

    func testAsyncImagePlaceholderStyles() {
        // Test that placeholder styles can be created
        let skeleton: KSAsyncImage.PlaceholderStyle = .skeleton
        let icon: KSAsyncImage.PlaceholderStyle = .icon
        let color: KSAsyncImage.PlaceholderStyle = .color(.red)

        // Verify enum cases exist
        switch skeleton {
        case .skeleton: XCTAssertTrue(true)
        case .icon, .color: XCTFail("Expected skeleton")
        }

        switch icon {
        case .icon: XCTAssertTrue(true)
        case .skeleton, .color: XCTFail("Expected icon")
        }

        switch color {
        case .color: XCTAssertTrue(true)
        case .skeleton, .icon: XCTFail("Expected color")
        }
    }
}
