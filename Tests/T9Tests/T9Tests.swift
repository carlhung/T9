import XCTest
@testable import T9

final class T9Tests: XCTestCase {

    let t9 = try! T9()

    func testExample() throws {
        let result = t9.search(set: Array("llllllllllllllllllllllll"))
        result.forEach({ print($0) })
        print("first: \(result[safe: 0]?.combination.count).")
        XCTAssert(!result.isEmpty)
    }

    func testExample1() throws {

    }
}