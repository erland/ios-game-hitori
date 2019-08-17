//
//  GameViewController.swift
//  Hitori
//
//  Created by Erland Isaksson on 2019-08-16.
//  Copyright © 2019 Erland Isaksson. All rights reserved.
//

import SpriteKit
import GameplayKit

#if os(iOS)
import UIKit
public typealias ViewController = UIViewController
#elseif os(OSX)
import Cocoa
public typealias ViewController = NSViewController
#endif
class GameViewController: ViewController, GameDelegate {
    var board: Board?
    
    func finishedGame() {
        selectDifficulty()
    }
    
    func gameComplete(playerName: String, board: Board, seconds: Int, hints: Int) {
        var completed = false
        if board.isValidBoard() {
            BoardStorage().storeCompletedBoard(board: board, seconds: seconds, hints: hints)
            completed = true
        }else {
            BoardStorage().storeBoardInProgress(board: board, seconds: seconds, hints: hints)
        }
        if !completed {
            finishedGame()
        }else {
            if let view = self.view as? SKView {
                // Load the SKScene from 'GameScene.sks'
                if let scene = SKScene(fileNamed: "SingleGameOverScene") as? SingleGameOverScene {
                    // Set the scale mode to scale to fit the window
                    scene.scaleMode = .aspectFit
                    
                    scene.setup(delegate: self, board: board, seconds: seconds)
                    
                    view.presentScene(scene)
                }
            }
        }
    }
    
    func selectedDifficulty(difficulty: Difficulty?) {
        if let view = self.view as? SKView {
            // Load the SKScene from 'GameScene.sks'
            if let scene = SKScene(fileNamed: "SelectLevelScene") as? SelectLevelScene {
                scene.setup(delegate: self, difficulty: difficulty)
                // Set the scale mode to scale to fit the window
                scene.scaleMode = .aspectFit
                view.presentScene(scene)
            }
        }
    }
    
    func selectedCompletedBoards() {
        if let view = self.view as? SKView {
            // Load the SKScene from 'GameScene.sks'
            if let scene = SKScene(fileNamed: "SelectLevelScene") as? SelectLevelScene {
                scene.setup(delegate: self, difficulty: nil, completed: true)
                // Set the scale mode to scale to fit the window
                scene.scaleMode = .aspectFit
                view.presentScene(scene)
            }
        }
    }
    
    func selectedInProgressBoards() {
        if let view = self.view as? SKView {
            // Load the SKScene from 'GameScene.sks'
            if let scene = SKScene(fileNamed: "SelectLevelScene") as? SelectLevelScene {
                scene.setup(delegate: self, difficulty: nil, inProgress: true)
                // Set the scale mode to scale to fit the window
                scene.scaleMode = .aspectFit
                view.presentScene(scene)
            }
        }
    }
    
    
    func selectedBoard(board: Board, startTime: Int) {
        startSingleGame(board: board, startTime: startTime)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //generateBoards(noOfBoards: 3, difficulty: .Easy, size: 6)
        //generateBoards(noOfBoards: 4, difficulty: .Medium, size: 8)
        //generateBoards(noOfBoards: 3, difficulty: .Hard, size: 10)
        //generateBoards(noOfBoards: 5, difficulty: .VeryHard, size: 10)
        //TakuzuRepository().validateBoards()
        selectDifficulty()
    }
    
    private func generateBoards(noOfBoards: Int, difficulty: Difficulty, size: Int) {
        var boards : [String] = []
        while boards.count<noOfBoards {
            if let board = HitoriRepository().getGeneratedBoard(difficulty: difficulty, size: size) {
                if !boards.contains(board) {
                    boards.append(board)
                }
            }
        }
        print("Boards with difficulty: \(difficulty):")
        for board in boards {
            print("\"\(board)\",")
        }
    }
    func selectDifficulty() {
        if let view = self.view as? SKView {
            view.ignoresSiblingOrder = true
            
            if let scene = SKScene(fileNamed: "SelectDifficultyScene") as? SelectDifficultyScene {
                scene.setup(delegate: self)
                // Set the scale mode to scale to fit the window
                scene.scaleMode = .aspectFit
                view.presentScene(scene)
            }
        }
        
    }
    func startSingleGame(board: Board, startTime: Int) {
        if let view = self.view as? SKView {
            // Load the SKScene from 'GameScene.sks'
            if let scene = SKScene(fileNamed: "SingleGameScene") as? SingleGameScene {
                // Set the scale mode to scale to fit the window
                scene.scaleMode = .aspectFit
                
                scene.setup(delegate: self, board: board, startTime: startTime)
                
                view.presentScene(scene)
            }
        }
    }
    
    #if os(iOS)
    override var shouldAutorotate: Bool {
        return true
    }
    
    override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
        if UIDevice.current.userInterfaceIdiom == .phone {
            return .allButUpsideDown
        } else {
            return .all
        }
    }
    
    override var prefersStatusBarHidden: Bool {
        return true
    }
    #endif
}
