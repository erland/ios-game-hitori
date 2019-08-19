//
//  BruteForceSolverBoardTests.swift
//  HitoriTests
//
//  Created by Erland Isaksson on 2019-08-18.
//  Copyright © 2019 Erland Isaksson. All rights reserved.
//

import XCTest
@testable import Hitori

class BruteForceSovlerBoardTests: XCTestCase {
    
    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    
    func test_solve() {
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
        
        let board = BruteForceSolverBoard(boardString: numbers.joined())
        XCTAssert(board.solve())
        XCTAssert(board.solutions.count == 1)
        if board.solutions.count>0 {
            XCTAssert(board.solutions[0] == selections.joined())
        }
    }
}

