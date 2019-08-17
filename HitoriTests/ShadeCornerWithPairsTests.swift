//
//  ShadeCornerWithPairsTests.swift
//  HitoriTests
//
//  Created by Erland Isaksson on 2019-08-17.
//  Copyright © 2019 Erland Isaksson. All rights reserved.
//

import XCTest
@testable import Hitori

class ShadeCornerWithPairsTests: XCTestCase {

    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func test_BottomRightCorner() {
        let numbers = [
            "12345",
            "23451",
            "34512",
            "45123",
            "51233"
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
        XCTAssert(ShadeCornerWithPairs().solvePosition(board: board, x: 4, y: 4))
    }

    func test_BottomLeftCorner() {
        let numbers = [
            "12345",
            "23451",
            "34512",
            "15123",
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
        XCTAssert(ShadeCornerWithPairs().solvePosition(board: board, x: 0, y: 4))
    }

    func test_TopRightCorner() {
        let numbers = [
            "12344",
            "23454",
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
        XCTAssert(ShadeCornerWithPairs().solvePosition(board: board, x: 4, y: 0))
    }

    func test_TopLeftCorner() {
        let numbers = [
            "22345",
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
        XCTAssert(ShadeCornerWithPairs().solvePosition(board: board, x: 0, y: 0))
    }

    func test_Negative_BottomRightCorner_PairInRow() {
        let numbers = [
            "12345",
            "23451",
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
        XCTAssert(!ShadeCornerWithPairs().solvePosition(board: board, x: 4, y: 4))
    }

    func test_Negative_BottomRightCorner_PairInColumn() {
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
        XCTAssert(!ShadeCornerWithPairs().solvePosition(board: board, x: 4, y: 4))
    }

    func test_Negative_BottomLeftCorner_PairInRow() {
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
        XCTAssert(!ShadeCornerWithPairs().solvePosition(board: board, x: 0, y: 4))
    }
    
    func test_Negative_BottomLeftCorner_PairInColumn() {
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
        XCTAssert(!ShadeCornerWithPairs().solvePosition(board: board, x: 0, y: 4))
    }
    
    func test_Negative_TopLeftCorner_PairInRow() {
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
        XCTAssert(!ShadeCornerWithPairs().solvePosition(board: board, x: 0, y: 0))
    }
    
    func test_Negative_TopLeftCorner_PairInColumn() {
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
        XCTAssert(!ShadeCornerWithPairs().solvePosition(board: board, x: 0, y: 0))
    }
 
    func test_Negative_TopRightCorner_PairInRow() {
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
        XCTAssert(!ShadeCornerWithPairs().solvePosition(board: board, x: 4, y: 0))
    }
    
    func test_Negative_TopRightCorner_PairInColumn() {
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
        XCTAssert(!ShadeCornerWithPairs().solvePosition(board: board, x: 4, y: 0))
    }
}
