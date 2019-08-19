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
        "2413134213414521154353123",
        "5124111325125212315324412",
        "4244333214145212133542153",
        "4353113152542232134115122",
        "3542112353424135213323145",
        "3253132154243142314251432",
        "1512453141144422145312313",
        "1352442413124133524153134",
        "1124324123435212421112354",
        "2531244213315321342322354",
        "2343242253125125132413235",
        "4145133542523213412532232"
    ]
    let medium : [String] = [
        "3477418323875414422483775642747877123246674124533157673684367521"
    ]
    let hard : [String] = [
        "882351174189843732943735212528146237295817896764549963871464423718682549293272631"
    ]
    let veryHard : [String] = [
        "829537149245476831382746312947811263276821358119658339638994575158968784511293493",
        "953546822417315958641334579192851412295697193539878286272113652938767345362719782"
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
