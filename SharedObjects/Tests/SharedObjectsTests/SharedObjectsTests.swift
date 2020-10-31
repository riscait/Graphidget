import XCTest
@testable import SharedObjects

final class SharedObjectsTests: XCTestCase {
    func testExample() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct
        // results.
        XCTAssertEqual(SharedObjects().text, "Hello, World!")
    }

    static var allTests = [
        ("testExample", testExample),
    ]
}
