import XCTest
@testable import Unwrap

final class UnwrapTests: XCTestCase {
    func testExample() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct
        // results.
        XCTAssertEqual(Unwrap().text, "Hello, World!")
    }

    static var allTests = [
        ("testExample", testExample),
    ]
}
