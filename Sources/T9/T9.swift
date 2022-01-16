import Foundation

public enum T9Error: Error {
    case wrongURL
    case wrongFileFormat
    case dataError
}

public enum KeyStroke: Character, CaseIterable, Hashable {
    /// punchuation
    case p = "p"

    /// wild card = `*`
    case l = "l"
    
    /// key strokes
    case u = "u", i = "i", o = "o", j = "j", k = "k"
}

public struct T9 {
    public struct Word {
        let word: String
        let combination: [Character]
    }

    public let wordList: [Word]
    public let punchuationMarkList: [Word]

    public var keyMap: [Character: KeyStroke] = Dictionary(uniqueKeysWithValues: KeyStroke.allCases.map {($0.rawValue, $0)})

    private let filename = "T9.txt"

    public init() throws {
        let fileURL = Bundle.module.url(forResource: "T9", withExtension: "txt")
        guard let fileURL = fileURL else {
            throw T9Error.wrongURL
        }

        let str = try String(contentsOf: fileURL, encoding: String.Encoding.utf8)
        let strArr = str.components(separatedBy: "\r\n\r\n")
        guard strArr.count == 4 else {
            throw T9Error.wrongFileFormat
        }

        let split: (String) throws -> [Word] = { str in
            return try str.split(separator: "\r\n").map { 
                let wordAndKey = $0.split(separator: " ")
                guard wordAndKey.count == 2 else {
                    throw T9Error.dataError
                }
                return Word(word: String(wordAndKey[1]), combination: Array(wordAndKey[0]))
            }
        }

        wordList = try split(strArr[2])
        punchuationMarkList = try split(strArr[1])
    }
}
//  where 
public extension T9 {
    func search(set: [Character]) -> [Word] {
        let result = self.wordList.filter({ word in
            for (index, char) in set.enumerated() {
                guard let c = word.combination[safe: index] else {
                    return false
                }
                if char == KeyStroke.l.rawValue {
                    continue
                }
                if c != char {
                    return false
                }
            }
            return true
        })
        .sorted(by: { $0.combination.count < $1.combination.count })
        return result
    }
}

public extension Collection {
    /// Returns the element at the specified index if it is within bounds, otherwise nil.
    subscript (safe index: Index) -> Element? {
        return indices.contains(index) ? self[index] : nil
    }
}