//
//  Number.swift
//  Sudoku
//
//  Created by Erland Isaksson on 2019-06-14.
//  Copyright © 2019 Erland Isaksson. All rights reserved.
//


import SpriteKit

protocol NumberObserver {
    func numberUpdated(number: Number)
}

enum NumberState {
    case Unselected
    case Selected
    case Candidate
}

class Number : Hashable, NSCopying {
    var observers: [NumberObserver] = []
    
    init(x: Int, y: Int, number: Int) {
        self.x = x
        self.y = y
        self.number = number
        self.state = .Unselected
        self.error = false
    }
    
    func copy(with zone: NSZone? = nil) -> Any {
        let copy = Number(x: self.x,y: self.y, number: self.number)
        copy.error = self.error
        copy.state = self.state
        
        return copy
    }
    
    func attachObserver(observer: NumberObserver) {
        observers.append(observer)
    }
    
    private func notifyObservers() {
        for observer in observers {
            observer.numberUpdated(number: self)
        }
    }
    var x: Int {
        didSet {
            notifyObservers()
        }
    }
    var y: Int {
        didSet {
            notifyObservers()
        }
    }
    var number: Int {
        didSet {
            notifyObservers()
        }
    }
    var state: NumberState {
        didSet {
            notifyObservers()
        }
    }
    var error: Bool {
        didSet {
            notifyObservers()
        }
    }
    static func == (lhs: Number, rhs: Number) -> Bool {
        return lhs === rhs
    }
    var hashValue: Int {
        return x.hashValue ^ y.hashValue
    }
}

