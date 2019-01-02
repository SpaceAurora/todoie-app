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
    
    override var intrinsicContentSize: CGSize {
        return .init(width: 0, height: 50)
    }
    
    /**
     Setup Button set the title and the button layout that's required
     - Parameters:
        - placeholder: String that will represent the text in button
     */
    func setupButton(placeholder: String, color: UIColor) {
        setTitleColor(.white, for: .normal)
        setTitle(placeholder, for: .normal)
        setupView(color: color)
    }
    
    /*
     Sets up the boarder of the button and the color
     */
    private func setupView(color: UIColor) {
        translatesAutoresizingMaskIntoConstraints = false
        layer.backgroundColor = color.cgColor
        layer.cornerRadius = 20
    }
    
}
