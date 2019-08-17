//
//  SquareBetweenPair.swift
//  Hitori
//
//  Created by Erland Isaksson on 2019-08-16.
//  Copyright © 2019 Erland Isaksson. All rights reserved.
//

import Foundation

class SquareBetweenPair : SolverTechnique {
    func solvePosition(board: BoardHandler, x: Int, y: Int) -> Bool {
        let current = board.valueAt(x, y)!
        let left = board.valueAt(x-1, y)
        let right = board.valueAt(x+1, y)
        let above = board.valueAt(x,y-1)
        let below = board.valueAt(x,y+1)
        
        if current.selected == nil {
            if left != nil && right != nil && left!.number == right!.number {
                board.unselect(x, y)
                return true
            }
            if above != nil && below != nil && above!.number == below!.number {
                board.unselect(x, y)
                return true
            }
        }
        return false
    }
}
