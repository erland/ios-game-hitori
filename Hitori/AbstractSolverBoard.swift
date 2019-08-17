//
//  AbstractSolverBoard.swift
//  Sudoku
//
//  Created by Erland Isaksson on 2019-06-22.
//  Copyright © 2019 Erland Isaksson. All rights reserved.
//

class AbstractSolverBoard : BoardHandler {
    var size : Int
    var board: Array<BoardCell?>
    let debug: Bool

    init(boardString: String, debug: Bool = true) {
        self.debug = debug
        size = AbstractSolverBoard.sizeOfBoard(boardString: boardString)
        board = Array<BoardCell?>(repeating: nil, count:size * size)
        initializeBoard(boardString: boardString)
    }

    func sizeOfBoard() -> Int {
        return size
    }
    private class func sizeOfBoard(boardString: String) -> Int {
        switch boardString.count {
        case 25:
            return 5
        case 36:
            return 6
        case 49:
            return 7
        case 64:
            return 8
        case 81:
            return 9
        default:
            return 5
        }
    }
    
    func initializeBoard(boardString: String) {
        size = AbstractSolverBoard.sizeOfBoard(boardString: boardString)
        board = Array<BoardCell?>(repeating: nil, count:size * size)
        
        for y in 0..<size {
            for x in 0..<size {
                let i = size*y+x
                if boardString.count > i {
                    let ch = boardString[boardString.index(boardString.startIndex, offsetBy: i)]
                    if let num = Int(String(ch)) {
                        setValue(x: x,y: y, value: BoardCell(number: num, selected: nil), present: true)
                    }
                }
            }
        }
        
    }

    func initializeSelections(selectionString: String) {
        for y in 0..<size {
            for x in 0..<size {
                let i = size*y+x
                if selectionString.count > i {
                    let ch = selectionString[selectionString.index(selectionString.startIndex, offsetBy: i)]
                    if ch == "X" {
                        select(x,y)
                    }else if ch == "?" {
                        unselect(x,y)
                    }
                }
            }
        }
        
    }

    func asString() -> String {
        var result = ""
        for i in 0..<(size*size) {
            if let number = board[i] {
                result = result + "\(number.number)"
            }else {
                result = result + "_"
            }
        }
        return result
    }
    
    func setValue(x: Int, y: Int, value: BoardCell, present: Bool) {
        if present {
            board[y*size+x] = value
        }else {
            board[y*size+x] = nil
        }
        if debug {
            print("Setting \(value) at \(x),\(y)")
        }
    }
    
    func select(_ x: Int, _ y: Int) {
        if let cell = board[y*size+x] {
            cell.selected = true
        }
    }

    func unselect(_ x: Int, _ y: Int) {
        if let cell = board[y*size+x] {
            cell.selected = false
        }
    }

    func valueAt(_ x: Int, _ y: Int) -> BoardCell? {
        if x>=0 && x<size && y>=0 && y<size {
            return board[y*size+x]
        }
        return nil
    }
    
    func printBoard() {
        for y in 0..<size {
            var rowString = ""
            for x in 0..<size {
                if let n = valueAt(x,y) {
                    if n.selected != nil && n.selected! {
                        rowString = rowString + "X"
                    }else {
                        rowString = rowString + "\(n.number)"
                    }
                }else {
                    rowString = rowString + " "
                }
            }
            
            print("\(rowString)")
        }
    }
    
    func isValid(x: Int, y: Int, value: BoardCell) -> Bool {
        let old = valueAt(x,y)
        board[y*size+x] = value
        for y in 0..<size {
            var rowNumbers : [Int] = []
            for x in 0..<size {
                if let n = valueAt(x,y) {
                    if n.selected == nil || !n.selected! {
                        if rowNumbers.contains(n.number) {
                            board[y*size+x] = old
                            return false
                        }
                        rowNumbers.append(n.number)
                    }
                    if n.selected != nil && n.selected! {
                        if let previous = valueAt(x-1,y) {
                            if previous.selected != nil && previous.selected! {
                                board[y*size+x] = old
                                return false
                            }
                        }
                    }
                }
            }
        }
        var notSelectedPositions : [Int] = []
        var notSelectedX : Int?
        var notSelectedY : Int?
        for x in 0..<size {
            var columnNumbers : [Int] = []
            for y in 0..<size {
                if let n = valueAt(x,y) {
                    if n.selected==nil || !n.selected! {
                        if columnNumbers.contains(n.number) {
                            board[y*size+x] = old
                            return false
                        }
                        columnNumbers.append(n.number)
                    }
                    if n.selected != nil && n.selected! {
                        if let previous = valueAt(x,y-1) {
                            if previous.selected != nil && previous.selected! {
                                board[y*size+x] = old
                                return false
                            }
                        }
                    }else {
                        notSelectedPositions.append(y*size+x)
                        notSelectedX = x
                        notSelectedY = y
                    }
                }else {
                    notSelectedPositions.append(y*size+x)
                    notSelectedX = x
                    notSelectedY = y
                }
            }
        }
        
        let fieldPositions = traverseField(x: notSelectedX!, y: notSelectedY!, fieldPositions: [])
        if fieldPositions.count != notSelectedPositions.count {
            board[y*size+x] = old
            return false
        }
        
        board[y*size+x] = old
        return true
        
    }
    
    private func traverseField(x: Int, y: Int, fieldPositions: [Int]) -> [Int] {
        var result = fieldPositions
        let n1 = valueAt(x-1,y)
        if x>0 && (n1 == nil || n1!.selected == nil || !n1!.selected!) {
            let pos = y*size+x-1
            if !result.contains(pos) {
                result.append(pos)
                result = traverseField(x: x-1, y: y, fieldPositions: result)
            }
        }

        let n2 = valueAt(x+1,y)
        if x<size-1 && (n2 == nil || n2!.selected == nil || !n2!.selected!) {
            let pos = y*size+x+1
            if !result.contains(pos) {
                result.append(pos)
                result = traverseField(x: x+1, y: y, fieldPositions: result)
            }
        }
        
        let n3 = valueAt(x,y-1)
        if y>0 && (n3 == nil || n3!.selected == nil || !n3!.selected!) {
            let pos = (y-1)*size+x
            if !result.contains(pos) {
                result.append(pos)
                result = traverseField(x: x, y: y-1, fieldPositions: result)
            }
        }

        let n4 = valueAt(x,y+1)
        if y<size-1 && (n4 == nil || n4!.selected == nil || !n4!.selected!) {
            let pos = (y+1)*size+x
            if !result.contains(pos) {
                result.append(pos)
                result = traverseField(x: x, y: y+1, fieldPositions: result)
            }
        }

        return result
    }
}
