//
//  AddTaskTextField.swift
//  todoie
//
//  Created by Mustafa Khalil on 2/10/19.
//  Copyright © 2019 Aurora. All rights reserved.
//

import UIKit

class AddTaskTextField: TodoieTextField {
    
    fileprivate let label: UILabel = {
        let l = UILabel()
        l.translatesAutoresizingMaskIntoConstraints = false
        l.font = UIFont.systemFont(ofSize: 14, weight: .regular)
        l.textColor = .white
        return l
    }()
    
    init(title: String) {
        super.init(frame: .zero)
        containerView = UIView(frame: CGRect(x: 0, y: 0, width: 100, height: 40))
        
        let constraints = [ label.leadingAnchor.constraint(equalTo: containerView.leadingAnchor),
                            label.topAnchor.constraint(equalTo: containerView.topAnchor),
                            label.bottomAnchor.constraint(equalTo: containerView.bottomAnchor),
                            label.trailingAnchor.constraint(equalTo: containerView.trailingAnchor)
        ]
        
        translatesAutoresizingMaskIntoConstraints = false
        heightAnchor.constraint(equalToConstant: 50).isActive = true
        
        setupText(placeholder: title)
        setupBoarder()
        setupContainer(view: label, viewConstraints: constraints)
        label.text = title
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
