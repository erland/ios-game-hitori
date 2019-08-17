//
//  ShadingInRowsColumns.swift
//  Hitori
//
//  Created by Erland Isaksson on 2019-08-17.
//  Copyright © 2019 Erland Isaksson. All rights reserved.
//

import Foundation

class ShadingInRowsColumns : SolverTechnique {
    func solvePosition(board: BoardHandler, x: Int, y: Int) -> Bool {
        let current = board.valueAt(x, y)!
        
        for posX in 0..<board.sizeOfBoard() {
            if posX != x {
                if let n = board.valueAt(posX, y) {
                    if n.number == current.number && n.selected != nil && !n.selected! {
                        board.select(x, y)
                        return true
                    }
                }
            }
        }
        for posY in 0..<board.sizeOfBoard() {
            if posY != y {
                if let n = board.valueAt(x, posY) {
                    if n.number == current.number && n.selected != nil && !n.selected! {
                        board.select(x, y)
                        return true
                    }
                }
            }
        }
        return false
    }
    
}
