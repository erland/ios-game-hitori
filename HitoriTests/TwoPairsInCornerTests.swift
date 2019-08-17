//
//  TwoPairsInCornerTests.swift
//  HitoriTests
//
//  Created by Erland Isaksson on 2019-08-17.
//  Copyright © 2019 Erland Isaksson. All rights reserved.
//

import XCTest
@testable import Hitori

class TwoPairsInCornerTests: XCTestCase {

    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func test_TopLeftCorner_Horizontal() {
        let numbers = [
            "11345",
            "22451",
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
        XCTAssert(TwoPairsInCorner().solvePosition(board: board, x: 0, y: 0))
    }

    func test_TopLeftCorner_Vertical() {
        let numbers = [
            "12345",
            "12451",
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
        XCTAssert(TwoPairsInCorner().solvePosition(board: board, x: 1, y: 1))
    }

    func test_TopRightCorner_Horizontal() {
        let numbers = [
            "12355",
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
        XCTAssert(TwoPairsInCorner().solvePosition(board: board, x: 4, y: 0))
    }
    
    func test_TopRightCorner_Vertical() {
        let numbers = [
            "12351",
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
        XCTAssert(TwoPairsInCorner().solvePosition(board: board, x: 3, y: 1))
    }

    func test_BottomLeftCorner_Horizontal() {
        let numbers = [
            "12345",
            "23451",
            "34512",
            "55123",
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
        XCTAssert(TwoPairsInCorner().solvePosition(board: board, x: 0, y: 4))
    }
    
    func test_BottomLeftCorner_Vertical() {
        let numbers = [
            "12345",
            "23451",
            "34512",
            "45123",
            "45234"
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
        XCTAssert(TwoPairsInCorner().solvePosition(board: board, x: 1, y: 3))
    }
    
    func test_BottomRightCorner_Horizontal() {
        let numbers = [
            "12345",
            "23451",
            "34512",
            "45122",
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
        XCTAssert(TwoPairsInCorner().solvePosition(board: board, x: 4, y: 4))
    }
    
    func test_BottomRightCorner_Vertical() {
        let numbers = [
            "12345",
            "23451",
            "34512",
            "45134",
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
        XCTAssert(TwoPairsInCorner().solvePosition(board: board, x: 3, y: 3))
    }
}
