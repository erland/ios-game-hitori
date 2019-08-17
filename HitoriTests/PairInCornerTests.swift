//
//  PairInCornerTests.swift
//  HitoriTests
//
//  Created by Erland Isaksson on 2019-08-17.
//  Copyright © 2019 Erland Isaksson. All rights reserved.
//

import XCTest
@testable import Hitori

class PairInCornerTests: XCTestCase {

    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func test_TopLeft_PairUpperRow() {
        let numbers = [
            "11345",
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
        XCTAssert(PairInCorner().solvePosition(board: board, x: 0, y: 1))
        XCTAssert(!(board.valueAt(0,1)?.selected ?? true))
    }

    func test_TopLeft_PairLowerRow() {
        let numbers = [
            "12345",
            "33451",
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
        XCTAssert(PairInCorner().solvePosition(board: board, x: 1, y: 0))
        XCTAssert(!(board.valueAt(1,0)?.selected ?? true))
    }
    
    func test_TopLeft_PairLeftColumn() {
        let numbers = [
            "12345",
            "13451",
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
        XCTAssert(PairInCorner().solvePosition(board: board, x: 1, y: 0))
        XCTAssert(!(board.valueAt(1,0)?.selected ?? true))
    }
    func test_TopLeft_PairRightColumn() {
        let numbers = [
            "13345",
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
        XCTAssert(PairInCorner().solvePosition(board: board, x: 0, y: 1))
        XCTAssert(!(board.valueAt(0,1)?.selected ?? true))
    }

    func test_TopLRight_PairUpperRow() {
        let numbers = [
            "12344",
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
        XCTAssert(PairInCorner().solvePosition(board: board, x: 4, y: 1))
        XCTAssert(!(board.valueAt(4,1)?.selected ?? true))
    }
    
    func test_TopRight_PairLowerRow() {
        let numbers = [
            "12345",
            "23411",
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
        XCTAssert(PairInCorner().solvePosition(board: board, x: 3, y: 0))
        XCTAssert(!(board.valueAt(3,0)?.selected ?? true))
    }
    
    func test_TopRight_PairLeftColumn() {
        let numbers = [
            "12345",
            "23441",
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
        XCTAssert(PairInCorner().solvePosition(board: board, x: 4, y: 1))
        XCTAssert(!(board.valueAt(4,1)?.selected ?? true))
    }
    func test_TopRight_PairRightColumn() {
        let numbers = [
            "12341",
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
        XCTAssert(PairInCorner().solvePosition(board: board, x: 3, y: 0))
        XCTAssert(!(board.valueAt(3,0)?.selected ?? true))
    }

    func test_BottomLeft_PairUpperRow() {
        let numbers = [
            "12345",
            "23451",
            "34512",
            "44123",
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
        XCTAssert(PairInCorner().solvePosition(board: board, x: 1, y: 4))
        XCTAssert(!(board.valueAt(1,4)?.selected ?? true))
    }
    
    func test_BottomLeft_PairLowerRow() {
        let numbers = [
            "12345",
            "23451",
            "34512",
            "45123",
            "11234"
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
        XCTAssert(PairInCorner().solvePosition(board: board, x: 0, y: 3))
        XCTAssert(!(board.valueAt(0,3)?.selected ?? true))
    }
    
    func test_BottomLeft_PairLeftColumn() {
        let numbers = [
            "12345",
            "23451",
            "34512",
            "45123",
            "41234"
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
        XCTAssert(PairInCorner().solvePosition(board: board, x: 1, y: 4))
        XCTAssert(!(board.valueAt(1,4)?.selected ?? true))
    }
    func test_BottomLeft_PairRightColumn() {
        let numbers = [
            "12345",
            "23451",
            "34512",
            "41123",
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
        XCTAssert(PairInCorner().solvePosition(board: board, x: 0, y: 3))
        XCTAssert(!(board.valueAt(0,3)?.selected ?? true))
    }
    
    func test_BottomRight_PairUpperRow() {
        let numbers = [
            "12345",
            "23451",
            "34512",
            "45122",
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
        XCTAssert(PairInCorner().solvePosition(board: board, x: 3, y: 4))
        XCTAssert(!(board.valueAt(3,4)?.selected ?? true))
    }
    
    func test_BottomRight_PairLowerRow() {
        let numbers = [
            "12345",
            "23412",
            "34512",
            "45123",
            "51244"
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
        XCTAssert(PairInCorner().solvePosition(board: board, x: 4, y: 3))
        XCTAssert(!(board.valueAt(4,3)?.selected ?? true))
    }
    
    func test_BottomRight_PairLeftColumn() {
        let numbers = [
            "12345",
            "23451",
            "34512",
            "45123",
            "51224"
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
        XCTAssert(PairInCorner().solvePosition(board: board, x: 4, y: 3))
        XCTAssert(!(board.valueAt(4,3)?.selected ?? true))
    }
    func test_BottomRight_PairRightColumn() {
        let numbers = [
            "12345",
            "23451",
            "34512",
            "45124",
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
        XCTAssert(PairInCorner().solvePosition(board: board, x: 3, y: 4))
        XCTAssert(!(board.valueAt(3,4)?.selected ?? true))
    }
}
