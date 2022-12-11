//
//  Advent2022Puzzle6Tests.swift
//  Advent2022Tests
//
//  Created by Pavel Stepanov on 10.12.22.
//

import XCTest
@testable import Advent2022

final class Advent2022Puzzle8Tests: XCTestCase {

    // MARK: - Part 1 -

    func testPuzzle8Test() {
        XCTAssertEqual(Puzzle8.solve(fileName: "Input8Test"), 21)
    }

    func testPuzzle8AllVisible() {
        let input = """
        12345
        13456
        36542
        15212
        90109
        """
        XCTAssertEqual(Puzzle8.solve(input: input), 25)
    }

    func testPuzzle8() {
        XCTAssertEqual(Puzzle8.solve(fileName: "Input8"), 1662)
    }

    // MARK: - Part 2 -

    func testPuzzle8TestArbitraryPart2() {
        let input = """
        12345
        12385
        12345
        12345
        12395
        """
        XCTAssertEqual(Puzzle8.solvePart2(input: input), 9)
    }

    func testPuzzle8TestFromSourcePart2() {
        XCTAssertEqual(Puzzle8.solvePart2(fileName: "Input8Test"), 8)
    }

    func testPuzzle8Part2() {
        XCTAssertEqual(Puzzle8.solvePart2(fileName: "Input8"), 537600)
    }
}
