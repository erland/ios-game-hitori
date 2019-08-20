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
    var fieldHelper: FieldHelper?

    init(boardString: String, debug: Bool = false) {
        self.debug = debug
        let numbers = boardString.replacingOccurrences(of: " ", with: "")
        size = AbstractSolverBoard.sizeOfBoard(boardString: numbers)
        board = Array<BoardCell?>(repeating: nil, count:size * size)
        fieldHelper = FieldHelper(board: self)
        initializeBoard(boardString: numbers)
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
        let numbers = boardString.replacingOccurrences(of: " ", with: "")
        size = AbstractSolverBoard.sizeOfBoard(boardString: numbers)
        board = Array<BoardCell?>(repeating: nil, count:size * size)
        
        for y in 0..<size {
            for x in 0..<size {
                let i = size*y+x
                if numbers.count > i {
                    let ch = numbers[numbers.index(numbers.startIndex, offsetBy: i)]
                    if let num = Int(String(ch)) {
                        setValue(x: x,y: y, value: BoardCell(number: num, selected: nil), present: true)
                    }
                }
            }
        }
        
    }

    func initializeSelections(selectionString: String) {
        let selections = selectionString.replacingOccurrences(of: " ", with: "")
        for y in 0..<size {
            for x in 0..<size {
                let i = size*y+x
                if selections.count > i {
                    let ch = selections[selections.index(selections.startIndex, offsetBy: i)]
                    if ch == "X" {
                        select(x,y)
                    }else if ch == "?" {
                        unselect(x,y)
                    }else {
                        valueAt(x,y)?.selected = nil
                    }
                }
            }
        }
        
    }

    func solutionAsString() -> String {
        var result = ""
        for i in 0..<(size*size) {
            if let number = board[i] {
                if number.selected != nil && number.selected! {
                    result = result + "X"
                }else {
                    result = result + "_"
                }
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
    func valueAt(_ x: Int, _ y: Int, unsafe: Bool) -> BoardCell? {
        if unsafe {
            return board[y*size+x]
        }else {
            return valueAt(x,y)
        }
    }

    func printBoard() {
        for y in 0..<size {
            var rowString = ""
            for x in 0..<size {
                if let n = valueAt(x,y) {
                    rowString = rowString + "\(n.number) "
                }else {
                    rowString = rowString + "  "
                }
            }
            rowString = rowString + "   "
            for x in 0..<size {
                if let n = valueAt(x,y) {
                    if n.selected != nil && n.selected! {
                        rowString = rowString + "X "
                    }else {
                        rowString = rowString + "  "
                    }
                }else {
                    rowString = rowString + "  "
                }
            }
            
            print("\(rowString)")
        }
    }
    
    func isValid(x: Int, y: Int, selected: Bool) -> Bool {
        let old = valueAt(x,y)?.selected
        defer {
            valueAt(x, y)?.selected = old
        }
        valueAt(x, y)?.selected = selected
        for y in 0..<size {
            var rowNumbers : [Int] = []
            for x in 0..<size {
                if let n = valueAt(x,y) {
                    if n.selected != nil && !n.selected! {
                        if rowNumbers.contains(n.number) {
                            return false
                        }
                        rowNumbers.append(n.number)
                    }
                    if n.selected != nil && n.selected! {
                        if let previous = valueAt(x-1,y) {
                            if previous.selected != nil && previous.selected! {
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
        var checkPartition = false
        if selected {
            checkPartition = true
        }
        for x in 0..<size {
            var columnNumbers : [Int] = []
            for y in 0..<size {
                if let n = valueAt(x,y) {
                    if n.selected != nil && !n.selected! {
                        if columnNumbers.contains(n.number) {
                            return false
                        }
                        columnNumbers.append(n.number)
                    }
                    if n.selected != nil && n.selected! {
                        if let previous = valueAt(x,y-1) {
                            if previous.selected != nil && previous.selected! {
                                return false
                            }
                        }
                    }else {
                        if checkPartition {
                            notSelectedPositions.append(y*size+x)
                            notSelectedX = x
                            notSelectedY = y
                        }
                    }
                }else {
                    if checkPartition {
                        notSelectedPositions.append(y*size+x)
                        notSelectedX = x
                        notSelectedY = y
                    }
                }
            }
        }
        
        if checkPartition {
            var nearByCells = 0
            nearByCells = nearByCells + fieldBorderContribution(x-1,y-1)
            nearByCells = nearByCells + fieldBorderContribution(x+1,y-1)
            nearByCells = nearByCells + fieldBorderContribution(x-1,y+1)
            nearByCells = nearByCells + fieldBorderContribution(x+1,y+1)
            if nearByCells>=2 {
                let fieldSize = fieldHelper!.sizeOfField(notSelectedX!, notSelectedY!)
                if fieldSize != notSelectedPositions.count {
                    return false
                }
            }
        }
        
        return true
        
    }
    
    private func fieldBorderContribution(_ x: Int, _ y: Int) -> Int {
        if let n = valueAt(x,y) {
            if n.selected == nil || !n.selected! {
                return 0
            }
        }
        return 1
    }
}
