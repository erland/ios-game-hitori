//
//  UnshadeAroundShaded.swift
//  Hitori
//
//  Created by Erland Isaksson on 2019-08-17.
//  Copyright © 2019 Erland Isaksson. All rights reserved.
//

import Foundation

class UnshadeAroundShaded : SolverTechnique {
    func solvePosition(board: BoardHandler, x: Int, y: Int) -> Bool {
        
        let left = board.valueAt(x-1, y)
        let right = board.valueAt(x+1, y)
        let above = board.valueAt(x,y-1)
        let below = board.valueAt(x,y+1)

        
        if left != nil && left!.selected != nil && left!.selected! {
            unselect(board: board, x: x, y: y)
            unselect(board: board, x: x-2, y: y)
            unselect(board: board, x: x-1, y: y-1)
            unselect(board: board, x: x-1, y: y+1)
            return true
        }
        if right != nil && right!.selected != nil && right!.selected! {
            unselect(board: board, x: x, y: y)
            unselect(board: board, x: x+2, y: y)
            unselect(board: board, x: x+1, y: y-1)
            unselect(board: board, x: x+1, y: y+1)
            return true
        }
        if above != nil && above!.selected != nil && above!.selected! {
            unselect(board: board, x: x, y: y)
            unselect(board: board, x: x, y: y-2)
            unselect(board: board, x: x-1, y: y-1)
            unselect(board: board, x: x+1, y: y-1)
            return true
        }
        if below != nil && below!.selected != nil && below!.selected! {
            unselect(board: board, x: x, y: y)
            unselect(board: board, x: x, y: y+2)
            unselect(board: board, x: x-1, y: y+1)
            unselect(board: board, x: x+1, y: y+1)
            return true
        }

        return false
    }
    
    func select(board: BoardHandler, x: Int, y: Int) {
        if let n = board.valueAt(x, y) {
            if n.selected == nil {
                board.select(x, y)
            }
        }
    }
    
    func unselect(board: BoardHandler, x: Int, y: Int) {
        if let n = board.valueAt(x, y) {
            if n.selected == nil {
                board.unselect(x, y)
            }
        }
    }

}
