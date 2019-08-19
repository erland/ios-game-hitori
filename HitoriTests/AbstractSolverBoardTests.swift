//
//  AbstractSolverBoardTests.swift
//  HitoriTests
//
//  Created by Erland Isaksson on 2019-08-16.
//  Copyright © 2019 Erland Isaksson. All rights reserved.
//

import XCTest
@testable import Hitori

class AbstractSolverBoardTests: XCTestCase {

    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func isValid(_ board: AbstractSolverBoard) -> Bool {
        for x in 0..<board.size {
            for y in 0..<board.size {
                if let value = board.valueAt(x, y) {
                    if let selected = value.selected {
                        if !board.isValid(x: x, y: y, selected: selected) {
                            return false
                        }
                    }
                }
            }
        }
        return true
    }
    
    func test_isValid_Empty_Board() {
        let numbers = [
            "12345",
            "23451",
            "34512",
            "45123",
            "51234"
        ]
        let selections = [
            "?????",
            "?????",
            "?????",
            "?????",
            "?????"
        ]
        
        let board = AbstractSolverBoard(boardString: numbers.joined())
        board.initializeSelections(selectionString: selections.joined())
        XCTAssert(isValid(board))
    }
    
    func test_isValid_Filled_With_Selected() {
        let numbers = [
            "33445",
            "45132",
            "34214",
            "53541",
            "52543"
        ]
        let selections = [
            "_X_X_",
            "_____",
            "X___X",
            "__X__",
            "X__X_"
        ]
        
        let board = AbstractSolverBoard(boardString: numbers.joined())
        board.initializeSelections(selectionString: selections.joined())
        XCTAssert(isValid(board))
    }

    func test_isValid_Filled_With_Selected_And_Unselected() {
        let numbers = [
            "33445",
            "45132",
            "34214",
            "53541",
            "52543"
        ]
        let selections = [
            "?X?X?",
            "?????",
            "X???X",
            "??X??",
            "X??X?"
        ]
        
        let board = AbstractSolverBoard(boardString: numbers.joined())
        board.initializeSelections(selectionString: selections.joined())
        XCTAssert(isValid(board))
    }

    func test_isValid_Filled_With_Unselected() {
        let numbers = [
            "33445",
            "45132",
            "34214",
            "53541",
            "52543"
        ]
        let selections = [
            "?_?_?",
            "?????",
            "_???_",
            "??_??",
            "_??_?"
        ]
        
        let board = AbstractSolverBoard(boardString: numbers.joined())
        board.initializeSelections(selectionString: selections.joined())
        XCTAssert(isValid(board))
    }

    func test_isValid_Negative_PairInBeginningOfRow() {
        let numbers = [
            "11345",
            "23451",
            "34512",
            "45123",
            "51234"
        ]
        let selections = [
            "?????",
            "?????",
            "?????",
            "?????",
            "?X???"
        ]
        
        let board = AbstractSolverBoard(boardString: numbers.joined())
        board.initializeSelections(selectionString: selections.joined())
        XCTAssert(!isValid(board))
    }
    
    func test_isValid_Negative_PairInEndOfRow() {
        let numbers = [
            "12344",
            "23451",
            "34512",
            "45123",
            "51234"
        ]
        let selections = [
            "?????",
            "?????",
            "?????",
            "?????",
            "????X"
        ]
        
        let board = AbstractSolverBoard(boardString: numbers.joined())
        board.initializeSelections(selectionString: selections.joined())
        XCTAssert(!isValid(board))
    }
    
    func test_isValid_Negative_PairMiddleOfRow() {
        let numbers = [
            "12245",
            "23451",
            "34512",
            "45123",
            "51234"
        ]
        let selections = [
            "?????",
            "?????",
            "?????",
            "?????",
            "??X??"
        ]
        
        let board = AbstractSolverBoard(boardString: numbers.joined())
        board.initializeSelections(selectionString: selections.joined())
        XCTAssert(!isValid(board))
    }
    
    func test_isValid_Negative_PairTopOfColumn() {
        let numbers = [
            "12345",
            "22451",
            "34512",
            "45123",
            "51234"
        ]
        let selections = [
            "?????",
            "X????",
            "?????",
            "?????",
            "?????"
        ]
        
        let board = AbstractSolverBoard(boardString: numbers.joined())
        board.initializeSelections(selectionString: selections.joined())
        XCTAssert(!isValid(board))
    }
    
    func test_isValid_Negative_PairBottomOfColumn() {
        let numbers = [
            "12345",
            "23451",
            "34512",
            "41123",
            "51234"
        ]
        let selections = [
            "?????",
            "?????",
            "?????",
            "??X??",
            "?????"
        ]
        
        let board = AbstractSolverBoard(boardString: numbers.joined())
        board.initializeSelections(selectionString: selections.joined())
        XCTAssert(!isValid(board))
    }
    
    func test_isValid_Negative_PairMiddleOfColumn() {
        let numbers = [
            "12345",
            "24451",
            "34512",
            "45123",
            "51234"
        ]
        let selections = [
            "?????",
            "??X??",
            "?????",
            "?????",
            "?????"
        ]
        
        let board = AbstractSolverBoard(boardString: numbers.joined())
        board.initializeSelections(selectionString: selections.joined())
        XCTAssert(!isValid(board))
    }
    
    func test_isValid_Negative_PairSelectedLeftOfRow() {
        let numbers = [
            "12345",
            "23451",
            "34512",
            "45123",
            "51234"
        ]
        let selections = [
            "?????",
            "XX???",
            "?????",
            "?????",
            "?????"
        ]
        
        let board = AbstractSolverBoard(boardString: numbers.joined())
        board.initializeSelections(selectionString: selections.joined())
        XCTAssert(!isValid(board))
    }
    
    func test_isValid_Negative_PairSelectedRightOfRow() {
        let numbers = [
            "12345",
            "23451",
            "34512",
            "45123",
            "51234"
        ]
        let selections = [
            "?????",
            "???XX",
            "?????",
            "?????",
            "?????"
        ]
        
        let board = AbstractSolverBoard(boardString: numbers.joined())
        board.initializeSelections(selectionString: selections.joined())
        XCTAssert(!isValid(board))
    }
    
    func test_isValid_Negative_PairSelectedMiddleOfRow() {
        let numbers = [
            "12345",
            "23451",
            "34512",
            "45123",
            "51234"
        ]
        let selections = [
            "?????",
            "??XX?",
            "?????",
            "?????",
            "?????"
        ]
        
        let board = AbstractSolverBoard(boardString: numbers.joined())
        board.initializeSelections(selectionString: selections.joined())
        XCTAssert(!isValid(board))
    }
    
    func test_isValid_Negative_PairSelectedTopOfColumn() {
        let numbers = [
            "12345",
            "23451",
            "34512",
            "45123",
            "51234"
        ]
        let selections = [
            "?X???",
            "?X???",
            "?????",
            "?????",
            "?????"
        ]
        
        let board = AbstractSolverBoard(boardString: numbers.joined())
        board.initializeSelections(selectionString: selections.joined())
        XCTAssert(!isValid(board))
    }
    
    func test_isValid_Negative_PairSelectedBottomOfColumn() {
        let numbers = [
            "12345",
            "23451",
            "34512",
            "45123",
            "51234"
        ]
        let selections = [
            "?????",
            "?????",
            "?????",
            "???X?",
            "???X?"
        ]
        
        let board = AbstractSolverBoard(boardString: numbers.joined())
        board.initializeSelections(selectionString: selections.joined())
        XCTAssert(!isValid(board))
    }
    
    func test_isValid_Negative_PairSelectedMiddleOfColumn() {
        let numbers = [
            "12345",
            "23451",
            "34512",
            "45123",
            "51234"
        ]
        let selections = [
            "?????",
            "??X??",
            "??X??",
            "?????",
            "?????"
        ]
        
        let board = AbstractSolverBoard(boardString: numbers.joined())
        board.initializeSelections(selectionString: selections.joined())
        XCTAssert(!isValid(board))
    }
    
    func test_isValid_Negative_BoxedInCorner() {
        let numbers = [
            "12345",
            "23451",
            "34512",
            "45123",
            "51234"
        ]
        let selections = [
            "??X??",
            "?X???",
            "X????",
            "?????",
            "?????"
        ]
        
        let board = AbstractSolverBoard(boardString: numbers.joined())
        board.initializeSelections(selectionString: selections.joined())
        XCTAssert(!isValid(board))
    }
    
    func test_isValid_Negative_MultipleBoxedInCorners() {
        let numbers = [
            "12345",
            "23451",
            "34512",
            "45123",
            "51234"
        ]
        let selections = [
            "??X??",
            "?X?X?",
            "X???X",
            "?X?X?",
            "??X??"
        ]
        
        let board = AbstractSolverBoard(boardString: numbers.joined())
        board.initializeSelections(selectionString: selections.joined())
        XCTAssert(!isValid(board))
    }
    
    func test_isValid_MultipleOpenBoxedInCornersOpenTopBottom() {
        let numbers = [
            "12345",
            "23451",
            "34512",
            "45123",
            "51234"
        ]
        let selections = [
            "?????",
            "?X?X?",
            "X???X",
            "?X?X?",
            "?????"
        ]
        
        let board = AbstractSolverBoard(boardString: numbers.joined())
        board.initializeSelections(selectionString: selections.joined())
        XCTAssert(isValid(board))
    }
    
    func test_isValid_MultipleOpenBoxedInCornersOpenLeftRight() {
        let numbers = [
            "12345",
            "23451",
            "34512",
            "45123",
            "51234"
        ]
        let selections = [
            "??X??",
            "?X?X?",
            "?????",
            "?X?X?",
            "??X??"
        ]
        
        let board = AbstractSolverBoard(boardString: numbers.joined())
        board.initializeSelections(selectionString: selections.joined())
        XCTAssert(isValid(board))
    }
}
