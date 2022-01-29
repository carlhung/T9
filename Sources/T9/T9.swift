import Foundation

public enum T9Error: Error {
    case wrongWordListURL
    case wrongRelatedWordListURL
    case wrongFileFormat
    case dataError
    case failedToMapKey
}

public enum KeyStroke: Character, CaseIterable, Hashable {
    /// punchuation
    case p = "p"

    /// wild card = `*`
    case l = "l"
    
    /// key strokes
    case u = "u", i = "i", o = "o", j = "j", k = "k"
}

public struct Word<T> {
    let word: String
    let combination: [T]
}

public struct T9 {

    public let wordList: [Word<Character>]
    public let punchuationMarkList: [Word<Character>]

    private var keyMap: [Character: KeyStroke]

    public init(p: Character = "p", 
                 l: Character = "l",
                 u: Character = "u",
                 i: Character = "i",
                 o: Character = "o",
                 j: Character = "j",
                 k: Character = "k") throws {
        let fileURL = Bundle.module.url(forResource: "T9", withExtension: "txt")
        guard let fileURL = fileURL else {
            throw T9Error.wrongWordListURL
        }

        let str = try String(contentsOf: fileURL, encoding: String.Encoding.utf8)
        let strArr = str.components(separatedBy: "\r\n\r\n")
        guard strArr.count == 4 else {
            throw T9Error.wrongFileFormat
        }

        let split: (String) throws -> [Word<Character>] = { str in
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

        self.keyMap =  [
            p: .p,
            l: .l,
            u: .u,
            i: .i,
            o: .o,
            j: .j,
            k: .k,
        ]
    }
}

public extension T9 {
    func search(set: [Character]) throws -> [Word<Character>] {
        let set: [Character] = try set.map {
            guard let char = keyMap[$0]?.rawValue else {
                throw T9Error.failedToMapKey
            }
            return char
        } 
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

public extension T9 {
    mutating func setKeys(p: Character,
                          l: Character,
                          u: Character,
                          i: Character,
                          o: Character,
                          j: Character,
                          k: Character) {
        self.keyMap = [
            p: .p,
            l: .l,
            u: .u,
            i: .i,
            o: .o,
            j: .j,
            k: .k,
        ]
    }
}