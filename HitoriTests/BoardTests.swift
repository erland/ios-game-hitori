//
//  HitoriTests.swift
//  HitoriTests
//
//  Created by Erland Isaksson on 2019-08-16.
//  Copyright © 2019 Erland Isaksson. All rights reserved.
//

import XCTest
@testable import Hitori

class HitoriTests: XCTestCase {

    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func test_isValid() {
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
        
        let board = Board(name: "test", boardNumbers: numbers.joined())
        board.initializeStates(stateIndications: selections.joined())
        XCTAssert(board.isValidBoard())
    }

    func test_isValidWithCandidates() {
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
        
        let board = Board(name: "test", boardNumbers: numbers.joined())
        board.initializeStates(stateIndications: selections.joined())
        XCTAssert(board.isValidBoard())
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
            "_____",
            "_____",
            "_____",
            "_____",
            "_X___"
        ]

        let board = Board(name: "test", boardNumbers: numbers.joined())
        board.initializeStates(stateIndications: selections.joined())
        XCTAssert(!board.isValidBoard())
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
            "_____",
            "_____",
            "_____",
            "_____",
            "____X"
        ]
        
        let board = Board(name: "test", boardNumbers: numbers.joined())
        board.initializeStates(stateIndications: selections.joined())
        XCTAssert(!board.isValidBoard())
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
            "_____",
            "_____",
            "_____",
            "_____",
            "__X__"
        ]
        
        let board = Board(name: "test", boardNumbers: numbers.joined())
        board.initializeStates(stateIndications: selections.joined())
        XCTAssert(!board.isValidBoard())
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
            "_____",
            "X____",
            "_____",
            "_____",
            "_____"
        ]
        
        let board = Board(name: "test", boardNumbers: numbers.joined())
        board.initializeStates(stateIndications: selections.joined())
        XCTAssert(!board.isValidBoard())
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
            "_____",
            "_____",
            "_____",
            "__X__",
            "_____"
        ]
        
        let board = Board(name: "test", boardNumbers: numbers.joined())
        board.initializeStates(stateIndications: selections.joined())
        XCTAssert(!board.isValidBoard())
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
            "_____",
            "__X__",
            "_____",
            "_____",
            "_____"
        ]
        
        let board = Board(name: "test", boardNumbers: numbers.joined())
        board.initializeStates(stateIndications: selections.joined())
        XCTAssert(!board.isValidBoard())
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
            "_____",
            "XX___",
            "_____",
            "_____",
            "_____"
        ]
        
        let board = Board(name: "test", boardNumbers: numbers.joined())
        board.initializeStates(stateIndications: selections.joined())
        XCTAssert(!board.isValidBoard())
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
            "_____",
            "___XX",
            "_____",
            "_____",
            "_____"
        ]
        
        let board = Board(name: "test", boardNumbers: numbers.joined())
        board.initializeStates(stateIndications: selections.joined())
        XCTAssert(!board.isValidBoard())
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
            "_____",
            "__XX_",
            "_____",
            "_____",
            "_____"
        ]
        
        let board = Board(name: "test", boardNumbers: numbers.joined())
        board.initializeStates(stateIndications: selections.joined())
        XCTAssert(!board.isValidBoard())
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
            "_X___",
            "_X___",
            "_____",
            "_____",
            "_____"
        ]
        
        let board = Board(name: "test", boardNumbers: numbers.joined())
        board.initializeStates(stateIndications: selections.joined())
        XCTAssert(!board.isValidBoard())
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
            "_____",
            "_____",
            "_____",
            "___X_",
            "___X_"
        ]
        
        let board = Board(name: "test", boardNumbers: numbers.joined())
        board.initializeStates(stateIndications: selections.joined())
        XCTAssert(!board.isValidBoard())
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
            "_____",
            "__X__",
            "__X__",
            "_____",
            "_____"
        ]
        
        let board = Board(name: "test", boardNumbers: numbers.joined())
        board.initializeStates(stateIndications: selections.joined())
        XCTAssert(!board.isValidBoard())
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
            "__X__",
            "_X___",
            "X____",
            "_____",
            "_____"
        ]
        
        let board = Board(name: "test", boardNumbers: numbers.joined())
        board.initializeStates(stateIndications: selections.joined())
        XCTAssert(!board.isValidBoard())
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
            "__X__",
            "_X_X_",
            "X___X",
            "_X_X_",
            "__X__"
        ]
        
        let board = Board(name: "test", boardNumbers: numbers.joined())
        board.initializeStates(stateIndications: selections.joined())
        XCTAssert(!board.isValidBoard())
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
            "__?__",
            "_X_X_",
            "X___X",
            "_X_X_",
            "__?__"
        ]
        
        let board = Board(name: "test", boardNumbers: numbers.joined())
        board.initializeStates(stateIndications: selections.joined())
        XCTAssert(board.isValidBoard())
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
            "__X__",
            "_X_X_",
            "?___?",
            "_X_X_",
            "__X__"
        ]
        
        let board = Board(name: "test", boardNumbers: numbers.joined())
        board.initializeStates(stateIndications: selections.joined())
        XCTAssert(board.isValidBoard())
    }
}
