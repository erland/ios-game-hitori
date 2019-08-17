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
            if let cellPos = boardView?.cellForLocation(position: position) {
                boardView?.board?.switchState(x: cellPos.x, y: cellPos.y)
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
        hints = hints + 1
        hintName?.isHidden = false
        hintName?.fontColor = SKColor.green
        
        if solver.solve(technique: AdjacentTriplets()) {
            print("Showed solution with Adjacent Triples")
            hintName?.text = NSLocalizedString("hintAdjacentTriplets", comment: "Adjacent Triples")
        }else if solver.solve(technique: SquareBetweenPair()) {
            print("Showed solution with Square Between Pair")
            hintName?.text = NSLocalizedString("hintSquareBetweenPair", comment: "Square Between Pair")
        }else if solver.solve(technique: PairInduction()) {
            print("Showed solution with Pair Induction")
            hintName?.text = NSLocalizedString("hintPairInduction", comment: "Pair Induction")
        }else if solver.solve(technique: ShadingInRowsColumns()) {
            print("Showed solution with Shading In Rows Columns")
            hintName?.text = NSLocalizedString("hintShadingInRowsColumns", comment: "Shading In Rows Columns")
        }else if solver.solve(technique: UnshadeAroundShaded()) {
            print("Showed solution with Unshade Around Shaded")
            hintName?.text = NSLocalizedString("hintUnshadeAroundShaded", comment: "Unshade Around Shaded")
        }else if solver.solve(technique: UnshadeToAvoidPartition()) {
            print("Showed solution with Unshade To Avoid Partition")
            hintName?.text = NSLocalizedString("hintUnshadeToAvoidPartition", comment: "Unshade To Avoid Partition")
        }else if solver.solve(technique: ShadeCornerWithPairs()) {
            print("Showed solution with Shade Corner With Pairs")
            hintName?.text = NSLocalizedString("hintShadeCornerWithPairs", comment: "Shade Corner With Pairs")
        }else if solver.solve(technique: PairInCorner()) {
            print("Showed solution with Pair In Corner")
            hintName?.text = NSLocalizedString("hintPairInCorner", comment: "Pair In Corner")
        }else if solver.solve(technique: TwoPairsInCorner()) {
            print("Showed solution with Two Pairs In Corner")
            hintName?.text = NSLocalizedString("hintTwoPairsInCorner", comment: "Two Pairs In Corner")
        }else if solver.solve(technique: TwoPairsAtBorder()) {
            print("Showed solution with Two Pairs At Border")
            hintName?.text = NSLocalizedString("hintTwoPairsAtBorder", comment: "Two Pairs At Border")
        }else if solver.solve(technique: PairAndCrossedPair()) {
            print("Showed solution with Pair And Crossed Pair")
            hintName?.text = NSLocalizedString("hintPairAndCrossedPair", comment: "Two Pairs And Crossed Pair")
        }else if solver.solve(technique: TwoPairsWithNumberBetween()) {
            print("Showed solution with Two Pairs With Number Between")
            hintName?.text = NSLocalizedString("hintTwoPairsWithNumberBetween", comment: "Two Pairs With Number Between")
        }else if solver.solve(technique:
            LookForwardToAvoidPartition(techniques: [
                UnshadeAroundShaded(),
                ShadingInRowsColumns(),
                UnshadeToAvoidPartition()])) {
            print("Showed solution with Look Forward To Avoid Partition")
            hintName?.text = NSLocalizedString("hintLookForwardToAvoidPartition", comment: "Look Forward To Avoid Partition")
        }else {
            hints = hints - 1
            hintName?.fontColor = Color.orange
            hintName?.text = NSLocalizedString("noHintAvailable", comment: "noHintAvailable")
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
