//
//  LoginTodoieTextField.swift
//  todoie
//
//  Created by Mustafa Khalil on 12/13/18.
//  Copyright © 2018 Aurora. All rights reserved.
//

import UIKit

/**
 LoginTodoieTextField implements the text field with the icon on the left side of the input field
 */
class LoginTodoieTextField: TodoieTextField {
    
    // UIComponents
    private let imageView: UIImageView = {
        let iv = UIImageView()
        iv.clipsToBounds = true
        iv.contentMode = .scaleAspectFit
        iv.translatesAutoresizingMaskIntoConstraints = false
        return iv
    }()
    
    // sets the default size of the textfield
    override var intrinsicContentSize: CGSize {
        return .init(width: 0, height: 50)
    }
    
    /**
     UITextFieldTodoie implements the text field with the icon on the left side of the input field
     - Parameters:
        - withImage: UIImage that will be placed in the icon
        - placeholder: String that will represent the text in AttributtedPlaceholder
    */
    init(withImage image: UIImage, placeholder: String) {
        imageView.image = image
        super.init(frame: .zero)
        containerView = UIView(frame: CGRect(x: 0, y: 0, width: 40, height: 40))
        let imageViewConstraints = [ imageView.leadingAnchor.constraint(equalTo: containerView.leadingAnchor),
            imageView.topAnchor.constraint(equalTo: containerView.topAnchor),
            imageView.bottomAnchor.constraint(equalTo: containerView.bottomAnchor, constant: -10),
            imageView.widthAnchor.constraint(equalTo: imageView.heightAnchor, constant: -4),
            ]
        // Allows us to use AutoLayout
        translatesAutoresizingMaskIntoConstraints = false
        
        setupText(placeholder: placeholder)
        setupBoarder()
        setupContainer(view: imageView, viewConstraints: imageViewConstraints)
    }
    
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
