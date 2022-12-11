//
//  Advent2022Puzzle5Tests.swift
//  Advent2022Tests
//
//  Created by Pavel Stepanov on 05.12.22.
//

import XCTest
@testable import Advent2022

final class Advent2022Puzzle5Tests: XCTestCase {
    func testStringCharacterExtraction() {
        // given
        let input = "01010101"

        // when
        let result = input.everyCharacter(byNumber: 1, inGroupOf: 2)

        // then
        XCTAssertEqual(result.count, 4)
        XCTAssertTrue(result.allSatisfy { $0 == "1" })
    }

    func testStackExtraction() {
        // given
        let inputStrings = [
            "    [W] ",
            "    [P] [A] ",
            "[J] [P] [A] [Z] ",
            "[J] [P] [A] [U] "
        ]

        // when
        let result = Puzzle5.Helper.extractStacks(inputStrings: inputStrings)

        // then
        XCTAssertEqual(result.count, 4)
        XCTAssertEqual(result[0].items, ["J", "J"])
        XCTAssertEqual(result[1].items, ["W", "P", "P", "P"])
        XCTAssertEqual(result[2].items, ["A", "A", "A"])
        XCTAssertEqual(result[3].items, ["Z", "U"])
    }

    func testStackExtractionFromRealData() {
        // given
        let inputStrings = [
            "    [W] ",
            "    [P] [A] ",
            "[J] [P] [A] [Z] ",
            "[J] [P] [O] [U] ",
            "1 2 3",
            "",
            "move 1 from 2 to 1"
        ]

        // when
        let result = Puzzle5.Helper.extractStacks(inputStrings: inputStrings)

        // then
        XCTAssertEqual(result.count, 4)
        XCTAssertEqual(result[0].items, ["J", "J"])
        XCTAssertEqual(result[1].items, ["W", "P", "P", "P"])
        XCTAssertEqual(result[2].items, ["A", "A", "O"])
        XCTAssertEqual(result[3].items, ["Z", "U"])
    }

    func testActionsExtraction() {
        // given
        let inputStrings = [
            "move 1 from 2 to 1",
            "move 3 from 1 to 3",
            "move 39 from 10 to 300",
        ]

        // when
        let result = Puzzle5.Helper.extractActions(inputStrings: inputStrings)

        // then
        XCTAssertEqual(result.count, 3)
        XCTAssertEqual(result[0].count, 1)
        XCTAssertEqual(result[0].source, 1)
        XCTAssertEqual(result[0].destination, 0)
        XCTAssertEqual(result[1].count, 3)
        XCTAssertEqual(result[1].source, 0)
        XCTAssertEqual(result[1].destination, 2)
        XCTAssertEqual(result[2].count, 39)
        XCTAssertEqual(result[2].source, 9)
        XCTAssertEqual(result[2].destination, 299)
    }

    func testCraneMoveOne() {
        // given
        let crane = Puzzle5.Crane(
            stacks: [
                .init(items: ["W"]),
                .init(items: [])
            ],
            actions: [
                .init(count: 1, source: 0, destination: 1)
            ],
            canHandleMultipleCrates: false
        )

        // when
        crane.moveItems()

        // then
        XCTAssertEqual(crane.stacks[0].items, [])
        XCTAssertEqual(crane.stacks[1].items, ["W"])
    }

    func testCraneMoveABunch() {
        // given
        let crane = Puzzle5.Crane(
            stacks: [
                .init(items: ["W", "J", "K"]),
                .init(items: [])
            ],
            actions: [
                .init(count: 2, source: 0, destination: 1)
            ],
            canHandleMultipleCrates: false
        )

        // when
        crane.moveItems()

        // then
        XCTAssertEqual(crane.stacks[0].items, ["K"])
        XCTAssertEqual(crane.stacks[1].items, ["J", "W"])
    }

    func testCraneMoveABunchCanHandleMultipleCrates() {
        // given
        let crane = Puzzle5.Crane(
            stacks: [
                .init(items: ["W", "J", "K"]),
                .init(items: [])
            ],
            actions: [
                .init(count: 2, source: 0, destination: 1)
            ],
            canHandleMultipleCrates: true
        )

        // when
        crane.moveItems()

        // then
        XCTAssertEqual(crane.stacks[0].items, ["K"])
        XCTAssertEqual(crane.stacks[1].items, ["W", "J"])
    }

    func testCraneMoveFromTheLast() {
        // given
        let crane = Puzzle5.Crane(
            stacks: [
                .init(items: ["W", "J", "K"]),
                .init(items: ["O"])
            ],
            actions: [
                .init(count: 1, source: 1, destination: 0)
            ],
            canHandleMultipleCrates: false
        )

        // when
        crane.moveItems()

        // then
        XCTAssertEqual(crane.stacks[0].items, ["O", "W", "J", "K"])
        XCTAssertEqual(crane.stacks[1].items, [])
    }

    func testCraneMoveMultipleSteps() {
        // given
        let crane = Puzzle5.Crane(
            stacks: [
                .init(items: ["W", "J", "K"]),
                .init(items: ["O"])
            ],
            actions: [
                .init(count: 1, source: 0, destination: 1),
                .init(count: 1, source: 0, destination: 1),
                .init(count: 1, source: 0, destination: 1)
            ],
            canHandleMultipleCrates: false
        )

        // when
        crane.moveItems()

        // then
        XCTAssertEqual(crane.stacks[0].items, [])
        XCTAssertEqual(crane.stacks[1].items, ["K", "J", "W", "O"])
    }

    func testCraneMoveMultipleStepsBackAndForth() {
        // given
        let crane = Puzzle5.Crane(
            stacks: [
                .init(items: ["W", "J", "K"]),
                .init(items: ["O"]),
                .init(items: ["D"])
            ],
            actions: [
                .init(count: 3, source: 0, destination: 1),
                .init(count: 2, source: 1, destination: 2),
                .init(count: 1, source: 2, destination: 0)
            ],
            canHandleMultipleCrates: false
        )

        // when
        crane.moveItems()

        // then
        XCTAssertEqual(crane.stacks[0].items, ["J"])
        XCTAssertEqual(crane.stacks[1].items, ["W", "O"])
        XCTAssertEqual(crane.stacks[2].items, ["K", "D"])
    }

    func testPuzzle5Test() {
        XCTAssertEqual(Puzzle5.solve(fileName: "Input5Test", canHandleMultipleCrates: false), "CMZ")
    }

    func testPuzzle5TestPart2() {
        XCTAssertEqual(Puzzle5.solve(fileName: "Input5Test", canHandleMultipleCrates: true), "MCD")
    }

    func testPuzzle5() {
        XCTAssertEqual(Puzzle5.solve(fileName: "Input5", canHandleMultipleCrates: false), "RLFNRTNFB")
    }

    func testPuzzle5Part2() {
        XCTAssertEqual(Puzzle5.solve(fileName: "Input5", canHandleMultipleCrates: true), "MHQTLJRLB")
    }
}
