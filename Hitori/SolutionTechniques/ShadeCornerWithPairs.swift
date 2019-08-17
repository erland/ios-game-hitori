//
//  ShadeCornerWithPairs.swift
//  Hitori
//
//  Created by Erland Isaksson on 2019-08-17.
//  Copyright © 2019 Erland Isaksson. All rights reserved.
//

import Foundation

class ShadeCornerWithPairs : SolverTechnique {
    func solvePosition(board: BoardHandler, x: Int, y: Int) -> Bool {
        let current = board.valueAt(x, y)!
        
        if x == 0 && y == 0 {
            if board.valueAt(1, 0)!.number == current.number && board.valueAt(0, 1)!.number == current.number {
                board.select(x, y)
                return true
            }
        }
        if x == 0 && y == board.sizeOfBoard()-1 {
            if board.valueAt(1, board.sizeOfBoard()-1)!.number == current.number && board.valueAt(0, board.sizeOfBoard()-2)!.number == current.number {
                board.select(x, y)
                return true
            }
        }
        if x == board.sizeOfBoard()-1 && y == 0 {
            if board.valueAt(board.sizeOfBoard()-2, 0)!.number == current.number && board.valueAt(board.sizeOfBoard()-1, 1)!.number == current.number {
                board.select(x, y)
                return true
            }
        }
        if x == board.sizeOfBoard()-1 && y == board.sizeOfBoard()-1 {
            if board.valueAt(board.sizeOfBoard()-2, board.sizeOfBoard()-1)!.number == current.number && board.valueAt(board.sizeOfBoard()-1, board.sizeOfBoard()-2)!.number == current.number {
                board.select(x, y)
                return true
            }
        }
        return false
    }
    
}
