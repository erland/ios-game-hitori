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

    func test_Negative_OpeningOnLeft_WithNoDirectEffect() {
        let numbers = [
            "1 2 3 4 5",
            "2 3 4 5 1",
            "3 4 5 1 2",
            "4 5 1 2 3",
            "5 1 2 3 4"
        ]
        let selections = [
            "_ _ X _ _",
            "_ X _ X _",
            "_ _ _ _ _",
            "_ X _ X _",
            "_ _ X _ _"
        ]
        
        let board = AbstractSolverBoard(boardString: numbers.joined())
        board.initializeSelections(selectionString: selections.joined())
        XCTAssert(!UnshadeToAvoidPartition().solvePosition(board: board, x: 4, y: 2))
        
    }

    func test_OpeningOnLeft() {
        let numbers = [
            "1 2 3 4 5",
            "2 3 4 5 1",
            "3 4 5 1 2",
            "4 5 1 2 3",
            "5 1 2 3 2"
        ]
        let selections = [
            "_ _ X _ _",
            "_ X _ X _",
            "_ _ _ _ _",
            "_ X _ X _",
            "_ _ X _ _"
        ]
        
        let board = AbstractSolverBoard(boardString: numbers.joined())
        board.initializeSelections(selectionString: selections.joined())
        XCTAssert(UnshadeToAvoidPartition().solvePosition(board: board, x: 4, y: 2))
        
    }

    func test_OpeningOnRight() {
        let numbers = [
            "1 2 3 4 5",
            "2 3 4 5 1",
            "3 4 5 1 3",
            "4 5 1 2 3",
            "5 1 2 3 4"
        ]
        let selections = [
            "_ _ X _ _",
            "_ X _ X _",
            "_ _ _ _ _",
            "_ X _ X _",
            "_ _ X _ _"
        ]

        let board = AbstractSolverBoard(boardString: numbers.joined())
        board.initializeSelections(selectionString: selections.joined())
        XCTAssert(UnshadeToAvoidPartition().solvePosition(board: board, x: 0, y: 2))
    }

    func test_OpeningOnTop() {
        let numbers = [
            "1 2 3 4 5",
            "2 3 4 5 1",
            "3 4 5 1 2",
            "4 5 1 2 3",
            "5 1 3 3 4"
        ]
        let selections = [
            "_ _ _ _ _",
            "_ X _ X _",
            "X _ _ _ X",
            "_ X _ X _",
            "_ _ _ _ _"
        ]
        
        let board = AbstractSolverBoard(boardString: numbers.joined())
        board.initializeSelections(selectionString: selections.joined())
        XCTAssert(UnshadeToAvoidPartition().solvePosition(board: board, x: 2, y: 0))
    }

    func test_OpeningOnBottom() {
        let numbers = [
            "1 2 3 4 5",
            "2 3 4 5 1",
            "3 4 2 1 2",
            "4 5 1 2 3",
            "5 1 2 3 4"
        ]
        let selections = [
            "_ _ _ _ _",
            "_ X _ X _",
            "X _ _ _ X",
            "_ X _ X _",
            "_ _ _ _ _"
        ]
        
        let board = AbstractSolverBoard(boardString: numbers.joined())
        board.initializeSelections(selectionString: selections.joined())
        XCTAssert(UnshadeToAvoidPartition().solvePosition(board: board, x: 2, y: 4))
    }

    func test_Negative_MultipleOpenings() {
        let numbers = [
            "1 2 3 4 5",
            "2 3 4 5 1",
            "3 4 2 1 2",
            "4 5 1 2 3",
            "5 1 2 3 4"
        ]
        let selections = [
            "_ _ _ _ _",
            "_ X _ X _",
            "_ _ _ _ _",
            "_ X _ X _",
            "_ _ _ _ _"
        ]
        
        let board = AbstractSolverBoard(boardString: numbers.joined())
        board.initializeSelections(selectionString: selections.joined())
        XCTAssert(!UnshadeToAvoidPartition().solvePosition(board: board, x: 2, y: 4))
    }
}
