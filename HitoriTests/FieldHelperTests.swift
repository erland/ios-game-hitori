//
//  FieldHelperTests.swift
//  HitoriTests
//
//  Created by Erland Isaksson on 2019-08-20.
//  Copyright © 2019 Erland Isaksson. All rights reserved.
//

import XCTest
@testable import Hitori

class FieldHelperTests: XCTestCase {

    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func test_OpenField() {
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
        XCTAssertEqual(FieldHelper(board: board).sizeOfField(0,0),19)
        
    }

    func test_OpenFieldWithUnselected() {
        let numbers = [
            "1 2 3 4 5",
            "2 3 4 5 1",
            "3 4 5 1 2",
            "4 5 1 2 3",
            "5 1 2 3 4"
        ]
        let selections = [
            "_ _ ? _ _",
            "_ X _ X _",
            "? _ _ _ ?",
            "_ X _ X _",
            "_ _ ? _ _"
        ]
        
        let board = AbstractSolverBoard(boardString: numbers.joined())
        board.initializeSelections(selectionString: selections.joined())
        XCTAssertEqual(FieldHelper(board: board).sizeOfField(0,0),21)
        
    }

    func test_ClosedField() {
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
            "X _ _ _ X",
            "_ X _ X _",
            "_ _ X _ _"
        ]
        
        let board = AbstractSolverBoard(boardString: numbers.joined())
        board.initializeSelections(selectionString: selections.joined())
        XCTAssertEqual(FieldHelper(board: board).sizeOfField(2,2),5)
        XCTAssertEqual(FieldHelper(board: board).sizeOfField(0,0),3)
        XCTAssertEqual(FieldHelper(board: board).sizeOfField(4,0),3)
        XCTAssertEqual(FieldHelper(board: board).sizeOfField(0,4),3)
        XCTAssertEqual(FieldHelper(board: board).sizeOfField(4,4),3)
    }
    
    func test_Performance() {
        let numbers = [
            "1 2 3 4 5",
            "2 3 4 5 1",
            "3 4 5 1 2",
            "4 5 1 2 3",
            "5 1 2 3 4"
        ]
        let selections = [
            "_ _ ? _ _",
            "_ X _ X _",
            "? _ ? _ ?",
            "_ X _ X _",
            "_ _ ? _ _"
        ]
        
        let board = AbstractSolverBoard(boardString: numbers.joined())
        board.initializeSelections(selectionString: selections.joined())
        var size = 0
        let fieldHelper = FieldHelper(board: board)
        self.measure {
            for _ in 0..<10000 {
                size = fieldHelper.sizeOfField(2,2)
            }
        }
        XCTAssertEqual(size, 21)
        
    }


}
