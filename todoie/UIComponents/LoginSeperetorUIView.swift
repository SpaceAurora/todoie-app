//
//  LoginSeperetorUIView.swift
//  todoie
//
//  Created by Mustafa Khalil on 1/7/19.
//  Copyright © 2019 Aurora. All rights reserved.
//

import UIKit

class LoginSeparatorUIView: UIView {
    
    private let orLabel: UILabelTodoieLogin = {
        let lb = UILabelTodoieLogin(frame: .zero)
        lb.text = "OR"
        return lb
    }()
    
    fileprivate let right = UISeparator()
    fileprivate let left = UISeparator()
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        translatesAutoresizingMaskIntoConstraints = false
        setupView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    fileprivate func setupView() {
        addSubview(orLabel)
        addSubview(left)
        addSubview(right)
        
        NSLayoutConstraint.activate([
            orLabel.centerXAnchor.constraint(equalTo: centerXAnchor),
            orLabel.centerYAnchor.constraint(equalTo: centerYAnchor),
            
            left.trailingAnchor.constraint(equalTo: orLabel.leadingAnchor, constant: -8),
            left.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 8),
            left.centerYAnchor.constraint(equalTo: centerYAnchor),
            
            right.leadingAnchor.constraint(equalTo: orLabel.trailingAnchor, constant: 8),
            right.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -8),
            right.centerYAnchor.constraint(equalTo: centerYAnchor),
            
            heightAnchor.constraint(equalToConstant: 30),
            ])
    }
    
}
