//
//  BoardGenerator.swift
//  Sudoku
//
//  Created by Erland Isaksson on 2019-06-22.
//  Copyright © 2019 Erland Isaksson. All rights reserved.
//

import Foundation

class BoardGenerator {
    let size : Int
    init(size: Int) {
        self.size = size
    }
    func generateWithLimits(tooEasyTechniques: [SolverTechnique] = [], maxTechniques: [SolverTechnique] = [], timeoutSeconds: TimeInterval) -> String? {
        var board : String?
        
        let expirationTime = Date(timeIntervalSinceNow: timeoutSeconds)
        while board == nil && expirationTime>Date(){
            let boardWithSelections = generateSelectionBoard()
            let positions = freePositions(board: boardWithSelections)
            //print("Starting with")
            //boardWithSelections.printBoard()
            board = generate(positions: positions, board: boardWithSelections, expirationTime: expirationTime)
            if board != nil {
                //print("Checking generated board")
                if tooEasyTechniques.count > 0 {
                    if TechniqueSolverBoard(boardString: board!, debug: false).solve(techniques: tooEasyTechniques) {
                        AbstractSolverBoard(boardString: board!, debug: false).printBoard()
                        print("Discarding too easy board")
                        board = nil
                    }
                }
                if board != nil && maxTechniques.count > 0 {
                    if !TechniqueSolverBoard(boardString: board!, debug: false).solve(techniques: maxTechniques) {
                        AbstractSolverBoard(boardString: board!, debug: false).printBoard()
                        print("Discarding too hard board")
                        board = nil
                    }
                }
            }
        }
        return board
    }
    
    func generateSelectionBoard() -> AbstractSolverBoard {
        var board = generateSelections()
        while board == nil {
            board = generateSelections()
        }
        return board!
    }
    
    func generateSelections() -> AbstractSolverBoard? {
        
        var boardString = ""
        var selectString = ""
        for y in 0..<size {
            for x in 0..<size {
                boardString = boardString + "\((y*size+x+y)%size+1)"
                selectString = selectString + "_"
            }
        }
        
        let board = AbstractSolverBoard(boardString: boardString)
        var availablePositions = Set<Int>(0..<size*size)
        let noOfSelections = Int(size * size * 30 / 100)
        for _ in 0..<noOfSelections {
            var validPosition = false
            while !validPosition && availablePositions.count>0 {
                let pos = availablePositions.shuffled()[0]
                var characters = Array(selectString)
                characters[pos] = "X"
                board.initializeSelections(selectionString: String(characters))
                if board.isValid(x: pos%size, y: Int(pos/size), selected: true) {
                    selectString = String(characters)
                    availablePositions.remove(pos)
                    let x = pos%size
                    let y = Int(pos/size)
                    if y>0 {
                        availablePositions.remove((y-1)*size+x)
                    }
                    if y<size-1 {
                        availablePositions.remove((y+1)*size+x)
                    }
                    if x>0 {
                        availablePositions.remove(y*size+x-1)
                    }
                    if x<size-1 {
                        availablePositions.remove(y*size+x+1)
                    }
                    validPosition = true
                }else {
                    availablePositions.remove(pos)
                }
            }
        }

        let candidates = (1...size).shuffled()
        for y in 0..<size {
            for x in 0..<size {
                let n = board.valueAt(x, y)!
                if n.selected != nil && n.selected! {
                    n.number = candidates[(y*size+x)%size]
                }else {
                    n.number = 0
                }
            }
        }
        for y in 0..<size {
            for x in 0..<size {
                let n = board.valueAt(x, y)!
                if n.selected != nil && n.selected! {
                    if !numberAlreadyInRowColumn(board: board, x: x, y: y, number: n.number) {
                        let positions = freePositionsInRowColumn(board: board, x: x, y: y)
                        if positions.count>0 {
                            let pos = positions.shuffled()[0]
                            board.valueAt(pos%size, Int(pos/size))?.number = n.number
                        }else {
                            return nil
                        }
                    }
                }
            }
        }
        
        /*
        for y in 0..<size {
            for x in 0..<size {
                let n = board.valueAt(x, y)!
                if n.number == 0 {
                    let numbers = freeNumbersInRowColumn(board: board, x: x, y: y)
                    let result = boardAsString(board: board)
                    print(result)
                    if numbers.count>0 {
                        let number = numbers.shuffled()[0]
                        board.valueAt(x,y)?.number = number
                    }else {
                        return nil
                    }
                }
            }
        }
        */
        return board
    }
    
    func numberAlreadyInRowColumn(board: AbstractSolverBoard, x: Int, y: Int, number: Int) -> Bool {
        for posY in 0..<board.size {
            if posY != y {
                let n = board.valueAt(x,posY)!
                if n.number == number && n.selected == nil {
                    return true
                }
            }
        }
        for posX in 0..<board.size {
            if posX != x {
                let n = board.valueAt(posX,y)!
                if n.number == number  && n.selected == nil {
                    return true
                }
            }
        }
        return false
    }

    func freePositions(board: AbstractSolverBoard) -> [Int] {
        var result : [Int] = []
        for y in 0..<board.size {
            for x in 0..<board.size {
                let n = board.valueAt(x,y)!
                if n.selected == nil && n.number == 0 {
                    result.append(y*board.size+x)
                }
            }
        }
        return result
    }

    func freePositionsInRowColumn(board: AbstractSolverBoard, x: Int, y: Int) -> [Int] {
        var result : [Int] = []
        let rowPos = freePositionsInRow(board: board, y: y)
        for pos in rowPos {
            result.append(y*board.size+pos)
        }
        let columnPos = freePositionsInColumn(board: board, x: x)
        for pos in columnPos {
            result.append(pos*board.size+x)
        }
        return result
    }

    func freePositionsInRow(board: AbstractSolverBoard, y: Int) -> [Int] {
        var result : [Int] = []
        for x in 0..<board.size {
            let n = board.valueAt(x,y)!
            if n.selected == nil && n.number == 0 {
                result.append(x)
            }
        }
        return result
    }
    func freePositionsInColumn(board: AbstractSolverBoard, x: Int) -> [Int] {
        var result : [Int] = []
        for y in 0..<board.size {
            let n = board.valueAt(x,y)!
            if n.selected == nil && n.number == 0 {
                result.append(y)
            }
        }
        return result
    }

    func freeNumbersInRowColumn(board: AbstractSolverBoard, x: Int, y: Int) -> [Int] {
        var result = Set<Int>(1...board.size)
        for y in 0..<board.size {
            let n = board.valueAt(x, y)!
            if n.selected == nil {
                result.remove(n.number)
            }
        }
        for x in 0..<board.size {
            let n = board.valueAt(x,y)!
            if n.selected == nil {
                result.remove(n.number)
            }
        }
        return Array(result)
    }
    
    func selectionsInRow(board: AbstractSolverBoard, y: Int) -> [Int] {
        var result = Set<Int>()
        for x in 0..<board.size {
            let n = board.valueAt(x,y)!
            if n.selected != nil && n.selected! {
                result.insert(n.number)
            }
        }
        return Array(result)
    }
    
    func selectionsInColumn(board: AbstractSolverBoard, x: Int) -> [Int] {
        var result = Set<Int>()
        for y in 0..<board.size {
            let n = board.valueAt(x,y)!
            if n.selected != nil && n.selected! {
                result.insert(n.number)
            }
        }
        return Array(result)
    }

    
    func generate(positions: [Int], board: AbstractSolverBoard, expirationTime: Date) -> String? {
        if expirationTime<Date() {
            return nil
        }
        if positions.count>0 {
            let pos = positions[0]
            let x = pos%board.size
            let y = Int(pos/board.size)
            let numbers = freeNumbersInRowColumn(board: board, x: x, y: y)
            for num in numbers.shuffled() {
                board.valueAt(x,y)?.number = num
                let modifiedPositions = positions.filter { $0 != pos }
                if let boardString = generate(positions: modifiedPositions, board: board, expirationTime: expirationTime) {
                    return boardString
                }
                board.valueAt(x,y)?.number = 0
            }
        }else {
            let boardString = boardAsString(board: board)
            //print("Trying to solve:")
            //print("Trying:\(boardString)")
            let solver = BruteForceSolverBoard(boardString: boardString)
            if solver.solve() {
                return boardString
            }else {
                //print("Failed:\(boardAsString(board: board))")
                //board.printBoard()
            }
        }
        return nil
    }
    
    func boardAsString(board: AbstractSolverBoard) -> String {
        var result = ""
        for y in 0..<board.size {
            for x in 0..<board.size {
                result = result + "\(board.valueAt(x,y)!.number)"
            }
        }
        return result
    }
}
