//
//  FieldHelper.swift
//  Hitori
//
//  Created by Erland Isaksson on 2019-08-20.
//  Copyright © 2019 Erland Isaksson. All rights reserved.
//

import Foundation

class FieldHelper {
    let board: BoardReadHandler
    var fieldSet : Set<Int>
    var abortX: Int?
    var abortY: Int?
    init(board: BoardReadHandler) {
        self.board = board
        self.fieldSet = Set<Int>(minimumCapacity: board.sizeOfBoard()*board.sizeOfBoard())
    }
    
    func sizeOfField(_ x: Int, _ y: Int) -> Int {
        self.abortX = nil
        self.abortY = nil
        fieldSet.removeAll(keepingCapacity: true)
        traverseField(x: x, y: y)
        return fieldSet.count
    }
    
    func sizeOfField(x: Int, y: Int, abortX: Int, abortY: Int) -> Int {
        self.abortX = abortX
        self.abortY = abortY
        fieldSet.removeAll(keepingCapacity: true)
        traverseField(x: x, y: y)
        return fieldSet.count
    }

    private func traverseField(x: Int, y: Int) {
        
        if x == abortX && y == abortY {
            return
        }
        
        if x>0 {
            if let pos = positionToAdd(x-1, y) {
                let (inserted, _) = fieldSet.insert(pos)
                if(inserted) {
                    traverseField(x: x-1, y: y)
                }
            }
        }
        if x<board.sizeOfBoard()-1 {
            if let pos = positionToAdd(x+1, y) {
                let (inserted, _) = fieldSet.insert(pos)
                if(inserted) {
                    traverseField(x: x+1, y: y)
                }
            }
        }
        if y>0 {
            if let pos = positionToAdd(x, y-1) {
                let (inserted, _) = fieldSet.insert(pos)
                if(inserted) {
                    traverseField(x: x, y: y-1)
                }
            }
        }
        if y<board.sizeOfBoard()-1 {
            if let pos = positionToAdd(x, y+1) {
                let (inserted, _) = fieldSet.insert(pos)
                if(inserted) {
                    traverseField(x: x, y: y+1)
                }
            }
        }
    }
    
    private func positionToAdd(_ x: Int, _ y: Int) -> Int? {
        let n = board.valueAt(x,y, unsafe: true)
        if n == nil || n!.selected == nil || !n!.selected! {
            return y*board.sizeOfBoard()+x
        }
        return nil
    }
}
