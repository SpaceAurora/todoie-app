//
//  LoginSeperetorUIView.swift
//  todoie
//
//  Created by Mustafa Khalil on 1/7/19.
//  Copyright © 2019 Aurora. All rights reserved.
//

import UIKit

class LoginSeparatorUIView: UIView {
    
    override var intrinsicContentSize: CGSize {
        return .init(width: 0, height: 0.5)
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        translatesAutoresizingMaskIntoConstraints = false
        backgroundColor = .white
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
