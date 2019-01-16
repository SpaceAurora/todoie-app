//
//  LineView.swift
//  todoie
//
//  Created by Mustafa Khalil on 1/14/19.
//  Copyright © 2019 Aurora. All rights reserved.
//

import UIKit

class LineView: UIView {
    
    // sets up the line that we have in the cells
    func setupView(leadingAnchor leading: NSLayoutXAxisAnchor) {
        translatesAutoresizingMaskIntoConstraints = false
        backgroundColor = .lineColor
        widthAnchor.constraint(equalToConstant: 1.5).isActive = true
        leadingAnchor.constraint(equalTo: leading, constant: 40).isActive = true
    }
}

