//
//  PairInductionTests.swift
//  HitoriTests
//
//  Created by Erland Isaksson on 2019-08-16.
//  Copyright © 2019 Erland Isaksson. All rights reserved.
//

import XCTest
@testable import Hitori

class PairInductionTests: XCTestCase {

    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func test_Negative_NoPairInRow() {
        let numbers = [
            "12345",
            "23451",
            "34512",
            "45123",
            "51234"
        ]
        let selections = [
            "_____",
            "_____",
            "_____",
            "_____",
            "_____"
        ]
        
        let board = AbstractSolverBoard(boardString: numbers.joined())
        board.initializeSelections(selectionString: selections.joined())
        XCTAssert(!PairInduction().solvePosition(board: board, x: 0, y: 1))
    }

    func test_PairLeftOfRow() {
        let numbers = [
            "12345",
            "33431",
            "34512",
            "45123",
            "51234"
        ]
        let selections = [
            "_____",
            "_____",
            "_____",
            "_____",
            "_____"
        ]
        
        let board = AbstractSolverBoard(boardString: numbers.joined())
        board.initializeSelections(selectionString: selections.joined())
        XCTAssert(PairInduction().solvePosition(board: board, x: 3, y: 1))
    }
    func test_PairMiddleOfRow() {
        let numbers = [
            "12345",
            "23353",
            "34512",
            "45123",
            "51234"
        ]
        let selections = [
            "_____",
            "_____",
            "_____",
            "_____",
            "_____"
        ]
        
        let board = AbstractSolverBoard(boardString: numbers.joined())
        board.initializeSelections(selectionString: selections.joined())
        XCTAssert(PairInduction().solvePosition(board: board, x: 4, y: 1))
    }

    func test_PairRightOfRow() {
        let numbers = [
            "12345",
            "21411",
            "34512",
            "45123",
            "51234"
        ]
        let selections = [
            "_____",
            "_____",
            "_____",
            "_____",
            "_____"
        ]
        
        let board = AbstractSolverBoard(boardString: numbers.joined())
        board.initializeSelections(selectionString: selections.joined())
        XCTAssert(PairInduction().solvePosition(board: board, x: 1, y: 1))
    }
    
    func test_Negative_TripletOnRow() {
        let numbers = [
            "12345",
            "23111",
            "34512",
            "45123",
            "51234"
        ]
        let selections = [
            "_____",
            "_____",
            "_____",
            "_____",
            "_____"
        ]
        
        let board = AbstractSolverBoard(boardString: numbers.joined())
        board.initializeSelections(selectionString: selections.joined())
        XCTAssert(!PairInduction().solvePosition(board: board, x: 2, y: 1))
    }

    func test_PairMTopOfColumn() {
        let numbers = [
            "12345",
            "42451",
            "34512",
            "42123",
            "51234"
        ]
        let selections = [
            "_____",
            "_____",
            "_____",
            "_____",
            "_____"
        ]
        
        let board = AbstractSolverBoard(boardString: numbers.joined())
        board.initializeSelections(selectionString: selections.joined())
        XCTAssert(PairInduction().solvePosition(board: board, x: 1, y: 3))
    }
    func test_PairMiddleOfColumn() {
        let numbers = [
            "14345",
            "23451",
            "34512",
            "14123",
            "51234"
        ]
        let selections = [
            "_____",
            "_____",
            "_____",
            "_____",
            "_____"
        ]
        
        let board = AbstractSolverBoard(boardString: numbers.joined())
        board.initializeSelections(selectionString: selections.joined())
        XCTAssert(PairInduction().solvePosition(board: board, x: 1, y: 0))
    }
    
    func test_PairBottomOfColumn() {
        let numbers = [
            "12345",
            "21451",
            "34512",
            "41323",
            "51234"
        ]
        let selections = [
            "_____",
            "_____",
            "_____",
            "_____",
            "_____"
        ]
        
        let board = AbstractSolverBoard(boardString: numbers.joined())
        board.initializeSelections(selectionString: selections.joined())
        XCTAssert(PairInduction().solvePosition(board: board, x: 1, y: 1))
    }
    
    func test_Negative_TripletOnColumn() {
        let numbers = [
            "12345",
            "23451",
            "33512",
            "43123",
            "51234"
        ]
        let selections = [
            "_____",
            "_____",
            "_____",
            "_____",
            "_____"
        ]
        
        let board = AbstractSolverBoard(boardString: numbers.joined())
        board.initializeSelections(selectionString: selections.joined())
        XCTAssert(!PairInduction().solvePosition(board: board, x: 1, y: 1))
    }
}
