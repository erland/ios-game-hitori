//
//  SingleGameScene.swift
//  Sudoku
//
//  Created by Erland Isaksson on 2019-06-14.
//  Copyright © 2019 Erland Isaksson. All rights reserved.
//

import SpriteKit
import GameplayKit

class SingleGameScene: SKScene, BoardObserver, SolverObserver {
    var gameDelegate: GameDelegate?
    var boardView : BoardView?
    var eraseButton : SKLabelNode?
    var clearButton : SKLabelNode?
    var selectedPos : IntPosition?
    var showHintButton : SKLabelNode?
    var quitButton : SKLabelNode?
    var hintName : SKLabelNode?
    var timeText : SKLabelNode?
    var recordLabel : SKLabelNode?
    var recordTime : SKLabelNode?
    var boardName : SKLabelNode?
    var invalidBoard : SKLabelNode?
    var timeCounter : Int = 0
    var record : Int?
    var hints = 0
    var readyForInput = true

    override func sceneDidLoad() {
        localize()
    }
    
    func setup(delegate: GameDelegate, board: Board, startTime: Int) {
        self.gameDelegate = delegate
        
        self.boardView = childNode(withName: "board") as? BoardView
        self.eraseButton = childNode(withName: "erase") as? SKLabelNode
        self.quitButton = childNode(withName: "quit") as? SKLabelNode
        self.clearButton = childNode(withName: "clear") as? SKLabelNode
        self.boardName = childNode(withName: "boardName") as? SKLabelNode
        self.invalidBoard = childNode(withName: "invalidBoard") as? SKLabelNode
        self.invalidBoard?.isHidden = true
        self.boardName?.text = board.name
        self.showHintButton = childNode(withName: "showHint") as? SKLabelNode
        self.hintName = childNode(withName: "hintName") as? SKLabelNode
        self.hintName?.isHidden = true
        print("Setup board view for \(board.name)")
        self.boardView?.setup(board: board)
        self.timeText = childNode(withName: "time") as? SKLabelNode
        self.recordLabel = childNode(withName: "record") as? SKLabelNode
        self.recordTime = childNode(withName: "recordTime") as? SKLabelNode
        record = BoardStorage().getRecord(board: board)
        if record != nil {
            recordTime?.text = timeAsString(record!)
        }else {
            recordLabel?.isHidden = true
            recordTime?.isHidden = true
        }
        timeCounter = startTime
        displayTime()

        
        boardView?.board?.attachObserver(self)
    }
    deinit {
        boardView?.board?.detachObserver(self)
    }
    
    override func didMove(to view: SKView) {
        print("Moved to game scene")
        Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(updateTimer), userInfo: nil, repeats: true)
        
    }
    
    @objc func updateTimer() {
        timeCounter = timeCounter + 1
        displayTime()
    }
    
    func timeAsString(_ seconds: Int) -> String {
        let hours = Int(seconds/3600)
        let minutes = String(format: "%02d",Int((seconds%3600)/60))
        let seconds = String(format: "%02d",Int(seconds%60))
        if hours == 0 {
            return  "\(minutes):\(seconds)"
        }else {
            return "\(hours):\(minutes):\(seconds)"
        }
    }

    func displayTime() {
        if record != nil && timeCounter>record! {
            timeText?.fontColor = .red
        }
        timeText?.text = "\(timeAsString(timeCounter))"
    }
    #if os(iOS)
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        guard let touch = touches.first else {
            return
        }
        touchesBegan(at: touch.location(in: self))
    }
    #elseif os(OSX)
    override func mouseDown(with event: NSEvent) {
        touchesBegan(at: event.location(in: self))
    }
    #endif
    
    func touchesBegan(at touchLocation: CGPoint) {
        switchNumberState(position: touchLocation)
    }
    
    func switchNumberState(position: CGPoint) {
        boardView?.clearSolverCells()
        hintName?.isHidden = true
        if boardView!.contains(position) {
            if readyForInput {
                if let cellPos = boardView?.cellForLocation(position: position) {
                    boardView?.board?.switchState(x: cellPos.x, y: cellPos.y)
                }
            }
        }else if quitButton!.contains(position) {
            gameDelegate?.gameComplete(playerName: boardView!.board!.name, board: boardView!.board!, seconds: timeCounter, hints: hints)
        }else if clearButton!.contains(position) {
            clearBoard()
        }else if showHintButton!.contains(position) {
            showHint()
        }
        checkAndProcessGameEnding()
    }
    func clearBoard() {
        for y in 0..<boardView!.board!.height {
            for x in 0..<boardView!.board!.width {
                let number = boardView!.board!.atPosition(x, y)
                number?.state = .Unselected
            }
        }
    }

    func showHint() {
        readyForInput = false
        boardView?.clearSolverCells()
        let boardString = boardView!.board!.asString()
        let solver = TechniqueSolverBoard(boardString: boardString, debug: false)
        for y in 0..<boardView!.board!.height {
            for x in 0..<boardView!.board!.width {
                let n = boardView!.board!.atPosition(x, y)!
                if n.state == .Selected {
                    solver.select(x, y)
                }else if n.state == .Candidate {
                    solver.unselect(x, y)
                }
            }
        }
        solver.attachObserver(self)
        hintName?.isHidden = false
        hintName?.fontColor = SKColor.gray
        hintName?.text = NSLocalizedString("hintSearching", comment: "Searching for hint")
        
        DispatchQueue.global().async {
            if solver.solve(technique: AdjacentTriplets()) {
                self.displayHint("AdjacentTriplets")
            }else if solver.solve(technique: SquareBetweenPair()) {
                self.displayHint("SquareBetweenPair")
            }else if solver.solve(technique: PairInduction()) {
                self.displayHint("PairInduction")
            }else if solver.solve(technique: ShadingInRowsColumns()) {
                self.displayHint("ShadingInRowsColumns")
            }else if solver.solve(technique: UnshadeAroundShaded()) {
                self.displayHint("UnshadeAroundShaded")
            }else if solver.solve(technique: UnshadeToAvoidPartition()) {
                self.displayHint("UnshadeToAvoidPartition")
            }else if solver.solve(technique: ShadeCornerWithPairs()) {
                self.displayHint("ShadeCornerWithPairs")
            }else if solver.solve(technique: PairInCorner()) {
                self.displayHint("PairInCorner")
            }else if solver.solve(technique: TwoPairsInCorner()) {
                self.displayHint("TwoPairsInCorner")
            }else if solver.solve(technique: TwoPairsAtBorder()) {
                self.displayHint("TwoPairsAtBorder")
            }else if solver.solve(technique: PairAndCrossedPair()) {
                self.displayHint("PairAndCrossedPair")
            }else if solver.solve(technique: TwoPairsWithNumberBetween()) {
                self.displayHint("TwoPairsWithNumberBetween")
            }else if solver.solve(technique:
                LookForwardToAvoidPartition(techniques: [
                    UnshadeAroundShaded(),
                    ShadingInRowsColumns(),
                    UnshadeToAvoidPartition()], steps: 2)) {
                self.displayHint("LookForwardToAvoidPartitionClose")
            }else if solver.solve(technique:
                LookForwardToAvoidPartition(techniques: [
                    UnshadeAroundShaded(),
                    ShadingInRowsColumns(),
                    UnshadeToAvoidPartition()], steps: 6)) {
                self.displayHint("LookForwardToAvoidPartitionSoon")
            }else if solver.solve(technique:
                LookForwardToAvoidPartition(techniques: [
                    UnshadeAroundShaded(),
                    ShadingInRowsColumns(),
                    UnshadeToAvoidPartition()])) {
                self.displayHint("LookForwardToAvoidPartitionUnlimited")
            }else {
                self.displayHint(nil)
            }
        }
    }
    
    func displayHint(_ hintKey: String?) {
        DispatchQueue.main.async {
            if hintKey != nil {
                self.hints = self.hints + 1
                self.hintName?.fontColor = Color.green
                print("Showing hint for \(hintKey!)")
                self.hintName?.text = NSLocalizedString("hint"+hintKey!, comment: hintKey!)
            }else {
                self.hintName?.fontColor = Color.orange
                self.hintName?.text = NSLocalizedString("noHintAvailable", comment: "noHintAvailable")
            }
            self.readyForInput = true
        }
    }
    
    func solverSelect(_ x: Int, _ y: Int) {
        boardView?.addSolverCellSelected(x: x, y: y)
    }
    
    func solverUnselect(_ x: Int, _ y: Int) {
        boardView?.addSolverCellUnselected(x: x, y: y)
    }
    

    func checkAndProcessGameEnding() {
        if boardView!.board!.isValidBoard() {
            gameDelegate?.gameComplete(playerName: boardView!.board!.name, board: boardView!.board!, seconds: timeCounter, hints: hints)
        }else {
            invalidBoard?.isHidden = true
        }
        
    }
    
    func numberAdded(number: Number) {
        // TODO: Calculate game over
    }
    func numberRemoved(number: Number) {
        // TODO: Nothing ?
    }

}
