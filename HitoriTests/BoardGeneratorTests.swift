//
//  BoardGeneratorTests.swift
//  HitoriTests
//
//  Created by Erland Isaksson on 2019-08-16.
//  Copyright © 2019 Erland Isaksson. All rights reserved.
//

import XCTest
@testable import Hitori

class BoardGeneratorTests: XCTestCase {

    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testGenerate_size_5() {
        for _ in 0..<10 {
            if let board = BoardGenerator(size: 5).generateFilledBoard() {
                print("Size: 5: \(board)")
            }
        }
    }

    func testGenerate_size_6() {
        for _ in 0..<10 {
            if let board = BoardGenerator(size: 6).generateFilledBoard() {
                print("Size: 6: \(board)")
            }
        }
    }

    func testGenerate_size_7() {
        for _ in 0..<10 {
            if let board = BoardGenerator(size: 7).generateFilledBoard() {
                print("Size: 7: \(board)")
            }
        }
    }
    func testGenerate_size_8() {
        for _ in 0..<10 {
            if let board = BoardGenerator(size: 8).generateFilledBoard() {
                print("Size: 8: \(board)")
            }
        }
    }
    func testGenerate_size_9() {
        for _ in 0..<10 {
            if let board = BoardGenerator(size: 9).generateFilledBoard() {
                print("Size: 9: \(board)")
            }
        }
    }
}
