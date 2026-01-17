import XCTest
@testable import KSComponents

final class CardTests: XCTestCase {
    // MARK: - KSCard Style Tests

    func testCardStyles() {
        let styles: [KSCardStyle] = [.flat, .elevated, .outlined]
        XCTAssertEqual(styles.count, 3)
    }

    func testKSCardDefaultInit() {
        let card = KSCard {
            EmptyView()
        }

        XCTAssertEqual(card.padding, KS.Spacing.md)
    }

    func testKSCardCustomInit() {
        let card = KSCard(style: .outlined, padding: KS.Spacing.lg) {
            EmptyView()
        }

        XCTAssertEqual(card.padding, KS.Spacing.lg)
    }

    func testKSCardFlatStyle() {
        let card = KSCard(style: .flat) {
            EmptyView()
        }

        XCTAssertNotNil(card.body)
    }

    func testKSCardElevatedStyle() {
        let card = KSCard(style: .elevated) {
            EmptyView()
        }

        XCTAssertNotNil(card.body)
    }

    func testKSCardOutlinedStyle() {
        let card = KSCard(style: .outlined) {
            EmptyView()
        }

        XCTAssertNotNil(card.body)
    }

    // MARK: - KSInteractiveCard Tests

    func testKSInteractiveCardInit() {
        var actionCalled = false
        let card = KSInteractiveCard(action: {
            actionCalled = true
        }) {
            EmptyView()
        }

        XCTAssertNotNil(card.body)
        XCTAssertFalse(actionCalled)
    }

    // MARK: - KSImageCard Tests

    func testKSImageCardDefaultInit() {
        let card = KSImageCard(
            imageURL: nil,
            title: "Test Title"
        )

        XCTAssertEqual(card.title, "Test Title")
        XCTAssertNil(card.subtitle)
        XCTAssertEqual(card.aspectRatio, 16 / 9)
        XCTAssertNil(card.action)
    }

    func testKSImageCardCustomInit() {
        let testURL = URL(string: "https://example.com/image.jpg")
        let card = KSImageCard(
            imageURL: testURL,
            title: "Custom Title",
            subtitle: "Custom Subtitle",
            aspectRatio: 4 / 3,
            action: {}
        )

        XCTAssertEqual(card.imageURL, testURL)
        XCTAssertEqual(card.title, "Custom Title")
        XCTAssertEqual(card.subtitle, "Custom Subtitle")
        XCTAssertEqual(card.aspectRatio, 4 / 3)
        XCTAssertNotNil(card.action)
    }

    func testKSImageCardWithNilImage() {
        let card = KSImageCard(
            imageURL: nil,
            title: "No Image"
        )

        XCTAssertNil(card.imageURL)
        XCTAssertNotNil(card.body)
    }

    // MARK: - KSGradientCard Tests

    func testKSGradientCardDefaultInit() {
        let card = KSGradientCard {
            EmptyView()
        }

        XCTAssertNotNil(card.body)
    }

    func testKSGradientCardCustomGradient() {
        let card = KSGradientCard(gradient: KS.Colors.gradientSunrise) {
            EmptyView()
        }

        XCTAssertNotNil(card.body)
    }

    func testKSGradientCardOceanGradient() {
        let card = KSGradientCard(gradient: KS.Colors.gradientOcean) {
            EmptyView()
        }

        XCTAssertNotNil(card.body)
    }

    // MARK: - KSListCard Tests

    func testKSListCardMinimalInit() {
        let card = KSListCard(title: "Test")

        XCTAssertEqual(card.title, "Test")
        XCTAssertNil(card.icon)
        XCTAssertNil(card.subtitle)
        XCTAssertNil(card.trailing)
        XCTAssertTrue(card.showChevron)
        XCTAssertNil(card.action)
    }

    func testKSListCardFullInit() {
        var actionCalled = false
        let card = KSListCard(
            icon: "star.fill",
            title: "Full Card",
            subtitle: "With all options",
            trailing: "100",
            showChevron: false,
            action: { actionCalled = true }
        )

        XCTAssertEqual(card.icon, "star.fill")
        XCTAssertEqual(card.title, "Full Card")
        XCTAssertEqual(card.subtitle, "With all options")
        XCTAssertEqual(card.trailing, "100")
        XCTAssertFalse(card.showChevron)
        XCTAssertNotNil(card.action)
        XCTAssertFalse(actionCalled)
    }

    func testKSListCardWithIcon() {
        let card = KSListCard(
            icon: "person.fill",
            title: "Profile"
        )

        XCTAssertEqual(card.icon, "person.fill")
        XCTAssertNotNil(card.body)
    }

    func testKSListCardWithTrailing() {
        let card = KSListCard(
            title: "Notifications",
            trailing: "5 new"
        )

        XCTAssertEqual(card.trailing, "5 new")
        XCTAssertNotNil(card.body)
    }

    func testKSListCardWithoutChevron() {
        let card = KSListCard(
            title: "Simple Item",
            showChevron: false
        )

        XCTAssertFalse(card.showChevron)
        XCTAssertNotNil(card.body)
    }

    // MARK: - CardShadowModifier Tests

    func testCardShadowModifierFlat() {
        let modifier = CardShadowModifier(style: .flat)
        XCTAssertNotNil(modifier)
    }

    func testCardShadowModifierElevated() {
        let modifier = CardShadowModifier(style: .elevated)
        XCTAssertNotNil(modifier)
    }

    func testCardShadowModifierOutlined() {
        let modifier = CardShadowModifier(style: .outlined)
        XCTAssertNotNil(modifier)
    }
}
