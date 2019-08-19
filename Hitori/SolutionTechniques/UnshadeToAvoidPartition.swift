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
        let current = board.valueAt(x, y)!
        let left = board.valueAt(x-1, y)
        let right = board.valueAt(x+1, y)
        let above = board.valueAt(x,y-1)
        let below = board.valueAt(x,y+1)
        
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
            let field = traverseField(board: board, x: x-1, y: y, currentX: x, currentY: y, fieldPositions: [])
            if field.count<totallyUnshaded.count {
                if RelevantUnselect(board: board).unselect(x,y)>0 {
                    return true
                }
            }
        }
        if right != nil && (right!.selected == nil || !right!.selected!) {
            let field = traverseField(board: board, x: x+1, y: y, currentX: x, currentY: y, fieldPositions: [])
            if field.count<totallyUnshaded.count {
                if RelevantUnselect(board: board).unselect(x,y)>0 {
                    return true
                }
            }
        }
        if above != nil && (above!.selected == nil || !above!.selected!) {
            let field = traverseField(board: board, x: x, y: y-1, currentX: x, currentY: y, fieldPositions: [])
            if field.count<totallyUnshaded.count {
                if RelevantUnselect(board: board).unselect(x,y)>0 {
                    return true
                }
            }
        }
        if below != nil && (below!.selected == nil || !below!.selected!) {
            let field = traverseField(board: board, x: x, y: y+1, currentX: x, currentY: y, fieldPositions: [])
            if field.count<totallyUnshaded.count {
                if RelevantUnselect(board: board).unselect(x,y)>0 {
                    return true
                }
            }
        }

        return false
    }
    
    private func traverseField(board: BoardHandler, x: Int, y: Int, currentX: Int, currentY: Int, fieldPositions: [Int]) -> [Int] {
        var result = fieldPositions
        if currentX == x && currentY == y {
            return result
        }
        let n1 = board.valueAt(x-1,y)
        if x>0 && (n1 == nil || n1!.selected == nil || !n1!.selected!) {
            let pos = y*board.sizeOfBoard()+x-1
            if !result.contains(pos) {
                result.append(pos)
                result = traverseField(board: board, x: x-1, y: y, currentX: currentX, currentY: currentY, fieldPositions: result)
            }
        }
        
        let n2 = board.valueAt(x+1,y)
        if x<board.sizeOfBoard()-1 && (n2 == nil || n2!.selected == nil || !n2!.selected!) {
            let pos = y*board.sizeOfBoard()+x+1
            if !result.contains(pos) {
                result.append(pos)
                result = traverseField(board: board, x: x+1, y: y, currentX: currentX, currentY: currentY, fieldPositions: result)
            }
        }
        
        let n3 = board.valueAt(x,y-1)
        if y>0 && (n3 == nil || n3!.selected == nil || !n3!.selected!) {
            let pos = (y-1)*board.sizeOfBoard()+x
            if !result.contains(pos) {
                result.append(pos)
                result = traverseField(board: board, x: x, y: y-1, currentX: currentX, currentY: currentY, fieldPositions: result)
            }
        }
        
        let n4 = board.valueAt(x,y+1)
        if y<board.sizeOfBoard()-1 && (n4 == nil || n4!.selected == nil || !n4!.selected!) {
            let pos = (y+1)*board.sizeOfBoard()+x
            if !result.contains(pos) {
                result.append(pos)
                result = traverseField(board: board, x: x, y: y+1, currentX: currentX, currentY: currentY, fieldPositions: result)
            }
        }
        
        return result
    }

}
