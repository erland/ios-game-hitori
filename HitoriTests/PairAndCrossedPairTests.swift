//
//  PairAndCrossedPairTests.swift
//  HitoriTests
//
//  Created by Erland Isaksson on 2019-08-17.
//  Copyright © 2019 Erland Isaksson. All rights reserved.
//

import XCTest
@testable import Hitori

class PairAndCrossedPairTests: XCTestCase {
    
    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    
    func test_Vertical_Middle_PairAboveUpwardCross() {
        let numbers = [
            "12345",
            "23451",
            "34542",
            "45323",
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
        XCTAssert(PairAndCrossedPair().solvePosition(board: board, x: 3, y: 3))
        XCTAssert(!(board.valueAt(2,2)?.selected ?? true))
        XCTAssert(!(board.valueAt(3,3)?.selected ?? true))
    }

    func test_Vertical_Middle_PairBelowDownwardCross() {
        let numbers = [
            "12345",
            "23151",
            "34522",
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
        XCTAssert(PairAndCrossedPair().solvePosition(board: board, x: 2, y: 2))
        XCTAssert(!(board.valueAt(2,2)?.selected ?? true))
        XCTAssert(!(board.valueAt(3,1)?.selected ?? true))
    }

    func test_Horizontal_Middle_PairLeftUpwardCross() {
        let numbers = [
            "12345",
            "23451",
            "34532",
            "45423",
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
        XCTAssert(PairAndCrossedPair().solvePosition(board: board, x: 3, y: 3))
        XCTAssert(!(board.valueAt(2,2)?.selected ?? true))
        XCTAssert(!(board.valueAt(3,3)?.selected ?? true))
    }
    
    func test_Horizontal_Middle_PairRightDownwardCross() {
        let numbers = [
            "12345",
            "23451",
            "32512",
            "45323",
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
        XCTAssert(PairAndCrossedPair().solvePosition(board: board, x: 1, y: 3))
        XCTAssert(!(board.valueAt(1,3)?.selected ?? true))
        XCTAssert(!(board.valueAt(2,2)?.selected ?? true))
    }
}

