//
//  ProfileImageButton.swift
//  todoie
//
//  Created by Mustafa Khalil on 1/15/19.
//  Copyright © 2019 Aurora. All rights reserved.
//

import UIKit

class ProfileImageButton: UIButton {
    
    private let size: CGFloat = 100
    
    override var intrinsicContentSize: CGSize {
        return .init(width: size, height: size)
    }
    
    //sets up the profile button on the headerview
    func setupButton() {
        translatesAutoresizingMaskIntoConstraints = false
        setTitle("+", for: .normal)
        backgroundColor = .white
        clipsToBounds = true
        layer.cornerRadius = size * 0.5
        imageView?.contentMode = .scaleAspectFit
    }
}
