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
                unselect(board: board, x: x, y: y)
                return true
            }
            if isColumnPair(board: board, x: 1, y: 0) {
                unselect(board: board, x: x, y: y)
                return true
            }
        }else if x==1 && y==0 {
            if isRowPair(board: board, x: 0, y: 1) {
                unselect(board: board, x: x, y: y)
                return true
            }
            if isColumnPair(board: board, x: 0, y: 0) {
                unselect(board: board, x: x, y: y)
                return true
            }
        }else if x==board.sizeOfBoard()-1 && y==1 {
            if isRowPair(board: board, x: board.sizeOfBoard()-1, y: 0) {
                unselect(board: board, x: x, y: y)
                return true
            }
            if isColumnPair(board: board, x: board.sizeOfBoard()-2, y: 0) {
                unselect(board: board, x: x, y: y)
                return true
            }
        }else if x==board.sizeOfBoard()-2 && y==0 {
            if isRowPair(board: board, x: board.sizeOfBoard()-1, y: 1) {
                unselect(board: board, x: x, y: y)
                return true
            }
            if isColumnPair(board: board, x: board.sizeOfBoard()-1, y: 0) {
                unselect(board: board, x: x, y: y)
                return true
            }
        }else if x==0 && y==board.sizeOfBoard()-2 {
            if isRowPair(board: board, x: 0, y: board.sizeOfBoard()-1) {
                unselect(board: board, x: x, y: y)
                return true
            }
            if isColumnPair(board: board, x: 1, y: board.sizeOfBoard()-1) {
                unselect(board: board, x: x, y: y)
                return true
            }
        }else if x==1 && y==board.sizeOfBoard()-1 {
            if isRowPair(board: board, x: 0, y: board.sizeOfBoard()-2) {
                unselect(board: board, x: x, y: y)
                return true
            }
            if isColumnPair(board: board, x: 0, y: board.sizeOfBoard()-1) {
                unselect(board: board, x: x, y: y)
                return true
            }
        }else if x==board.sizeOfBoard()-1 && y==board.sizeOfBoard()-2 {
            if isRowPair(board: board, x: board.sizeOfBoard()-1, y: board.sizeOfBoard()-1) {
                unselect(board: board, x: x, y: y)
                return true
            }
            if isColumnPair(board: board, x: board.sizeOfBoard()-2, y: board.sizeOfBoard()-1) {
                unselect(board: board, x: x, y: y)
                return true
            }
        }else if x==board.sizeOfBoard()-2 && y==board.sizeOfBoard()-1 {
            if isRowPair(board: board, x: board.sizeOfBoard()-1, y: board.sizeOfBoard()-2) {
                unselect(board: board, x: x, y: y)
                return true
            }
            if isColumnPair(board: board, x: board.sizeOfBoard()-1, y: board.sizeOfBoard()-1) {
                unselect(board: board, x: x, y: y)
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
            n.selected = true
            board.setValue(x: x, y: y, value: n, present: true)
        }
    }
    
    func unselect(board: BoardHandler, x: Int, y: Int) {
        let n = board.valueAt(x, y)!
        if n.selected == nil {
            n.selected = false
            board.setValue(x: x, y: y, value: n, present: true)
        }
    }
}
