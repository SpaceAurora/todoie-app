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
    
    // Implements a opacity background
    static var opacityBackground: UIColor {
        get {
            let color = UIColor(white: 1.0, alpha: 0.5)
            
            return color
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
