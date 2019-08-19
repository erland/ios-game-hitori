//
//  TwoPairsInCorner.swift
//  Hitori
//
//  Created by Erland Isaksson on 2019-08-17.
//  Copyright © 2019 Erland Isaksson. All rights reserved.
//

import Foundation

class TwoPairsInCorner : SolverTechnique {
    func solvePosition(board: BoardHandler, x: Int, y: Int) -> Bool {
        if x <= 1 && y <= 1 {
            if (isRowPair(board: board, x: 0, y: 0) && isRowPair(board: board, x: 0, y: 1)) ||
                (isColumnPair(board: board, x: 0, y: 0) && isColumnPair(board: board, x: 1, y: 0)){
                
                select(board: board, x: 0,y: 0)
                select(board: board, x: 1,y: 1)
                _ = RelevantUnselect(board: board).unselect(0,1)
                _ = RelevantUnselect(board: board).unselect(1,0)
                return true
            }
        }
        if x <= 1 && y >= board.sizeOfBoard()-2 {
            if (isRowPair(board: board, x: 0, y: board.sizeOfBoard()-1) && isRowPair(board: board, x: 0, y: board.sizeOfBoard()-2)) ||
                (isColumnPair(board: board, x: 0, y: board.sizeOfBoard()-1) && isColumnPair(board: board, x: 1, y: board.sizeOfBoard()-1)){
                
                select(board: board, x: 0,y: board.sizeOfBoard()-1)
                select(board: board, x: 1,y: board.sizeOfBoard()-2)
                _ = RelevantUnselect(board: board).unselect(0,board.sizeOfBoard()-2)
                _ = RelevantUnselect(board: board).unselect(1,board.sizeOfBoard()-1)
                return true
            }
        }
        if x >= board.sizeOfBoard()-2 && y <= 1 {
            if (isRowPair(board: board, x: board.sizeOfBoard()-1, y: 0) && isRowPair(board: board, x: board.sizeOfBoard()-1, y: 1)) ||
                (isColumnPair(board: board, x: board.sizeOfBoard()-1, y: 0) && isColumnPair(board: board, x: board.sizeOfBoard()-2, y: 0)){
                
                select(board: board, x: board.sizeOfBoard()-1,y: 0)
                select(board: board, x: board.sizeOfBoard()-2,y: 1)
                _ = RelevantUnselect(board: board).unselect(board.sizeOfBoard()-1,1)
                _ = RelevantUnselect(board: board).unselect(board.sizeOfBoard()-2,0)
                return true
            }
        }
        if x >= board.sizeOfBoard()-2 && y >= board.sizeOfBoard()-2 {
            if (isRowPair(board: board, x: board.sizeOfBoard()-1, y: board.sizeOfBoard()-1) && isRowPair(board: board, x: board.sizeOfBoard()-1, y: board.sizeOfBoard()-2)) ||
                (isColumnPair(board: board, x: board.sizeOfBoard()-1, y: board.sizeOfBoard()-1) && isColumnPair(board: board, x: board.sizeOfBoard()-2, y: board.sizeOfBoard()-1)){
                
                select(board: board, x: board.sizeOfBoard()-1,y: board.sizeOfBoard()-1)
                select(board: board, x: board.sizeOfBoard()-2,y: board.sizeOfBoard()-2)
                _ = RelevantUnselect(board: board).unselect(board.sizeOfBoard()-1,board.sizeOfBoard()-2)
                _ = RelevantUnselect(board: board).unselect(board.sizeOfBoard()-2,board.sizeOfBoard()-1)
                return true
            }
        }
        return false
    }
    
    func isRowPair(board: BoardHandler, x: Int, y: Int) -> Bool {
        if x==0 {
            if board.valueAt(x,y)!.number == board.valueAt(x+1,y)!.number {
                return true
            }
        }
        if x==board.sizeOfBoard()-1 {
            if board.valueAt(x,y)!.number == board.valueAt(x-1,y)!.number {
                return true
            }
        }
        return false
    }

    func isColumnPair(board: BoardHandler, x: Int, y: Int) -> Bool {
        if y==0 {
            if board.valueAt(x,y)!.number == board.valueAt(x,y+1)!.number {
                return true
            }
        }
        if y==board.sizeOfBoard()-1 {
            if board.valueAt(x,y)!.number == board.valueAt(x,y-1)!.number {
                return true
            }
        }
        return false
    }
    func select(board: BoardHandler, x: Int, y: Int) {
        let n = board.valueAt(x, y)!
        if n.selected == nil {
            board.select(x, y)
        }
    }
}
