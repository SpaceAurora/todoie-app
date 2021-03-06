//
//  UIColor.swift
//  todoie
//
//  Created by Mustafa Khalil on 12/15/18.
//  Copyright © 2018 Aurora. All rights reserved.
//

import UIKit

extension UIColor {
    
    // Implementing the colors in Todoie UI
    static var hotPink: UIColor {
        get {
            return .RGB(red: 242, green: 65, blue: 109)
        }
    }
    
    // Implements the Facebook blue color
    static var facebookBlue: UIColor {
        get {
            return .RGB(red: 74, green: 144, blue: 226)
        }
    }
    
    static var backgroundColor: UIColor {
        get {
            return .white
        }
    }
    
    static var lineColor: UIColor {
        get {
            return .RGB(red: 216, green: 216, blue: 216, alpha: 100)
        }
    }
    
    // Implements a opacity background
    static var opacityBackground: UIColor {
        get {
            return UIColor(white: 1.0, alpha: 0.5)
        }
    }
    
    static var mainScreenTitles: UIColor {
        get {
            return .RGB(red: 74, green: 74, blue: 74)
        }
    }
    
    static var blueTodoieColor: UIColor {
        get {
            return .RGB(red: 74, green: 144, blue: 226)
        }
    }
    
    static var medPriority: UIColor {
        get {
            return .RGB(red: 248, green: 231, blue: 28)
        }
    }
    
    static var highPriority: UIColor {
        get {
            return .RGB(red: 208, green: 2, blue: 27)
        }
    }
    
    static var todoieDustyBlue: UIColor {
        get {
            return .RGB(red: 109, green: 151, blue: 167)
        }
    }
    
    static var todoiePurple: UIColor {
        get {
            return .RGB(red: 163, green: 161, blue: 255)
        }
    }
    
    static var todoieLightGreen: UIColor {
        get {
            return .RGB(red: 165, green: 231, blue: 192)
        }
    }
    
    
    static var todoiePink: UIColor {
        get {
            return .RGB(red: 201, green: 148, blue: 219)
        }
    }
    
    static var todoieLightSkyBlue: UIColor {
        get {
            return .RGB(red: 114, green: 169, blue: 234)
        }
    }
    
    /**
     RGB Helper method
     - Parameters:
        - red: The CGFloat value of red in color
        - green: The CGFloat value of green in color
        - blue: The CGFloat value of blue in color
        - alpha: alpha representation of the color
     - returns: UIcolor
     */
    static func RGB(red: CGFloat, green: CGFloat, blue: CGFloat, alpha: CGFloat = 1) -> UIColor {
        return UIColor(red: red/255, green: green/255, blue: blue/255, alpha: alpha)
    }
}
