//
//  UnshadeToAvoidPartitionTests.swift
//  HitoriTests
//
//  Created by Erland Isaksson on 2019-08-17.
//  Copyright © 2019 Erland Isaksson. All rights reserved.
//

import XCTest
@testable import Hitori

class UnshadeToAvoidPartitionTests: XCTestCase {

    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func test_OpeningOnLeft() {
        let numbers = [
            "12345",
            "23451",
            "34512",
            "45123",
            "51234"
        ]
        let selections = [
            "__X__",
            "_X_X_",
            "_____",
            "_X_X_",
            "__X__"
        ]
        
        let board = AbstractSolverBoard(boardString: numbers.joined())
        board.initializeSelections(selectionString: selections.joined())
        XCTAssert(UnshadeToAvoidPartition().solvePosition(board: board, x: 4, y: 2))
    }

    func test_OpeningOnRight() {
        let numbers = [
            "12345",
            "23451",
            "34512",
            "45123",
            "51234"
        ]
        let selections = [
            "__X__",
            "_X_X_",
            "_____",
            "_X_X_",
            "__X__"
        ]

        let board = AbstractSolverBoard(boardString: numbers.joined())
        board.initializeSelections(selectionString: selections.joined())
        XCTAssert(UnshadeToAvoidPartition().solvePosition(board: board, x: 0, y: 2))
    }

    func test_OpeningOnTop() {
        let numbers = [
            "12345",
            "23451",
            "34512",
            "45123",
            "51234"
        ]
        let selections = [
            "_____",
            "_X_X_",
            "X___X",
            "_X_X_",
            "_____"
        ]
        
        let board = AbstractSolverBoard(boardString: numbers.joined())
        board.initializeSelections(selectionString: selections.joined())
        XCTAssert(UnshadeToAvoidPartition().solvePosition(board: board, x: 2, y: 0))
    }

    func test_OpeningOnBottom() {
        let numbers = [
            "12345",
            "23451",
            "34512",
            "45123",
            "51234"
        ]
        let selections = [
            "_____",
            "_X_X_",
            "X___X",
            "_X_X_",
            "_____"
        ]
        
        let board = AbstractSolverBoard(boardString: numbers.joined())
        board.initializeSelections(selectionString: selections.joined())
        XCTAssert(UnshadeToAvoidPartition().solvePosition(board: board, x: 2, y: 4))
    }

    func test_Negative_MultipleOpenings() {
        let numbers = [
            "12345",
            "23451",
            "34512",
            "45123",
            "51234"
        ]
        let selections = [
            "_____",
            "_X_X_",
            "_____",
            "_X_X_",
            "_____"
        ]
        
        let board = AbstractSolverBoard(boardString: numbers.joined())
        board.initializeSelections(selectionString: selections.joined())
        XCTAssert(!UnshadeToAvoidPartition().solvePosition(board: board, x: 2, y: 4))
    }
}
