//
//  LonelyChecker.swift
//  Hitori
//
//  Created by Erland Isaksson on 2019-08-19.
//  Copyright © 2019 Erland Isaksson. All rights reserved.
//

import Foundation

class LonelyChecker {
    let board: BoardHandler
    
    init(board: BoardHandler) {
        self.board = board
    }
    func isLonely(_ x: Int, _ y: Int) -> Bool {
        let current = board.valueAt(x, y)!
        var foundOther = false
        for posY in 0..<board.sizeOfBoard() {
            let n = board.valueAt(x, posY)!
            if posY != y && n.number == current.number && n.selected == nil {
                foundOther = true
                break
            }
        }
        if !foundOther {
            for posX in 0..<board.sizeOfBoard() {
                let n = board.valueAt(posX, y)!
                if posX != x && n.number == current.number && n.selected == nil {
                    foundOther = true
                    break
                }
            }
        }
        return !foundOther
    }
}
