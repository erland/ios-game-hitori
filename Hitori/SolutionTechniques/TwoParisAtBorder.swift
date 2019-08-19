//
//  BorderPairs.swift
//  Hitori
//
//  Created by Erland Isaksson on 2019-08-17.
//  Copyright © 2019 Erland Isaksson. All rights reserved.
//

import Foundation

class TwoPairsAtBorder : SolverTechnique {
    func solvePosition(board: BoardHandler, x: Int, y: Int) -> Bool {
        
        if x>1 && x<board.sizeOfBoard()-2 && y>1 && y<board.sizeOfBoard()-2 {
            return false
        }
        if y<=1 {
            if isDoubleRowPair(board: board, x1: x-1, x2: x-2, y: 0) {
                var cells = RelevantUnselect(board: board).unselect(x,0)
                cells = cells + RelevantUnselect(board: board).unselect(x,1)
                cells = cells + RelevantUnselect(board: board).unselect(x-3,0)
                cells = cells + RelevantUnselect(board: board).unselect(x-3,1)
                if cells>0 {
                    return true
                }
            }
            if isDoubleRowPair(board: board, x1: x+1, x2: x+2, y: 0) {
                var cells = RelevantUnselect(board: board).unselect(x,0)
                cells = cells + RelevantUnselect(board: board).unselect(x,1)
                cells = cells + RelevantUnselect(board: board).unselect(x+3,0)
                cells = cells + RelevantUnselect(board: board).unselect(x+3,1)
                if cells>0 {
                    return true
                }
            }
        }
        if y>=board.sizeOfBoard()-2 {
            if isDoubleRowPair(board: board, x1: x-1, x2: x-2, y: board.sizeOfBoard()-1) {
                var cells = RelevantUnselect(board: board).unselect(x,board.sizeOfBoard()-1)
                cells = cells + RelevantUnselect(board: board).unselect(x,board.sizeOfBoard()-2)
                cells = cells + RelevantUnselect(board: board).unselect(x-3,board.sizeOfBoard()-1)
                cells = cells + RelevantUnselect(board: board).unselect(x-3,board.sizeOfBoard()-2)
                if cells>0 {
                    return true
                }
            }
            if isDoubleRowPair(board: board, x1: x+1, x2: x+2, y: board.sizeOfBoard()-1) {
                var cells = RelevantUnselect(board: board).unselect(x,board.sizeOfBoard()-1)
                cells = cells + RelevantUnselect(board: board).unselect(x,board.sizeOfBoard()-2)
                cells = cells + RelevantUnselect(board: board).unselect(x+3,board.sizeOfBoard()-1)
                cells = cells + RelevantUnselect(board: board).unselect(x+3,board.sizeOfBoard()-2)
                if cells>0 {
                    return true
                }
            }
        }

        if x<=1 {
            if isDoubleColumnPair(board: board, x: 0, y1: y-1, y2: y-2) {
                var cells = RelevantUnselect(board: board).unselect(0,y)
                cells = cells + RelevantUnselect(board: board).unselect(1,y)
                cells = cells + RelevantUnselect(board: board).unselect(0,y-3)
                cells = cells + RelevantUnselect(board: board).unselect(1,y-3)
                if cells>0 {
                    return true
                }
            }
            if isDoubleColumnPair(board: board, x: 0, y1: y+1, y2: y+2) {
                var cells = RelevantUnselect(board: board).unselect(0,y)
                cells = cells + RelevantUnselect(board: board).unselect(1,y)
                cells = cells + RelevantUnselect(board: board).unselect(0,y+3)
                cells = cells + RelevantUnselect(board: board).unselect(1,y+3)
                if cells>0 {
                    return true
                }
            }
        }
        if x>=board.sizeOfBoard()-2 {
            if isDoubleColumnPair(board: board, x: board.sizeOfBoard()-1, y1: y-1, y2: y-2) {
                var cells = RelevantUnselect(board: board).unselect(board.sizeOfBoard()-1,y)
                cells = cells + RelevantUnselect(board: board).unselect(board.sizeOfBoard()-2,y)
                cells = cells + RelevantUnselect(board: board).unselect(board.sizeOfBoard()-1,y-3)
                cells = cells + RelevantUnselect(board: board).unselect(board.sizeOfBoard()-2,y-3)
                if cells>0 {
                    return true
                }
            }
            if isDoubleColumnPair(board: board, x: board.sizeOfBoard()-1, y1: y+1, y2: y+2) {
                var cells = RelevantUnselect(board: board).unselect(board.sizeOfBoard()-1,y)
                cells = cells + RelevantUnselect(board: board).unselect(board.sizeOfBoard()-2,y)
                cells = cells + RelevantUnselect(board: board).unselect(board.sizeOfBoard()-1,y+3)
                cells = cells + RelevantUnselect(board: board).unselect(board.sizeOfBoard()-2,y+3)
                if cells>0 {
                    return true
                }
            }
        }

        return false
    }
    
    func isDoubleRowPair(board: BoardHandler, x1: Int, x2: Int, y: Int) -> Bool {
        var y1 : Int
        var y2 : Int
        if y<=1 {
            y1 = 0
            y2 = 1
        }else {
            y1 = board.sizeOfBoard()-2
            y2 = board.sizeOfBoard()-1
        }
        
        if isRowPair(board: board, x1: x1, x2: x2, y: y1) && isRowPair(board: board, x1: x1, x2: x2, y: y2) {
            return true
        }
        return false
    }
    func isRowPair(board: BoardHandler, x1: Int, x2: Int, y: Int) -> Bool {
        if let n1 = board.valueAt(x1, y) {
            if let n2 = board.valueAt(x2, y) {
                if n1.number == n2.number {
                    return true
                }
            }
        }
        return false
    }
    func isDoubleColumnPair(board: BoardHandler, x: Int, y1: Int, y2: Int) -> Bool {
        var x1 : Int
        var x2 : Int
        if x<=1 {
            x1 = 0
            x2 = 1
        }else {
            x1 = board.sizeOfBoard()-2
            x2 = board.sizeOfBoard()-1
        }
        
        if isColumnPair(board: board, x: x1, y1: y1, y2: y2) && isColumnPair(board: board, x: x2, y1: y1, y2: y2) {
            return true
        }
        return false
    }
    func isColumnPair(board: BoardHandler, x: Int, y1: Int, y2: Int) -> Bool {
        if let n1 = board.valueAt(x, y1) {
            if let n2 = board.valueAt(x, y2) {
                if n1.number == n2.number {
                    return true
                }
            }
        }
        return false
    }

    func unselect(board: BoardHandler, x: Int, y: Int) {
        let n = board.valueAt(x, y)!
        if n.selected == nil {
            board.unselect(x, y)
        }
    }
}
