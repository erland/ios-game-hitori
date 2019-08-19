//
//  TwoPairsAtBorderTest.swift
//  HitoriTests
//
//  Created by Erland Isaksson on 2019-08-17.
//  Copyright © 2019 Erland Isaksson. All rights reserved.
//

import XCTest
@testable import Hitori

class TwoPairsAtBorderTest: XCTestCase {

    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func test_Top_Horizontal() {
        let numbers = [
            "12245",
            "23351",
            "34512",
            "15143",
            "21254"
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
        XCTAssert(TwoPairsAtBorder().solvePosition(board: board, x: 0, y: 0))
    }

func test_Bottom_Horizontal() {
    let numbers = [
        "15343",
        "21454",
        "34512",
        "45113",
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
    XCTAssert(TwoPairsAtBorder().solvePosition(board: board, x: 4, y: 3))
}
    func test_Left_Vertical() {
        let numbers = [
            "12345",
            "23231",
            "35512",
            "35123",
            "51514"
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
        XCTAssert(TwoPairsAtBorder().solvePosition(board: board, x: 1, y: 1))
    }
    
    func test_Right_Vertical() {
        let numbers = [
            "14545",
            "23412",
            "34512",
            "42323",
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
        XCTAssert(TwoPairsAtBorder().solvePosition(board: board, x: 4, y: 3))
    }

}
