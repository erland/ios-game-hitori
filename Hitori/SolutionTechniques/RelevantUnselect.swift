//
//  RelevantUnselect.swift
//  Hitori
//
//  Created by Erland Isaksson on 2019-08-19.
//  Copyright © 2019 Erland Isaksson. All rights reserved.
//

import Foundation

class RelevantUnselect {
    let board: BoardHandler
    init(board: BoardHandler) {
        self.board = board
    }
    
    func unselect(_ x: Int, _ y: Int) -> Int{
        if let n = board.valueAt(x, y) {
            if n.selected == nil {
                if !LonelyChecker(board: board).isLonely(x, y) {
                    board.unselect(x, y)
                    return 1
                }
            }
        }
        return 0
    }
}
