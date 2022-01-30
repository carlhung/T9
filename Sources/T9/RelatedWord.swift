import Foundation

public struct RelatedWord {
    private let relatedWordList: [Word<String>]

    init() throws {
        let fileURL = Bundle.module.url(forResource: "relatedWords", withExtension: "txt")
        guard let fileURL = fileURL else {
            throw T9Error.wrongRelatedWordListURL
        }
        let str = try String(contentsOf: fileURL, encoding: String.Encoding.utf8)
        let strArr: [Word<String>] = try str.splitIntoArray(separatedBy: "\n")
            .map { 
                var newRelatedWordList = $0.splitIntoArray(separatedBy: " ")
                guard !newRelatedWordList.isEmpty else {
                    throw T9Error.dataError
                }
                var elm = newRelatedWordList.removeFirst()
                let firstChar = elm.removeFirst()
                return Word(word: String(firstChar), combination: [elm] + newRelatedWordList)
            }
        relatedWordList = strArr
    }
}

public extension RelatedWord {
    func findRelatedWords(target: String) -> [String] {
        relatedWordList.first {
            $0.word == target
        }?.combination ?? []
    }
}

fileprivate extension String {
    func splitIntoArray(separatedBy: String) -> [String] {
        self.components(separatedBy: separatedBy)
            .map { $0.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines) }
            .filter { !$0.isEmpty }
    }
}