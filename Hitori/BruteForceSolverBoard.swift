//
//  Solver.swift
//  Sudoku
//
//  Created by Erland Isaksson on 2019-06-16.
//  Copyright © 2019 Erland Isaksson. All rights reserved.
//

import Foundation

class BruteForceSolverBoard : AbstractSolverBoard {
    var solutions : Array<String> = []

    convenience init(size: Int) {
        var boardString = ""
        for _ in 0..<(size*size) {
            boardString = boardString + "_"
        }
        self.init(boardString: boardString)
    }
    
    init(boardString: String) {
        super.init(boardString: boardString, debug: false)
    }
    
    func solve() -> Bool {
        solutions.removeAll()
        _ = solve(0,0)
        return solutions.count == 1
    }
    
    func solve(_ x:Int, _ y:Int) -> Bool {
        var currentX = x
        var currentY = y
        // If last number of line
        if x == size {
            currentX = 0
            currentY = currentY + 1
            // If last number on board
            if currentY == size {
                solutions.append(asString())
                return true
            }
        }
        
        // If number already exists at this position
        let currentCell = valueAt(currentX, currentY)
        if currentCell != nil && currentCell!.selected != nil {
            // Goto next position
            return solve(currentX+1,currentY)
        }
        
        var solved = false
        
        for value in (1...size).shuffled() {
            let cellValue = BoardCell(number: value, selected: true)
            if isValid(x: currentX, y: currentY, value: cellValue) {
                setValue(x: currentX, y: currentY, value: cellValue, present: true)
                if solve(currentX+1, currentY) {
                    solved = true
                    if solutions.count>1 {
                        return true
                    }
                }
                setValue(x: currentX, y: currentY, value: cellValue, present: false)
            }else {
                cellValue.selected = false
                if isValid(x: currentX, y: currentY, value: cellValue) {
                    setValue(x: currentX, y: currentY, value: cellValue, present: true)
                    if solve(currentX+1, currentY) {
                        solved = true
                        if solutions.count>1 {
                            return true
                        }
                    }
                    setValue(x: currentX, y: currentY, value: cellValue, present: false)
                }
            }
        }
        
        board[y*size+x] = nil
        return solved
    }
}
