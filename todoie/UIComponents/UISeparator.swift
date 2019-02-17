//
//  UISeparator.swift
//  todoie
//
//  Created by Mustafa Khalil on 1/23/19.
//  Copyright © 2019 Aurora. All rights reserved.
//

import UIKit

class UISeparator: UIView {
    override var intrinsicContentSize: CGSize {
        return .init(width: 0, height: 0.9)
    }
    
    init() {
        super.init(frame: .zero)
        translatesAutoresizingMaskIntoConstraints = false
        backgroundColor = .white
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
