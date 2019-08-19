//
//  BoardHandler.swift
//  Sudoku
//
//  Created by Erland Isaksson on 2019-06-21.
//  Copyright © 2019 Erland Isaksson. All rights reserved.
//

protocol BoardHandler {
    func setValue(x: Int, y: Int, value: BoardCell, present: Bool)
    func select(_ x: Int, _ y: Int)
    func unselect(_ x: Int, _ y: Int)
    func valueAt(_ x: Int, _ y: Int) -> BoardCell?
    func sizeOfBoard() -> Int
}

