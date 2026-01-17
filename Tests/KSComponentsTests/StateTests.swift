import XCTest
@testable import KSComponents

final class StateTests: XCTestCase {

    // MARK: - KSEmptyState Tests

    func testEmptyStateInitialization() {
        let emptyState = KSEmptyState(
            icon: "folder",
            title: "No Files",
            message: "Your folder is empty",
            actionTitle: "Add Files"
        )
        XCTAssertEqual(emptyState.icon, "folder")
        XCTAssertEqual(emptyState.title, "No Files")
        XCTAssertEqual(emptyState.message, "Your folder is empty")
        XCTAssertEqual(emptyState.actionTitle, "Add Files")
    }

    func testEmptyStateMinimalInitialization() {
        let emptyState = KSEmptyState(
            icon: "tray",
            title: "Empty"
        )
        XCTAssertEqual(emptyState.icon, "tray")
        XCTAssertEqual(emptyState.title, "Empty")
        XCTAssertNil(emptyState.message)
        XCTAssertNil(emptyState.actionTitle)
        XCTAssertNil(emptyState.action)
    }

    func testEmptyStatePresetNoResults() {
        let noResults = KSEmptyState.noResults()
        XCTAssertEqual(noResults.icon, "magnifyingglass")
        XCTAssertEqual(noResults.title, "No Results Found")
        XCTAssertEqual(noResults.message, "Try adjusting your search or filters")
        XCTAssertNil(noResults.actionTitle)
    }

    func testEmptyStatePresetNoResultsWithSearchTerm() {
        let noResults = KSEmptyState.noResults(searchTerm: "Swift")
        XCTAssertEqual(noResults.icon, "magnifyingglass")
        XCTAssertEqual(noResults.title, "No Results Found")
        XCTAssertEqual(noResults.message, "No results for \"Swift\"")
    }

    func testEmptyStatePresetNoResultsWithAction() {
        var actionCalled = false
        let noResults = KSEmptyState.noResults(action: { actionCalled = true })
        XCTAssertEqual(noResults.actionTitle, "Clear Filters")
        XCTAssertNotNil(noResults.action)
        noResults.action?()
        XCTAssertTrue(actionCalled)
    }

    func testEmptyStatePresetNoData() {
        let noData = KSEmptyState.noData()
        XCTAssertEqual(noData.icon, "tray")
        XCTAssertEqual(noData.title, "No Data Yet")
        XCTAssertEqual(noData.message, "Start adding items to see them here")
        XCTAssertEqual(noData.actionTitle, "Add New")
    }

    func testEmptyStatePresetNoDataCustom() {
        let noData = KSEmptyState.noData(
            title: "No Items",
            message: "Add some items",
            actionTitle: "Create"
        )
        XCTAssertEqual(noData.title, "No Items")
        XCTAssertEqual(noData.message, "Add some items")
        XCTAssertEqual(noData.actionTitle, "Create")
    }

    func testEmptyStatePresetNoConnection() {
        let noConnection = KSEmptyState.noConnection()
        XCTAssertEqual(noConnection.icon, "wifi.slash")
        XCTAssertEqual(noConnection.title, "No Connection")
        XCTAssertEqual(noConnection.message, "Please check your internet connection and try again")
        XCTAssertEqual(noConnection.actionTitle, "Retry")
    }

    func testEmptyStatePresetNoNotifications() {
        let noNotifications = KSEmptyState.noNotifications()
        XCTAssertEqual(noNotifications.icon, "bell.slash")
        XCTAssertEqual(noNotifications.title, "No Notifications")
        XCTAssertEqual(noNotifications.message, "You're all caught up!")
        XCTAssertNil(noNotifications.actionTitle)
    }

    func testEmptyStatePresetNoMessages() {
        let noMessages = KSEmptyState.noMessages()
        XCTAssertEqual(noMessages.icon, "bubble.left.and.bubble.right")
        XCTAssertEqual(noMessages.title, "No Messages")
        XCTAssertEqual(noMessages.message, "Start a conversation to see messages here")
        XCTAssertNil(noMessages.actionTitle)
    }

    // MARK: - KSErrorState Tests

    func testErrorStateInitialization() {
        let errorState = KSErrorState(
            icon: "xmark.circle",
            title: "Error Occurred",
            message: "Something went wrong",
            errorCode: "ERR_001"
        )
        XCTAssertEqual(errorState.icon, "xmark.circle")
        XCTAssertEqual(errorState.title, "Error Occurred")
        XCTAssertEqual(errorState.message, "Something went wrong")
        XCTAssertEqual(errorState.errorCode, "ERR_001")
    }

    func testErrorStateDefaultValues() {
        let errorState = KSErrorState()
        XCTAssertEqual(errorState.icon, "exclamationmark.triangle")
        XCTAssertEqual(errorState.title, "Something went wrong")
        XCTAssertNil(errorState.message)
        XCTAssertNil(errorState.errorCode)
        XCTAssertNil(errorState.retryAction)
        XCTAssertNil(errorState.helpAction)
    }

    func testErrorStateWithActions() {
        var retryActionCalled = false
        var helpActionCalled = false
        let errorState = KSErrorState(
            retryAction: { retryActionCalled = true },
            helpAction: { helpActionCalled = true }
        )
        XCTAssertNotNil(errorState.retryAction)
        XCTAssertNotNil(errorState.helpAction)
        errorState.retryAction?()
        errorState.helpAction?()
        XCTAssertTrue(retryActionCalled)
        XCTAssertTrue(helpActionCalled)
    }

    func testErrorStatePresetNetworkError() {
        let networkError = KSErrorState.networkError()
        XCTAssertEqual(networkError.icon, "wifi.exclamationmark")
        XCTAssertEqual(networkError.title, "Network Error")
        XCTAssertNotNil(networkError.message)
    }

    func testErrorStatePresetServerError() {
        let serverError = KSErrorState.serverError(errorCode: "500")
        XCTAssertEqual(serverError.icon, "server.rack")
        XCTAssertEqual(serverError.title, "Server Error")
        XCTAssertEqual(serverError.errorCode, "500")
    }

    func testErrorStatePresetPermissionDenied() {
        let permissionDenied = KSErrorState.permissionDenied()
        XCTAssertEqual(permissionDenied.icon, "lock.shield")
        XCTAssertEqual(permissionDenied.title, "Access Denied")
    }

    func testErrorStatePresetNotFound() {
        let notFound = KSErrorState.notFound()
        XCTAssertEqual(notFound.icon, "questionmark.folder")
        XCTAssertEqual(notFound.title, "Not Found")
    }

    // MARK: - KSOfflineBar Tests

    func testOfflineBarInitialization() {
        let offlineBar = KSOfflineBar(isOffline: true)
        XCTAssertTrue(offlineBar.isOffline)
        XCTAssertNil(offlineBar.retryAction)
    }

    func testOfflineBarWithRetryAction() {
        var retryActionCalled = false
        let offlineBar = KSOfflineBar(isOffline: true, retryAction: { retryActionCalled = true })
        XCTAssertNotNil(offlineBar.retryAction)
        offlineBar.retryAction?()
        XCTAssertTrue(retryActionCalled)
    }

    func testOfflineBarWhenOnline() {
        let offlineBar = KSOfflineBar(isOffline: false)
        XCTAssertFalse(offlineBar.isOffline)
    }

    // MARK: - KSMaintenanceState Tests

    func testMaintenanceStateInitialization() {
        let maintenance = KSMaintenanceState(
            title: "Maintenance",
            message: "We are updating",
            estimatedTime: "1 hour"
        )
        XCTAssertEqual(maintenance.title, "Maintenance")
        XCTAssertEqual(maintenance.message, "We are updating")
        XCTAssertEqual(maintenance.estimatedTime, "1 hour")
    }

    func testMaintenanceStateDefaultValues() {
        let maintenance = KSMaintenanceState()
        XCTAssertEqual(maintenance.title, "Under Maintenance")
        XCTAssertEqual(maintenance.message, "We're making some improvements. Please check back soon.")
        XCTAssertNil(maintenance.estimatedTime)
    }

    func testMaintenanceStatePresetScheduled() {
        let scheduled = KSMaintenanceState.scheduledMaintenance(estimatedTime: "2 hours")
        XCTAssertEqual(scheduled.title, "Scheduled Maintenance")
        XCTAssertEqual(scheduled.estimatedTime, "2 hours")
    }

    func testMaintenanceStatePresetUpdating() {
        let updating = KSMaintenanceState.updating()
        XCTAssertEqual(updating.title, "Updating")
    }

    func testMaintenanceStatePresetComingSoon() {
        let comingSoon = KSMaintenanceState.comingSoon()
        XCTAssertEqual(comingSoon.title, "Coming Soon")
    }
}
