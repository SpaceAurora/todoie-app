//
//  UITextFieldTodoie.swift
//  todoie
//
//  Created by Mustafa Khalil on 12/13/18.
//  Copyright © 2018 Aurora. All rights reserved.
//

import UIKit

/**
 UITextFieldTodoie implements the text field with the icon on the left side of the input field
 */
class UITextFieldTodoie: UITextField {
    
    // UIComponents
    private let imageView: UIImageView = {
        let iv = UIImageView()
        iv.clipsToBounds = true
        iv.contentMode = .scaleAspectFit
        iv.translatesAutoresizingMaskIntoConstraints = false
        return iv
    }()
    
    /**
     UITextFieldTodoie implements the text field with the icon on the left side of the input field
     - Parameters:
        - withImage: UIImage that will be placed in the icon
        - placeholder: String that will represent the text in AttributtedPlaceholder
    */
    init(withImage image: UIImage, placeholder: String) {
        imageView.image = image
        super.init(frame: .zero)
        
        // Allows us to use AutoLayout
        translatesAutoresizingMaskIntoConstraints = false
        
        setupText(placeholder: placeholder)
        setupBoarder()
        setupImage()
    }

    // Starts setting up the text needed for the UITextField
    fileprivate func setupText(placeholder: String) {
        // Creating an Attributed Text to fit into the place holder
        attributedPlaceholder = NSAttributedString(string: placeholder, attributes: [NSAttributedString.Key.foregroundColor: UIColor.white, NSAttributedString.Key.font: UIFont.systemFont(ofSize: 16)])
        
        // sets the font and the color to white
        font = UIFont.systemFont(ofSize: 16)
        textColor = .white
    }
    
    /**
     Creates the bottom only boarder for the UITextField that will work with AutoLayout
     */
    fileprivate func setupBoarder() {
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
    
    /**
     Creates the image within the UITextField
     */
    fileprivate func setupImage() {
        
        // creates a container for the image
        // which will add a padding from the text inputView
        let container = UIView(frame: CGRect(x: 0, y: 0, width: 40, height: 40))
        container.addSubview(imageView)
        
        // constrainting the image within the container
        NSLayoutConstraint.activate([
            imageView.leadingAnchor.constraint(equalTo: container.leadingAnchor),
            imageView.topAnchor.constraint(equalTo: container.topAnchor),
            imageView.bottomAnchor.constraint(equalTo: container.bottomAnchor, constant: -10),
            imageView.widthAnchor.constraint(equalTo: imageView.heightAnchor, constant: -4),
            ])
        
        // sets the container to the position we require it to be in
        leftViewMode = .always
        leftView = container
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

