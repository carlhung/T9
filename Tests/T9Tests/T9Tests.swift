import XCTest
@testable import T9

final class T9Tests: XCTestCase {

    let t9 = try! T9( l: "g", i: "d")
    let relatedWords = try! RelatedWord()

    func testExample() throws {
        let result = try t9.search(set: Array("guoododjuuuduodkuu"))
        let relatedWords = relatedWords.findRelatedWords(target: result[0].word)
        print(relatedWords)
        XCTAssert(!result.isEmpty)
    }
}