//
//  Board.swift
//  Battleship
//
//  Created by Erland Isaksson on 2019-04-29.
//  Copyright © 2019 Erland Isaksson. All rights reserved.
//

import SpriteKit

protocol BoardObserver : class {
    func numberAdded(number: Number)
}
class Board {
    let name: String
    let width: Int
    let height: Int
    let board: Array2D<Number>
    var numbers: Set<Number> = Set()
    var observers: [BoardObserver] = []
    let debug = false
    
    init(name: String, width: Int, height: Int) {
        self.name = name
        self.width = width
        self.height = height
        self.board = Array2D<Number>(columns: width, rows: height)
        for y in 0..<height {
            for x in 0..<width {
                let n = Number(x: x, y: y, number: 0)
                self.board[x,y] = n
                numbers.insert(n)
                for observer in observers {
                    observer.numberAdded(number: n)
                }
            }
        }
    }
    
    init(name: String, board: Array2D<Number>) {
        self.name = name
        self.width = board.columns
        self.height = board.rows
        self.board = board
    }
    
    convenience init(name: String, boardNumbers: String) {
        switch boardNumbers.count {
        case 25:
            self.init(name: name, width: 5, height: 5)
        case 36:
            self.init(name: name, width: 6, height: 6)
        case 49:
            self.init(name: name, width: 7, height: 7)
        case 64:
            self.init(name: name, width: 8, height: 8)
        case 81:
            self.init(name: name, width: 9, height: 9)
        default:
            self.init(name: name, width: 6, height: 6)
        }
        for y in 0..<height {
            for x in 0..<width {
                let i = width*y+x
                if boardNumbers.count > i {
                    let ch = boardNumbers[boardNumbers.index(boardNumbers.startIndex, offsetBy: i)]
                    if ch != "_" {
                        if let num = Int(String(ch)) {
                            board[x,y]!.number = num
                        }
                    }
                }
            }
        }
    }
    
    func initializeStates(stateIndications: String) {
        for y in 0..<height {
            for x in 0..<width {
                let i = width*y+x
                if stateIndications.count > i {
                    let ch = stateIndications[stateIndications.index(stateIndications.startIndex, offsetBy: i)]
                    if ch == "X" {
                        board[x,y]!.state = .Selected
                    }else if ch == "?" {
                        board[x,y]!.state = .Candidate
                    }else {
                        board[x,y]!.state = .Unselected
                    }
                }
            }
        }
    }
    func attachObserver(_ observer: BoardObserver) {
        for number in numbers {
            observer.numberAdded(number: number)
        }
        observers.append(observer)
    }
    
    func detachObserver(_ observer: BoardObserver) {
        if let index = (self.observers.firstIndex(where: { $0 === observer })) {
            self.observers.remove(at: index)
        }
    }
    
    func atPosition(_ x: Int, _ y: Int) -> Number? {
        if x>=0 && x<width && y>=0 && y<height {
            return board[x, y]
        }else {
            return nil
        }
    }
    
    private func isInsideBoard(_ x: Int, _ y: Int) -> Bool {
        if x<0 || x >= width {
            // Outside board
            if debug {
                print("Outside board")
            }
            return false
        }else if y<0 || y >= height {
            if debug {
                print("Outside board")
            }
            return false
        }
        return true
    }
    
    func switchState(x: Int, y: Int) {
        if !isInsideBoard(x, y) {
            return
        }
        if board[x,y] == nil {
            return
        }
        if let n = board[x,y] {
            if n.state == .Selected {
                n.state = .Candidate
            }else if n.state == .Candidate {
                n.state = .Unselected
            }else {
                n.state = .Selected
            }
        }
    }
    
    func isValidBoard() -> Bool {
        for y in 0..<height {
            var rowNumbers : [Int] = []
            for x in 0..<width {
                let n = board[x,y]!
                if n.state != .Selected {
                    if rowNumbers.contains(n.number) {
                        return false
                    }
                    rowNumbers.append(n.number)
                }
                if n.state == .Selected {
                    if let previous = board[x-1,y] {
                        if previous.state == .Selected {
                            return false
                        }
                    }
                }
            }
        }
        var notSelectedPositions : [Int] = []
        var notSelectedX : Int?
        var notSelectedY : Int?
        for x in 0..<width {
            var columnNumbers : [Int] = []
            for y in 0..<height {
                let n = board[x,y]!
                if n.state != .Selected {
                    if columnNumbers.contains(n.number) {
                        return false
                    }
                    columnNumbers.append(n.number)
                }
                if n.state == .Selected {
                    if let previous = board[x,y-1] {
                        if previous.state == .Selected {
                            return false
                        }
                    }
                }else {
                    notSelectedPositions.append(y*width+x)
                    notSelectedX = x
                    notSelectedY = y
                }
            }
        }
        
        let fieldPositions = traverseField(x: notSelectedX!, y: notSelectedY!, fieldPositions: [])
        if fieldPositions.count != notSelectedPositions.count {
            return false
        }
        
        return true

    }
    
    private func traverseField(x: Int, y: Int, fieldPositions: [Int]) -> [Int] {
        var result = fieldPositions
        if let n = board[x-1,y] {
            if n.state != .Selected {
                let pos = y*width+x-1
                if !result.contains(pos) {
                    result.append(pos)
                    result = traverseField(x: x-1, y: y, fieldPositions: result)
                }
            }
        }
        if let n = board[x+1,y] {
            if n.state != .Selected {
                let pos = y*width+x+1
                if !result.contains(pos) {
                    result.append(pos)
                    result = traverseField(x: x+1, y: y, fieldPositions: result)
                }
            }
        }
        if let n = board[x,y-1] {
            if n.state != .Selected {
                let pos = (y-1)*width+x
                if !result.contains(pos) {
                    result.append(pos)
                    result = traverseField(x: x, y: y-1, fieldPositions: result)
                }
            }
        }
        if let n = board[x,y+1] {
            if n.state != .Selected {
                let pos = (y+1)*width+x
                if !result.contains(pos) {
                    result.append(pos)
                    result = traverseField(x: x, y: y+1, fieldPositions: result)
                }
            }
        }
        return result
    }
        
    func asString(withSelections: Bool = false) -> String {
        var result = ""
        for y in 0..<height {
            for x in 0..<width {
                if board[x,y] != nil {
                    let n = board[x,y]!
                    if withSelections && n.state == .Selected {
                        result = result + "X"
                    }else if withSelections && n.state == .Candidate {
                        result = result + "?"
                    }else {
                        result = result + "\(n.number)"
                    }
                }else {
                    result = result + "_"
                }
            }
        }
        return result
    }
    
    func debugBoard(debug: Bool? = nil) {
        if self.debug || (debug != nil && debug!) {
            
            print("Board contents")
            for y in 0..<height {
                for x in 0..<width {
                    if board[x,y] != nil {
                        let n = board[x,y]!
                        if n.state == .Selected {
                            print("X", terminator: "")
                        }else if n.state == .Candidate {
                            print("?", terminator: "")
                        }else {
                            print("\(n.number)", terminator: "")
                        }
                    }else {
                        print("_", terminator: "")
                    }
                }
                print()
            }
        }
    }
    
}
