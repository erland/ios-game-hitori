//
//  LookForwardToAvoidPartitionTests.swift
//  HitoriTests
//
//  Created by Erland Isaksson on 2019-08-17.
//  Copyright © 2019 Erland Isaksson. All rights reserved.
//

import XCTest
@testable import Hitori

class LookForwardToAvoidPartitionTests: XCTestCase {

    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func test_PartitionCornerIfUnselected() {
        let numbers = [
            "34321",
            "23554",
            "41353",
            "33155",
            "45432"
        ]
        let selections = [
            "_____",
            "_____",
            "_?___",
            "?X?__",
            "_?___"
        ]
        
        let board = AbstractSolverBoard(boardString: numbers.joined())
        board.initializeSelections(selectionString: selections.joined())
        XCTAssert(LookForwardToAvoidPartition(techniques: [
            ShadingInRowsColumns()
            ]).solvePosition(board: board, x: 0, y: 4))
        XCTAssert((board.valueAt(0,4)?.selected ?? false))
    }
    
    func test_PartitionAtBorderIfSelected() {
        let numbers = [
            "23145",
            "45214",
            "33542",
            "54234",
            "52351"
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
        XCTAssert(LookForwardToAvoidPartition(techniques: [
            UnshadeAroundShaded(),
            ShadingInRowsColumns(),
            UnshadeToAvoidPartition()
            ]).solvePosition(board: board, x: 1, y: 3))
        XCTAssert(!(board.valueAt(1,3)?.selected ?? true))
    }

}
