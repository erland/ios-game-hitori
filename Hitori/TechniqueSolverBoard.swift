//
//  DifficultyCalculator.swift
//  Sudoku
//
//  Created by Erland Isaksson on 2019-06-17.
//  Copyright © 2019 Erland Isaksson. All rights reserved.
//

import Foundation


protocol SolverObserver : class {
    func solverSelect(_ x: Int, _ y: Int)
    func solverUnselect(_ x: Int, _ y: Int)
}

class TechniqueSolverBoard : AbstractSolverBoard {
    var observers: [SolverObserver] = []

    func attachObserver(_ observer: SolverObserver) {
        observers.append(observer)
    }
    
    func detachObserver(_ observer: SolverObserver) {
        if let index = (self.observers.firstIndex(where: { $0 === observer })) {
            self.observers.remove(at: index)
        }
    }

    func solve(techniques: [SolverTechnique], steps: Int? = nil) -> Bool {
        var makesProgress = true
        var solveSteps = 0
        while makesProgress {
            makesProgress = false
            for t in techniques {
                if solve(technique: t) {
                    solveSteps = solveSteps + 1
                    makesProgress = true
                    break
                }
            }
            if steps != nil && steps! <= solveSteps {
                makesProgress = false
            }
        }
        for i in 0..<(size*size) {
            if board[i] == nil {
                return false
            }
        }
        return true
    }
    
    func solve(technique: SolverTechnique) -> Bool {
        for y in 0..<size {
            for x in 0..<size {
                if board[y*size+x] != nil && board[y*size+x]!.selected == nil {
                    if technique.solvePosition(board: self, x: x, y: y) {
                        return true
                    }
                }
            }
        }
        return false
    }
    
    override func select(_ x: Int, _ y: Int) {
        super.select(x, y)
        for observer in observers {
            observer.solverSelect(x,y)
        }
    }
    
    override func unselect(_ x: Int, _ y: Int) {
        super.unselect(x, y)
        for observer in observers {
            observer.solverUnselect(x,y)
        }
    }
}
