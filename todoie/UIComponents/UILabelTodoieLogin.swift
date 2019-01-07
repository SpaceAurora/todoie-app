//
//  UILabelTodoieLogin.swift
//  todoie
//
//  Created by Mustafa Khalil on 1/7/19.
//  Copyright © 2019 Aurora. All rights reserved.
//

import UIKit

class UILabelTodoieLogin: UILabel {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        textAlignment = .center
        translatesAutoresizingMaskIntoConstraints = false
        font = UIFont.systemFont(ofSize: 18, weight: .light)
        textColor = .white
    }
    
    
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
