//
//  LookForwardToAvoidPartition.swift
//  Hitori
//
//  Created by Erland Isaksson on 2019-08-17.
//  Copyright © 2019 Erland Isaksson. All rights reserved.
//

import Foundation

class LookForwardToAvoidPartition : SolverTechnique {
    let techniques : [SolverTechnique]
    let steps : Int?
    
    init(techniques: [SolverTechnique], steps: Int? = nil) {
        self.techniques = techniques
        self.steps = steps
    }
    
    func solvePosition(board: BoardHandler, x: Int, y: Int) -> Bool {
        let selectedStatus = solveAndValidate(board: board, x: x, y: y, selected: true)
        let unselectedStatus = solveAndValidate(board: board, x: x, y: y, selected: false)
        if selectedStatus != unselectedStatus {
            if selectedStatus {
                board.select(x,y)
                return true
            }else {
                if RelevantUnselect(board: board).unselect(x,y)>0 {
                    return true
                }
            }
        }
        return false
    }
    
    func solveAndValidate(board: BoardHandler, x: Int, y: Int, selected: Bool) -> Bool {
        let boardCopy = TechniqueSolverBoard(boardString: boardAsString(board:board))
        boardCopy.initializeSelections(selectionString: selectionsAsString(board: board))
        
        let n = boardCopy.valueAt(x, y)!
        n.selected = selected
        boardCopy.setValue(x: x, y: y, value: n, present: true)
        solve(board: boardCopy)
        return validatePartition(board: boardCopy)
    }

    func solve(board: TechniqueSolverBoard) {
        _ = board.solve(techniques: techniques, steps: steps)
    }
    
    func validatePartition(board: BoardHandler) -> Bool {
        var unselectedCells : [Int] = []
        var startX : Int?
        var startY : Int?
        
        for y in 0..<board.sizeOfBoard() {
            for x in 0..<board.sizeOfBoard() {
                if let n = board.valueAt(x,y) {
                    if n.selected == nil || n.selected == false {
                        unselectedCells.append(y*board.sizeOfBoard()+x)
                        startX = x
                        startY = y
                    }
                }
            }
        }
        
        if unselectedCells.count>0 {
            let fieldSize = FieldHelper(board: board).sizeOfField(startX!, startY!)
            if fieldSize == unselectedCells.count {
                return true
            }
        }
        return false
    }
        
    func boardAsString(board: BoardHandler) -> String {
        var numbers = ""
        for y in 0..<board.sizeOfBoard() {
            for x in 0..<board.sizeOfBoard() {
                numbers = numbers + "\(board.valueAt(x,y)!.number)"
            }
        }
        return numbers
    }

    func selectionsAsString(board: BoardHandler) -> String {
        var selections = ""
        for y in 0..<board.sizeOfBoard() {
            for x in 0..<board.sizeOfBoard() {
                if let n = board.valueAt(x,y) {
                    if n.selected == nil {
                        selections = selections + "_"
                    }else if n.selected! {
                        selections = selections + "X"
                    }else {
                        selections = selections + "?"
                    }
                }
            }
        }
        return selections
    }
}
