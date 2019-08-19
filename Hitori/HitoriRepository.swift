//
//  SudokuRepository.swift
//  Sudoku
//
//  Created by Erland Isaksson on 2019-06-16.
//  Copyright © 2019 Erland Isaksson. All rights reserved.
//

import Foundation

class HitoriRepository {
    let easy : [String] = [
        "2423455214351321542512344",
        "5522421453513145354234324",
        "5443213135352141543345322",
        "3525151342342243255421435",
        "1252425544423123455412431",
        "1135545132512513125344513",
        "3234254351445325321455112",
        "1235213314415521423235341",
        "3151322135532141245232514",
        "5231345422233541154541435",
        "5233135151435221532341241",
        "4153422154153322352524533",
        "1235432244131525132314514",
        "2415142513351425245343123",
        "1534211334355212312455214",
        "3152532443231253445515432",
        "2433141451421234331515321",
        "4421121354452231523152241",
        "4532243324512234433132541",
        "5124545433124135345154313",
        "5122452154453315321234235",
        "5315121523541321242553124"
    ]
    let medium : [String] = [
        "7361654517571333124255273661567751445326125472376",
        "2161234676321431576745476331552426771625444137225",
        "5217163753317235461526426741455162276762457334546",
        "1275324214465313277131665275764572136427634715536",
        "6422365253477644367257332114624173764122155673412",
        "4252341771265443722114551632673462557431373455661",
        "7253647146332513744675223137616547742327163213457",
        "3312677427235513636241147247264155713224167446155",
        "2313574243126475625415763724215641237731566743514"
    ]
    let hard : [String] = [
        "4478117353574612615617742455336168121577865412786532634862515388",
        "6354834554162381671882756511387562845477311485688635477272428135",
        "2762753878543366468853578721174535871856474216165286837447831156",
        "4325116728833664657317124832554116781572584328663456158278138252",
        "5118433423726651355483147211686514253384281651242538637426176348"
    ]
    let veryHard : [String] = [
        "857446186717959243925681126348429176827738696534279951426492157897419732889437554",
        "542696738875142254638652431916783714125498937413679786885612739817665392211394764",
        "325342998687782194934862511342713796585744621388456271351649647495175692319722461",
        "529694831231762751155297339216476893278724641956851824852714467654793538293744871"
    ]

    func validateBoards() -> Bool {
        var success = true
        for difficulty in [Difficulty.Easy, Difficulty.Medium, Difficulty.Hard, Difficulty.VeryHard] {
            var level = 1
            var board = getBoard(difficulty: difficulty, level: level)
            while board != nil {
                let solver = BruteForceSolverBoard.init(boardString: board!)
                if !solver.solve() {
                    success = false
                    print("Failed to solve \(difficulty) \(level)")
                    solver.printBoard()
                }else {
                    print("Successfully validated \(difficulty) \(level)")
                    //print("\(difficulty) \(level) estimated as: \(calculateDifficulty(boardNumbers: board!))")
                }
                level = level + 1
                board = getBoard(difficulty: difficulty, level: level)
            }
        }
        if success {
            print("Successfully validated all boards")
        }
        return success
    }
    
    func getBoard(difficulty: Difficulty, level: Int) -> String? {
        var levelNo = level
        if level < 1 {
            return nil
        }
        levelNo = level - 1

        switch difficulty {
        case .Easy:
            if levelNo<easy.count {
                return easy[levelNo]
            }
        case .Medium:
            if levelNo<medium.count {
                return medium[levelNo]
            }
        case .Hard:
            if levelNo<hard.count {
                return hard[levelNo]
            }
        case .VeryHard:
            if levelNo<veryHard.count {
                return veryHard[levelNo]
            }
        }
        return nil
    }
    
    func calculateDifficulty(boardNumbers: String) -> Difficulty {
        /*
        if TechniqueSolverBoard(boardString: boardNumbers, debug: false).solve(techniques: [Pair(),CompleteRowColumn()]) {
            return Difficulty.Easy
        }else if TechniqueSolverBoard(boardString: boardNumbers, debug: false).solve(techniques: [Pair(),
                                                                                                  CompleteRowColumn(),
                                                                                                  AvoidTrio()]) {
            return Difficulty.Medium
        }else if TechniqueSolverBoard(boardString: boardNumbers, debug: false).solve(techniques: [Pair(),
                                                                                                  CompleteRowColumn(),
                                                                                                  AvoidTrio(),
                                                                                                  HiddenTrio(),
                                                                                                  MultipleHiddenTrio()]) {
            return Difficulty.Hard
        }else if TechniqueSolverBoard(boardString: boardNumbers, debug: false).solve(techniques: [Pair(),
                                                                                                  CompleteRowColumn(),
                                                                                                  AvoidTrio(),
                                                                                                  HiddenTrio(),
                                                                                                  MultipleHiddenTrio(),
                                                                                                  UniqueRowColumn()]) {
            return Difficulty.VeryHard
        }else {
            print("Unable to solve board with implemented techniques")
            return Difficulty.VeryHard
        }
 */
        return Difficulty.VeryHard
    }
    
    func getGeneratedBoard(size: Int) -> String? {
        let generator = BoardGenerator(size: size)
        /*
        return generator.generateWithLimits(maxTechniques: [Pair(),
                                                            CompleteRowColumn(),
                                                            AvoidTrio(),
                                                            HiddenTrio(),
                                                            UniqueRowColumn()],
                                            maxNumbers: 11, timeoutSeconds: 120)
 */
        return nil
    }
    

    func getGeneratedBoard(difficulty: Difficulty, size: Int) -> String? {
        let generator = BoardGenerator(size: size)
        /*
        switch difficulty {
        case .Easy:
            return generator.generateWithLimits(maxTechniques: [Pair(),
                                                             CompleteRowColumn()],
                                                maxNumbers: Int(0.33*Double(size*size)), timeoutSeconds: 120)
        case .Medium:
            return generator.generateWithLimits(tooEasyTechniques: [Pair(),
                                                                      CompleteRowColumn()],
                                                maxTechniques: [Pair(),
                                                             CompleteRowColumn(),
                                                             AvoidTrio()],
                                                maxNumbers: Int(0.28 * Double(size * size)), timeoutSeconds: 120)
        case .Hard:
            return generator.generateWithLimits(tooEasyTechniques: [Pair(),
                                                                    CompleteRowColumn(),
                                                                    AvoidTrio()],
                                                maxTechniques: [Pair(),
                                                             CompleteRowColumn(),
                                                             AvoidTrio(),
                                                             HiddenTrio(),
                                                             MultipleHiddenTrio()],
                                                maxNumbers: Int(0.25*Double(size*size)), timeoutSeconds: 120)
        case .VeryHard:
            return generator.generateWithLimits(tooEasyTechniques: [Pair(),
                                                                    CompleteRowColumn(),
                                                                    AvoidTrio(),
                                                                    HiddenTrio(),
                                                                    MultipleHiddenTrio()],
                                                maxTechniques: [Pair(),
                                                             CompleteRowColumn(),
                                                             AvoidTrio(),
                                                             HiddenTrio(),
                                                             MultipleHiddenTrio(),
                                                             UniqueRowColumn()],
                                                maxNumbers: Int(0.23*Double(size*size)), timeoutSeconds: 120)
        }
 */
        return nil
    }
}
