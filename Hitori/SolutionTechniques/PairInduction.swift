//
//  PairInduction.swift
//  Hitori
//
//  Created by Erland Isaksson on 2019-08-16.
//  Copyright © 2019 Erland Isaksson. All rights reserved.
//

import Foundation

class PairInduction : SolverTechnique {
    func solvePosition(board: BoardHandler, x: Int, y: Int) -> Bool {
        let current = board.valueAt(x, y)!

        if rowContainsPair(board: board, x: x, y: y, number: current.number) || columnContainsPair(board: board, x: x, y: y, number: current.number) {
            board.select(x, y)
            return true
        }
        return false
    }
    
    private func rowContainsPair(board: BoardHandler, x: Int, y: Int, number: Int) -> Bool {
        for posX in 0..<board.sizeOfBoard() {
            if posX < x-2 || posX > x+1 {
                if let current = board.valueAt(posX, y) {
                    if let next = board.valueAt(posX+1, y) {
                        if next.number == current.number && next.number == number {
                            return true
                        }
                    }
                }
            }
        }
        return false
    }

    private func columnContainsPair(board: BoardHandler, x: Int, y: Int, number: Int) -> Bool {
        for posY in 0..<board.sizeOfBoard() {
            if posY < y-2 || posY > y+1 {
                if let current = board.valueAt(x, posY) {
                    if let next = board.valueAt(x, posY+1) {
                        if next.number == current.number && next.number == number {
                            return true
                        }
                    }
                }
            }
        }
        return false
    }
}
