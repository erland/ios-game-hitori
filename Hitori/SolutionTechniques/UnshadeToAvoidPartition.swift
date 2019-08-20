//
//  UnshadeToAvoidPartition.swift
//  Hitori
//
//  Created by Erland Isaksson on 2019-08-17.
//  Copyright © 2019 Erland Isaksson. All rights reserved.
//

import Foundation

class UnshadeToAvoidPartition : SolverTechnique {
    func solvePosition(board: BoardHandler, x: Int, y: Int) -> Bool {
        let left = board.valueAt(x-1, y)
        let right = board.valueAt(x+1, y)
        let above = board.valueAt(x,y-1)
        let below = board.valueAt(x,y+1)
        let fieldHelper = FieldHelper(board: board)
        
        var totallyUnshaded : [Int] = []
        for posY in 0..<board.sizeOfBoard() {
            for posX in 0..<board.sizeOfBoard() {
                if posX != x || posY != y {
                    if let n = board.valueAt(posX, posY) {
                        if n.selected == nil || !n.selected! {
                            totallyUnshaded.append(posY*board.sizeOfBoard()+posX)
                        }
                    }
                }
            }
        }
        
        if left != nil && (left!.selected == nil || !left!.selected!) {
            let fieldSize = fieldHelper.sizeOfField(x: x-1, y: y, abortX: x, abortY: y)
            if fieldSize<totallyUnshaded.count {
                if RelevantUnselect(board: board).unselect(x,y)>0 {
                    return true
                }
            }
        }
        if right != nil && (right!.selected == nil || !right!.selected!) {
            let fieldSize = fieldHelper.sizeOfField(x: x+1, y: y, abortX: x, abortY: y)
            if fieldSize<totallyUnshaded.count {
                if RelevantUnselect(board: board).unselect(x,y)>0 {
                    return true
                }
            }
        }
        if above != nil && (above!.selected == nil || !above!.selected!) {
            let fieldSize = fieldHelper.sizeOfField(x: x, y: y-1, abortX: x, abortY: y)
            if fieldSize<totallyUnshaded.count {
                if RelevantUnselect(board: board).unselect(x,y)>0 {
                    return true
                }
            }
        }
        if below != nil && (below!.selected == nil || !below!.selected!) {
            let fieldSize = fieldHelper.sizeOfField(x: x, y: y+1, abortX: x, abortY: y)
            if fieldSize<totallyUnshaded.count {
                if RelevantUnselect(board: board).unselect(x,y)>0 {
                    return true
                }
            }
        }

        return false
    }
}
