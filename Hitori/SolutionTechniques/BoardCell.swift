//
//  BoardCell.swift
//  Hitori
//
//  Created by Erland Isaksson on 2019-08-16.
//  Copyright © 2019 Erland Isaksson. All rights reserved.
//

import Foundation

class BoardCell {
    var number : Int
    var selected : Bool?
    
    init(number: Int, selected: Bool?) {
        self.number = number
        self.selected = selected
    }
}
