//
//  Puzzle8.swift
//  Advent2022
//
//  Created by Pavel Stepanov on 10.12.22.
//

import Foundation

enum Puzzle8 {
    static func solve(fileName: String) -> Int {
        guard
            let inputData = FileLoader.load(filename: fileName),
            let input = String(data: inputData, encoding: .utf8) else {
            fatalError("Input is missing")
        }
        return solve(input: input)
    }

    static func solve(input: String) -> Int {
        let treeMatrix = input
            .split(separator: "\n")
            .map(String.init)
            .map(Array.init)

        guard !treeMatrix.isEmpty else {
            return 0
        }

        var visibleTrees = (treeMatrix.count + treeMatrix[0].count - 2) * 2

        for i in (1..<treeMatrix.count - 1) {
            for j in (1..<treeMatrix[0].count - 1) {
                if isVisible(treeMatrix: treeMatrix, i: i, j: j) {
                    visibleTrees += 1
                }
            }
        }
        return visibleTrees
    }

    private static func isVisible(treeMatrix: [[String.Element]], i: Int, j: Int) -> Bool {
        if treeMatrix[i][j] > treeMatrix[i][0..<j].max()! {
            return true
        }
        if treeMatrix[i][j] > treeMatrix[i][(j + 1)..<treeMatrix[i].count].max()! {
            return true
        }
        let maxInRowsInColumnBefore = treeMatrix[0..<i].map { $0[j] }.max()!
        if treeMatrix[i][j] > maxInRowsInColumnBefore {
            return true
        }
        let maxInRowsInColumnAfter = treeMatrix[i + 1..<treeMatrix[i].count].map { $0[j] }.max()!
        if treeMatrix[i][j] > maxInRowsInColumnAfter {
            return true
        }
        return false
    }

    /*
     The other approach would be to check all the rows and columns, create 4 matricies where each cell would indicate if tree
     is visible from that side. And then combining all
     */

    static func solvePart2(fileName: String) -> Int {
        guard
            let inputData = FileLoader.load(filename: fileName),
            let input = String(data: inputData, encoding: .utf8) else {
            fatalError("Input is missing")
        }
        return solvePart2(input: input)
    }

    static func solvePart2(input: String) -> Int {
        let treeMatrix = input
            .split(separator: "\n")
            .map(String.init)
            .map(Array.init)

        guard !treeMatrix.isEmpty else {
            return 0
        }

        var visibleTreesResults = [Int]()
        for i in (0..<treeMatrix.count) {
            for j in (0..<treeMatrix[0].count) {
                visibleTreesResults.append(visibleTrees(treeMatrix: treeMatrix, i: i, j: j))
            }
        }
        return visibleTreesResults.max()!
    }


    private static func visibleTrees(treeMatrix: [[String.Element]], i: Int, j: Int) -> Int {
        var treeVisibility = TreeVisibility(top: 0, right: 0, bottom: 0, left: 0)
        var cursor = j - 1
        while cursor >= 0 {
            treeVisibility.left += 1
            if treeMatrix[i][j] <= treeMatrix[i][cursor] {
                break
            }
            cursor -= 1
        }

        cursor = j + 1
        while cursor < treeMatrix[i].count {
            treeVisibility.right += 1
            if treeMatrix[i][j] <= treeMatrix[i][cursor] {
                break
            }
            cursor += 1
        }

        let rowsInColumnBefore = treeMatrix[0..<i].map { $0[j] }
        cursor = i - 1
        while cursor >= 0, !rowsInColumnBefore.isEmpty {
            treeVisibility.top += 1
            if treeMatrix[i][j] <= rowsInColumnBefore[cursor] {
                break
            }
            cursor -= 1
        }

        let rowsInColumnAfter = treeMatrix[i + 1..<treeMatrix[i].count].map { $0[j] }
        cursor = 0
        while cursor < rowsInColumnAfter.count, !rowsInColumnAfter.isEmpty {
            treeVisibility.bottom += 1
            if treeMatrix[i][j] <= rowsInColumnAfter[cursor] {
                break
            }
            cursor += 1
        }

        return treeVisibility.left * treeVisibility.top * treeVisibility.right * treeVisibility.bottom
    }
}

extension Puzzle8 {
    struct TreeVisibility {
        var top: Int
        var right: Int
        var bottom: Int
        var left: Int
    }
}
