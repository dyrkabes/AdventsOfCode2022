//
//  Puzzle6.swift
//  Advent2022
//
//  Created by Pavel Stepanov on 10.12.22.
//

import Foundation

enum Puzzle6 {
    static func solve(_ input: String, distinctCount: Int) -> Int? {
        guard input.count >= 4 else {
            return nil
        }

        var cursor = String(input.prefix(3))
        var index = 3
        while index < input.count {
            let nextCharacter = input[index]
            cursor += String(nextCharacter)
            if hasDuplicates(cursor) {
                cursor.removeFirst()
            }

            if cursor.count == distinctCount {
                return index + 1
            }
            index += 1
        }


        return nil
    }

    private static func hasDuplicates(_ string: String) -> Bool {
        string.count != Set(string).count
    }
}

extension StringProtocol {
    subscript(offset: Int) -> Character {
        self[index(startIndex, offsetBy: offset)]
    }
}

