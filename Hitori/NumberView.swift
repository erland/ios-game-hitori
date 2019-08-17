//
//  NumberView.swift
//  Sudoku
//
//  Created by Erland Isaksson on 2019-06-14.
//  Copyright © 2019 Erland Isaksson. All rights reserved.
//

import SpriteKit

class NumberView : SKSpriteNode, NumberObserver {
    let cellSize: CGFloat
    let number : Number
    
    init(number: Number, cellSize: CGFloat) {
        self.cellSize = cellSize
        self.number = number
        super.init(texture: nil, color: Color.clear, size: CGSize(width: cellSize-2, height: cellSize-2))

        number.attachObserver(observer: self)
        anchorPoint = CGPoint(x: 0, y: 1)
        numberUpdated(number: number)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func numberUpdated(number: Number) {
        let positionX = CGFloat(number.x)*cellSize+cellSize/2.0+1
        let positionY = -CGFloat(number.y)*cellSize-cellSize/2.0-1
        self.position = CGPoint(x: positionX, y: positionY)
        self.alpha = 1
        if number.state == .Candidate {
            color = Color.lightYellow
        }else if number.state == .Selected {
            color = Color.darkGray
        }else {
            color = Color.clear
        }
        removeAllChildren()
        let label = SKLabelNode(fontNamed: "ArialRoundedMTBold")
        label.name = "number"
        label.text = "\(number.number)"
        label.fontSize = 50*cellSize/66.67
        label.horizontalAlignmentMode = .center
        label.verticalAlignmentMode = .center
        label.position = CGPoint(x: 0, y: 0)
        if number.state == .Selected {
            label.fontColor = Color.white
        }else {
            label.fontColor = Color.black
        }
        addChild(label)
    }
    
    
}

