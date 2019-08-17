//
//  TwoPairsWIthCommonNumberBetween.swift
//  Hitori
//
//  Created by Erland Isaksson on 2019-08-17.
//  Copyright © 2019 Erland Isaksson. All rights reserved.
//

import Foundation

class TwoPairsWithNumberBetween : SolverTechnique {
    func solvePosition(board: BoardHandler, x: Int, y: Int) -> Bool {
    
        let rowPos = otherPlacesOnRow(board: board, x: x, y: y, number: board.valueAt(x, y)!.number)
        for pos1 in rowPos {
            let n1 = board.valueAt(pos1, y-1)
            let n2 = board.valueAt(pos1, y+1)
            
            for pos2 in rowPos {
                if pos2 != pos1 {
                    let n3 = board.valueAt(pos2, y-1)
                    let n4 = board.valueAt(pos2, y+1)
                    
                    if n1 != nil && n3 != nil && n1!.number==n3!.number {
                        board.select(x, y)
                        return true
                    }
                    if n2 != nil && n4 != nil && n2!.number==n4!.number {
                        board.select(x, y)
                        return true
                    }
                }
            }
        }

        let columnPos = otherPlacesOnColumn(board: board, x: x, y: y, number: board.valueAt(x, y)!.number)
        for pos1 in columnPos {
            let n1 = board.valueAt(x-1, pos1)
            let n2 = board.valueAt(x+1, pos1)
            
            for pos2 in columnPos {
                if pos2 != pos1 {
                    let n3 = board.valueAt(x-1, pos2)
                    let n4 = board.valueAt(x+1, pos2)
                    
                    if n1 != nil && n3 != nil && n1!.number==n3!.number {
                        board.select(x, y)
                        return true
                    }
                    if n2 != nil && n4 != nil && n2!.number==n4!.number {
                        board.select(x, y)
                        return true
                    }
                }
            }
        }

        return false
    }
    
    func otherPlacesOnRow(board: BoardHandler, x: Int, y: Int, number: Int) -> [Int] {
        var result : [Int] = []
        for pos in 0..<board.sizeOfBoard() {
            if pos != x && board.valueAt(pos, y)!.number == number {
                result.append(pos)
            }
        }
        return result
    }
    
    func otherPlacesOnColumn(board: BoardHandler, x: Int, y: Int, number: Int) -> [Int] {
        var result : [Int] = []
        for pos in 0..<board.sizeOfBoard() {
            if pos != y && board.valueAt(x,pos)!.number == number {
                result.append(pos)
            }
        }
        return result
    }
}

