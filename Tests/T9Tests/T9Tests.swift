import XCTest
@testable import T9

final class T9Tests: XCTestCase {

    let t9 = try! T9()

    func testExample() throws {

        let com: [Character] = ["u","j"]
        let result = t9.search(set: com)
        result.forEach({ print($0) })
        print("found: \(result.count)")
        // XCTAssertEqual(noThrow, true)
    }

    func testExample1() throws {

    }
}

extension T9 {
    func search(set: [Character]) -> [Word] {
        let result = self.wordList.filter({ word in
            for (index, char) in set.enumerated() {
                if word.combination[safe: index] != char {
                    return false
                }
            }
            return true
        })
        .sorted(by: {
            $0.combination.count < $1.combination.count
        })
        return result
    }
}

extension Collection {

    /// Returns the element at the specified index if it is within bounds, otherwise nil.
    subscript (safe index: Index) -> Element? {
        return indices.contains(index) ? self[index] : nil
    }
}