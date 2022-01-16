import XCTest
@testable import T9

final class T9Tests: XCTestCase {

    let t9 = try! T9()

    func testExample() throws {
        let result = t9.search(set: Array("kouljuk"))
        XCTAssert(!result.isEmpty)
    }

    func testExample1() throws {

    }
}