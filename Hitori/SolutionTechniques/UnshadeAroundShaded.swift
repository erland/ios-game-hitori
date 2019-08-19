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
            var cells = RelevantUnselect(board: board).unselect(x,y)
            cells = cells + RelevantUnselect(board: board).unselect(x-2,y)
            cells = cells + RelevantUnselect(board: board).unselect(x-1,y-1)
            cells = cells + RelevantUnselect(board: board).unselect(x-1,y+1)
            if cells>0 {
                return true
            }
        }
        if right != nil && right!.selected != nil && right!.selected! {
            var cells = RelevantUnselect(board: board).unselect(x,y)
            cells = cells + RelevantUnselect(board: board).unselect(x+2,y)
            cells = cells + RelevantUnselect(board: board).unselect(x+1,y-1)
            cells = cells + RelevantUnselect(board: board).unselect(x+1,y+1)
            if cells>0 {
                return true
            }
        }
        if above != nil && above!.selected != nil && above!.selected! {
            var cells = RelevantUnselect(board: board).unselect(x,y)
            cells = cells + RelevantUnselect(board: board).unselect(x,y-2)
            cells = cells + RelevantUnselect(board: board).unselect(x-1,y-1)
            cells = cells + RelevantUnselect(board: board).unselect(x+1,y-1)
            if cells>0 {
                return true
            }
        }
        if below != nil && below!.selected != nil && below!.selected! {
            var cells = RelevantUnselect(board: board).unselect(x,y)
            cells = cells + RelevantUnselect(board: board).unselect(x,y+2)
            cells = cells + RelevantUnselect(board: board).unselect(x-1,y+1)
            cells = cells + RelevantUnselect(board: board).unselect(x+1,y+1)
            if cells>0 {
                return true
            }
        }

        return false
    }
}
