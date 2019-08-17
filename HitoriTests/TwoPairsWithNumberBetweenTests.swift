//
//  TwoPairsWithNumberBetweenTests.swift
//  HitoriTests
//
//  Created by Erland Isaksson on 2019-08-17.
//  Copyright © 2019 Erland Isaksson. All rights reserved.
//

import XCTest
@testable import Hitori

class TwoPairsWithNumberBetweenTests: XCTestCase {

    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func test_Horizontal_MiddleUpper() {
        let numbers = [
            "12345",
            "23252",
            "34513",
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
        XCTAssert(TwoPairsWithNumberBetween().solvePosition(board: board, x: 2, y: 1))
    }

    func test_Horizontal_MiddleLower() {
        let numbers = [
            "12345",
            "23452",
            "34313",
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
        XCTAssert(TwoPairsWithNumberBetween().solvePosition(board: board, x: 2, y: 2))
    }

    func test_Horizontal_Left() {
        let numbers = [
            "12345",
            "23252",
            "14313",
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
        XCTAssert(TwoPairsWithNumberBetween().solvePosition(board: board, x: 0, y: 1))
    }

    func test_Horizontal_Right() {
        let numbers = [
            "12345",
            "23451",
            "54512",
            "15121",
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
        XCTAssert(TwoPairsWithNumberBetween().solvePosition(board: board, x: 4, y: 3))
    }

    func test_Vertical_MiddleLeft() {
        let numbers = [
            "12345",
            "23451",
            "32512",
            "45123",
            "52314"
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
        XCTAssert(TwoPairsWithNumberBetween().solvePosition(board: board, x: 1, y: 2))
    }
    
    func test_Vertical_MiddleRight() {
        let numbers = [
            "12345",
            "23451",
            "34542",
            "45123",
            "51342"
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
        XCTAssert(TwoPairsWithNumberBetween().solvePosition(board: board, x: 3, y: 2))
    }
    
    func test_Vertical_Upper() {
        let numbers = [
            "15345",
            "23451",
            "35142",
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
        XCTAssert(TwoPairsWithNumberBetween().solvePosition(board: board, x: 1, y: 0))
    }
    
    func test_Vertical_Lower() {
        let numbers = [
            "12345",
            "23451",
            "34512",
            "43423",
            "51434"
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
        XCTAssert(TwoPairsWithNumberBetween().solvePosition(board: board, x: 2, y: 4))
    }
}
