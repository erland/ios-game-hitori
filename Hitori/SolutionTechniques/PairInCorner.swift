//
//  PairInCorner.swift
//  Hitori
//
//  Created by Erland Isaksson on 2019-08-17.
//  Copyright © 2019 Erland Isaksson. All rights reserved.
//

import Foundation

class PairInCorner : SolverTechnique {
    func solvePosition(board: BoardHandler, x: Int, y: Int) -> Bool {

        if x==0 && y==1 {
            if isRowPair(board: board, x: 0, y: 0) {
                if RelevantUnselect(board: board).unselect(x,y)>0 {
                    return true
                }
            }
            if isColumnPair(board: board, x: 1, y: 0) {
                if RelevantUnselect(board: board).unselect(x,y)>0 {
                    return true
                }
            }
        }else if x==1 && y==0 {
            if isRowPair(board: board, x: 0, y: 1) {
                if RelevantUnselect(board: board).unselect(x,y)>0 {
                    return true
                }
            }
            if isColumnPair(board: board, x: 0, y: 0) {
                if RelevantUnselect(board: board).unselect(x,y)>0 {
                    return true
                }
            }
        }else if x==board.sizeOfBoard()-1 && y==1 {
            if isRowPair(board: board, x: board.sizeOfBoard()-1, y: 0) {
                if RelevantUnselect(board: board).unselect(x,y)>0 {
                    return true
                }
            }
            if isColumnPair(board: board, x: board.sizeOfBoard()-2, y: 0) {
                if RelevantUnselect(board: board).unselect(x,y)>0 {
                    return true
                }
            }
        }else if x==board.sizeOfBoard()-2 && y==0 {
            if isRowPair(board: board, x: board.sizeOfBoard()-1, y: 1) {
                if RelevantUnselect(board: board).unselect(x,y)>0 {
                    return true
                }
            }
            if isColumnPair(board: board, x: board.sizeOfBoard()-1, y: 0) {
                if RelevantUnselect(board: board).unselect(x,y)>0 {
                    return true
                }
            }
        }else if x==0 && y==board.sizeOfBoard()-2 {
            if isRowPair(board: board, x: 0, y: board.sizeOfBoard()-1) {
                if RelevantUnselect(board: board).unselect(x,y)>0 {
                    return true
                }
            }
            if isColumnPair(board: board, x: 1, y: board.sizeOfBoard()-1) {
                if RelevantUnselect(board: board).unselect(x,y)>0 {
                    return true
                }
            }
        }else if x==1 && y==board.sizeOfBoard()-1 {
            if isRowPair(board: board, x: 0, y: board.sizeOfBoard()-2) {
                if RelevantUnselect(board: board).unselect(x,y)>0 {
                    return true
                }
            }
            if isColumnPair(board: board, x: 0, y: board.sizeOfBoard()-1) {
                if RelevantUnselect(board: board).unselect(x,y)>0 {
                    return true
                }
            }
        }else if x==board.sizeOfBoard()-1 && y==board.sizeOfBoard()-2 {
            if isRowPair(board: board, x: board.sizeOfBoard()-1, y: board.sizeOfBoard()-1) {
                if RelevantUnselect(board: board).unselect(x,y)>0 {
                    return true
                }
            }
            if isColumnPair(board: board, x: board.sizeOfBoard()-2, y: board.sizeOfBoard()-1) {
                if RelevantUnselect(board: board).unselect(x,y)>0 {
                    return true
                }
            }
        }else if x==board.sizeOfBoard()-2 && y==board.sizeOfBoard()-1 {
            if isRowPair(board: board, x: board.sizeOfBoard()-1, y: board.sizeOfBoard()-2) {
                if RelevantUnselect(board: board).unselect(x,y)>0 {
                    return true
                }
            }
            if isColumnPair(board: board, x: board.sizeOfBoard()-1, y: board.sizeOfBoard()-1) {
                if RelevantUnselect(board: board).unselect(x,y)>0 {
                    return true
                }
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
}
