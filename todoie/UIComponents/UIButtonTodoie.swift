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
    
    /**
     Setup Button set the title and the button layout that's required
     - Parameters:
        - placeholder: String that will represent the text in button
     */
    func setupButton(placeholder: String) {
        setTitleColor(.white, for: .normal)
        setTitle(placeholder, for: .normal)
        setupButton()
        translatesAutoresizingMaskIntoConstraints = false
    }
    
    /*
     Sets up the boarder of the button and the color
     */
    private func setupButton() {
        layer.backgroundColor = UIColor.hotPink.cgColor
        layer.cornerRadius = 20
    }
    
}
