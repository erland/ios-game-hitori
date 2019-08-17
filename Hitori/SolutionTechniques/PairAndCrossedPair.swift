//
//  PairAndCrossedPair.swift
//  Hitori
//
//  Created by Erland Isaksson on 2019-08-17.
//  Copyright © 2019 Erland Isaksson. All rights reserved.
//

import Foundation

class PairAndCrossedPair : SolverTechnique {
    func solvePosition(board: BoardHandler, x: Int, y: Int) -> Bool {
        
        // Downward cross
        if let n1 = board.valueAt(x+1, y) {
            if let n2 = board.valueAt(x, y-1) {
                for pos in 0..<board.sizeOfBoard() {
                    if pos != x && pos != x+1 {
                        let n3 = board.valueAt(pos, y)
                        let n4 = board.valueAt(pos, y-1)
                        if n3 != nil && n4 != nil && n1.number==n3!.number && n2.number == n4!.number {
                            unselect(board: board, x: x, y: y)
                            unselect(board: board, x: x+1, y: y-1)
                            return true
                        }
                    }
                    if pos != y && pos != y-1 {
                        let n3 = board.valueAt(x+1, pos)
                        let n4 = board.valueAt(x, pos)
                        if n3 != nil && n4 != nil && n1.number==n3!.number && n2.number == n4!.number {
                            unselect(board: board, x: x, y: y)
                            unselect(board: board, x: x+1, y: y-1)
                            return true
                        }
                    }
                }
            }
        }
        // Upward cross
        if let n1 = board.valueAt(x-1, y) {
            if let n2 = board.valueAt(x, y-1) {
                for pos in 0..<board.sizeOfBoard() {
                    if pos != x && pos != x-1 {
                        let n3 = board.valueAt(pos, y)
                        let n4 = board.valueAt(pos, y-1)
                        if n3 != nil && n4 != nil && n1.number==n3!.number && n2.number == n4!.number {
                            unselect(board: board, x: x, y: y)
                            unselect(board: board, x: x-1, y: y-1)
                            return true
                        }
                    }
                    if pos != y && pos != y-1 {
                        let n3 = board.valueAt(x-1, pos)
                        let n4 = board.valueAt(x, pos)
                        if n3 != nil && n4 != nil && n1.number==n3!.number && n2.number == n4!.number {
                            unselect(board: board, x: x, y: y)
                            unselect(board: board, x: x-1, y: y-1)
                            return true
                        }
                    }
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
