import XCTest
@testable import neteasy_service

final class neteasy_serviceTests: XCTestCase {
    func testExample() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct
        // results.
        XCTAssertEqual(neteasy_service().text, "Hello, World!")
    }

    static var allTests = [
        ("testExample", testExample),
    ]
}
