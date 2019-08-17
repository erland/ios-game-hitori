//
//  AdjacentTriplets.swift
//  Hitori
//
//  Created by Erland Isaksson on 2019-08-16.
//  Copyright © 2019 Erland Isaksson. All rights reserved.
//

import Foundation

class AdjacentTriplets : SolverTechnique {
    func solvePosition(board: BoardHandler, x: Int, y: Int) -> Bool {
        let current = board.valueAt(x, y)!
        let left = board.valueAt(x-1, y)
        let right = board.valueAt(x+1, y)
        let above = board.valueAt(x,y-1)
        let below = board.valueAt(x,y+1)
        
        if current.selected == nil {
            if left != nil && right != nil && left!.number == current.number && right!.number == current.number {
                unselect(board: board, x: x, y: y)
                select(board: board, x: x-1,y: y)
                select(board: board, x: x+1,y: y)
                return true
            }
            if above != nil && below != nil && above!.number == current.number && below!.number == current.number {
                unselect(board: board, x: x, y: y)
                select(board: board, x: x,y: y-1)
                select(board: board, x: x,y: y+1)
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
    
    func unselect(board: BoardHandler, x: Int, y: Int) {
        let n = board.valueAt(x, y)!
        if n.selected == nil {
            board.unselect(x, y)
        }
    }

}
