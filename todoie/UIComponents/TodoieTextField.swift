//
//  TodoieTextField.swift
//  todoie
//
//  Created by Mustafa Khalil on 1/23/19.
//  Copyright © 2019 Aurora. All rights reserved.
//

import UIKit

class TodoieTextField: UITextField {
    
    var containerView: UIView!
    /**
     Creates the bottom only boarder for the UITextField that will work with AutoLayout
     */
    func setupBoarder() {
        let lineView = UIView()
        lineView.backgroundColor = .white
        lineView.translatesAutoresizingMaskIntoConstraints = false
        addSubview(lineView)
        
        // sets the constraints of the boarder to the constraints we require
        NSLayoutConstraint.activate([
            lineView.trailingAnchor.constraint(equalTo: trailingAnchor),
            lineView.leadingAnchor.constraint(equalTo: leadingAnchor),
            lineView.bottomAnchor.constraint(equalTo: bottomAnchor),
            lineView.heightAnchor.constraint(equalToConstant: 0.9)
            ])
    }
    
    // Starts setting up the text needed for the UITextField
    func setupText(placeholder: String) {
        // Creating an Attributed Text to fit into the place holder
        attributedPlaceholder = NSAttributedString(string: "Enter \(placeholder)", attributes: [NSAttributedString.Key.foregroundColor: UIColor.white, NSAttributedString.Key.font: UIFont.systemFont(ofSize: 16)])
        
        // sets the font and the color to white
        font = UIFont.systemFont(ofSize: 16)
        textColor = .white
    }
    
    /**
     Creates the image within the UITextField
     */
    func setupContainer(view: UIView, viewConstraints: [NSLayoutConstraint]) {
        
        // creates a container for the image
        // which will add a padding from the text inputView
        containerView.addSubview(view)
        
        // constrainting the image within the container
        NSLayoutConstraint.activate(viewConstraints)
        
        // sets the container to the position we require it to be in
        leftViewMode = .always
        leftView = containerView
    }
}


