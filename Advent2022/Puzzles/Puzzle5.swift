//
//  Puzzle5.swift
//  Advent2022
//
//  Created by Pavel Stepanov on 05.12.22.
//

import Foundation

enum Puzzle5 {
    static func solve(fileName: String = "Input5", canHandleMultipleCrates: Bool = false) -> String {
        guard
            let inputData = FileLoader.load(filename: fileName),
            let input = String(data: inputData, encoding: .utf8) else {
            fatalError("Input is missing")
        }
        let inputStrings = input.split(separator: "\n").map(String.init)
        let actions = Helper.extractActions(inputStrings: inputStrings)
        let stacks = Helper.extractStacks(inputStrings: inputStrings)
        let crane = Crane(stacks: stacks, actions: actions, canHandleMultipleCrates: canHandleMultipleCrates)
        crane.moveItems()
        return crane.stacks.map { $0.items.first! }.joined()
    }
}

extension Puzzle5 {
    struct Action {
        let count: Int
        let source: Int
        let destination: Int
    }
}

extension Puzzle5 {
    struct ItemsStack {
        var items: [String]
    }
}

extension Puzzle5 {
    final class Crane {
        var stacks: [ItemsStack]
        let actions: [Action]
        let canHandleMultipleCrates: Bool

        init(stacks: [Puzzle5.ItemsStack], actions: [Puzzle5.Action], canHandleMultipleCrates: Bool) {
            self.stacks = stacks
            self.actions = actions
            self.canHandleMultipleCrates = canHandleMultipleCrates
        }

        func moveItems() {
            actions.forEach { action in
                var moved = Array(stacks[action.source].items[0..<action.count])
                if !canHandleMultipleCrates {
                    moved = moved.reversed()
                }
                stacks[action.source].items.removeFirst(action.count)
                stacks[action.destination].items.insert(contentsOf: moved, at: 0)
            }
        }
    }
}

extension Puzzle5 {
    enum Helper {
        static func extractStacks(inputStrings: [String]) -> [ItemsStack] {
            var stackReadings = [[String]]()
            for string in inputStrings where string.contains("[") {
                let stackComponents = string.everyCharacter(byNumber: 1, inGroupOf: 4)
                stackReadings.append(stackComponents)
            }

            guard !stackReadings.isEmpty else {
                return []
            }

            let columnsCounts = stackReadings.max(by: { $0.count < $1.count })!.count
            var result = [ItemsStack]()
            for column in (0..<columnsCounts) {
                var items = [String]()
                for row in (0..<stackReadings.count) {
                    if column < stackReadings[row].count {
                        items.append(stackReadings[row][column])
                    }
                }
                result.append(.init(items: items.filter { $0 != " " }))
            }
            return result
        }

        /// non-regex solution
        //    static func extractActions(inputStrings: [String]) -> [Action] {
        //        inputStrings.reduce([Action]()) {
        //            guard $1.hasPrefix("move") else {
        //                return $0
        //            }
        //            let digits = $1
        //                .replacingOccurrences(of: " ", with: "")
        //                .components(separatedBy: .letters)
        //                .filter { !$0.isEmpty }
        //            guard digits.count == 3 else {
        //                fatalError("Each command should have threee components")
        //            }
        //            var result = $0
        //            result.append(.init(count: Int(digits[0])!, source: Int(digits[1])!, destination: Int(digits[2])!))
        //            return result
        //        }
        //    }

        /// regex solution
        static func extractActions(inputStrings: [String]) -> [Action] {
            let regex = try! NSRegularExpression(pattern: "[0-9]+")
            return inputStrings.reduce([Action]()) { result, string in
                guard string.hasPrefix("move") else {
                    return result
                }
                let digits = regex
                    .matches(in: string, range: NSRange(string.startIndex..., in: string))
                    .map { String(string[Range($0.range, in: string)!]) }
                    .map { Int($0)! }

                guard digits.count == 3 else {
                    fatalError("Each command should have three components")
                }
                var newResult = result
                newResult.append(.init(count: digits[0], source: digits[1] - 1, destination: digits[2] - 1))
                return newResult
            }
        }
    }
}

extension String {
    func everyCharacter(byNumber number: Int, inGroupOf groupOf: Int) -> [String] {
        return stride(from: 0, to: count, by: groupOf).map {
            let start = index(startIndex, offsetBy: $0 + number)
            return String(self[start...start])
        }
    }
}
