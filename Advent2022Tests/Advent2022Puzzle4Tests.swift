//
//  Advent2022Puzzle4Tests.swift
//  Advent2022Tests
//
//  Created by Pavel Stepanov on 05.12.22.
//

import XCTest
@testable import Advent2022

final class Advent2022Puzzle4Tests: XCTestCase {
    // MARK: - Puzzle 4 -

    func testPuzzle4() {
        XCTAssertEqual(Puzzle4.solve(input: Puzzle4.testInput), 2)
    }

    func testPuzzle4RealInput() {
        XCTAssertEqual(Puzzle4.solve(input: Puzzle4.input), 485)
    }

    func testPuzzle4Part2() {
        XCTAssertEqual(Puzzle4.solvePart2(input: Puzzle4.testInput), 4)
    }

    func testPuzzle4RealInputPart2() {
        XCTAssertEqual(Puzzle4.solvePart2(input: Puzzle4.input), 857)
    }
}
