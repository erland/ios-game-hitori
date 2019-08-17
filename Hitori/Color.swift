//
//  Color.swift
//  Takuzu
//
//  Created by Erland Isaksson on 2019-08-14.
//  Copyright © 2019 Erland Isaksson. All rights reserved.
//

import Foundation
import SpriteKit

class Color {
    #if os(iOS)
    static let orange = UIColor.orange
    static let brown = UIColor.brown
    static let clear = UIColor.clear
    static let black = UIColor.black
    static let darkGray = UIColor.darkGray
    static let white = UIColor.white
    static let lightYellow = UIColor(red:1.0, green:1.0, blue:0.8, alpha: 1.0)
    #elseif os(OSX)
    static let orange = NSColor.orange
    static let brown = NSColor.brown
    static let clear = NSColor.clear
    static let black = NSColor.black
    static let darkGray = NSColor.darkGray
    static let white = NSColor.white
    static let lightYellow = NSColor(red:1.0, green:1.0, blue:0.8, alpha: 1.0)
    #endif
}
