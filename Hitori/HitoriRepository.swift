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
        "1332332415511312334154143",
        "3234451432454152335434511",
        "5453243215355253554212324",
        "4144153214223352445335112",
        "3534434152223142543153244",
        "4453241523252435541223154",
        "2551141325121331545224513",
        "2215523514255433142141312",
        "1224141235351145542313554",
        "5142253412353413225424553"
    ]
    let medium : [String] = [
        "3745235637145235272444711265142327421546237254351",
        "6366616346217521553352534641524126465147267617422",
        "5645276271654363424161745357713456545772346473155",
        "1613446512763444553611566325274655765214733217766",
        "6345745714235664275612136614175362742667354614223",
        "7443721415673266271453441516136447517112656233127",
        "1176257327514613347762751367156772366315325433641",
        "3524526341265712633111763532632774661154734751116",
        "6427767671342515127354433172562471532365413174614",
        "4174475134725642416636124135367271257663212566467"
    ]
    let hard : [String] = [
        "6153872653248617157172534182637562451338864844512574568278162534",
        "5514273648327651615663445371433816835442243782832661857682453167",
        "8654472871632854126835676171854514275653683554363548186487564312",
        "7518848672351864541645886814782543218667112277838176271536845172",
        "6355561848615237343341428222347462478345674678215871458631582746",
        "5122176325478316282521276333477247531688228435611625768584716235",
        "3475476637164258121445871154744365723854831184258562527258472361",
        "6412736823145786874672617233164261738534782134578745381415674823",
        "2624574238761245541225481881782682573611651824676643251147256183",
        "7748143225673184717233681175536362354771436478265516884374816235"

    ]
    let veryHard : [String] = [
        "917236947751648239323781484514927896189453961433865624826775391698314552468917415",
        "598698346152974836673379821355385472467532699544891759263442118981427665212733289",
        "717453224154279836588774665867941953943127982627346741496918312598631774776928416",
        "521978713583274196999427937684311752241365388134679425435125357812736449354822976",
        "296883877523961847272698731866378495254319185744587168938543786169724853735426924",
        "868147395284519376754961783822435617946823458599466821713892445627385449375644136",
        "972254791214359867841872279716989143569427832924655914851577435982746851793148527",
        "199591966561839274687954514497761825974128737713736983322473539853412396436227148",
        "987159349138952764468254186629124458394861827557796239783381631812543676144317593",
        "137557942567412839396745214399268154214389576149153287723596491658974423424866398"
    ]

    func validateBoards() {
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
