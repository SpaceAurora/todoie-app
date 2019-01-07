//
//  UIButtonTodoie.swift
//  todoie
//
//  Created by Mustafa Khalil on 12/15/18.
//  Copyright © 2018 Aurora. All rights reserved.
//

import UIKit

/**
 UIButtonTodoie implements the UIButton with a hotpink color and a radius
 */
class UIButtonTodoie: UIButton {
    
    // sets the default size of the buttons
    override var intrinsicContentSize: CGSize {
        return .init(width: 0, height: 50)
    }
    
    /**
     Setup Button set the title and the button layout that's required
     - Parameters:
        - placeholder: String that will represent the text in button
        - color: UIColor that will indicate the color of the button
     */
    func setupButton(placeholder: String, color: UIColor, textColor: UIColor) {
        setTitleColor(textColor, for: .normal)
        setTitle("Sign Up With \(placeholder)", for: .normal)
        setupView(color: color)
    }
    
    /**
     Sets up the boarder of the button and the color
     - Parameters:
        - color: UIColor that will indicate the color of the button
     */
    private func setupView(color: UIColor) {
        translatesAutoresizingMaskIntoConstraints = false
        layer.backgroundColor = color.cgColor
        layer.cornerRadius = 20
    }
    
}
