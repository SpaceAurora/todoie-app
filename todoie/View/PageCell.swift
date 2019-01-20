//
//  PageCell.swift
//  todoie
//
//  Created by Mustafa Khalil on 1/21/19.
//  Copyright © 2019 Aurora. All rights reserved.
//

import UIKit

class PageCell: UICollectionViewCell {
    
    var page: PageViewModel! {
        didSet {
            imageView.image = page.image
            titleTextView.attributedText = page.title
            descriptionTextView.attributedText = page.description
            lineSeparator.backgroundColor = page.lineColor
        }
    }
    
    private let imageView: UIImageView = {
        let iv = UIImageView()
        iv.translatesAutoresizingMaskIntoConstraints = false
        iv.clipsToBounds = true
        iv.contentMode = .scaleAspectFill
        return iv
    }()
    
    private let titleTextView: UITextView = {
        let t = UITextView()
        t.translatesAutoresizingMaskIntoConstraints = false
        t.isEditable = false
        t.isSelectable = false
        t.isScrollEnabled = false
        return t
    }()
    
    private let lineSeparator: UIView = {
        let v = UIView()
        v.translatesAutoresizingMaskIntoConstraints = false
        return v
    }()
    
    private let descriptionTextView: UITextView = {
        let t = UITextView()
        t.translatesAutoresizingMaskIntoConstraints = false
        t.isEditable = false
        t.isSelectable = false
        t.isScrollEnabled = false
        return t
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        addSubview(imageView)
        addSubview(titleTextView)
        addSubview(descriptionTextView)
        addSubview(lineSeparator)
        NSLayoutConstraint.activate([
            imageView.leadingAnchor.constraint(equalTo: leadingAnchor),
            imageView.trailingAnchor.constraint(equalTo: trailingAnchor),
            imageView.topAnchor.constraint(equalTo: topAnchor),
            imageView.heightAnchor.constraint(equalTo: heightAnchor, multiplier: 0.5),
            
            titleTextView.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: 30),
            titleTextView.leadingAnchor.constraint(equalTo: leadingAnchor),
            titleTextView.trailingAnchor.constraint(equalTo: trailingAnchor),
            titleTextView.bottomAnchor.constraint(equalTo: lineSeparator.topAnchor),
            
            lineSeparator.topAnchor.constraint(equalTo: titleTextView.bottomAnchor),
            lineSeparator.centerXAnchor.constraint(equalTo: centerXAnchor),
            lineSeparator.heightAnchor.constraint(equalToConstant: 1.5),
            lineSeparator.widthAnchor.constraint(equalTo: widthAnchor, multiplier: 0.6),
            lineSeparator.bottomAnchor.constraint(equalTo: descriptionTextView.topAnchor),
            
            descriptionTextView.heightAnchor.constraint(equalTo: heightAnchor, multiplier: 0.22),
            descriptionTextView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 30),
            descriptionTextView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -30),
            descriptionTextView.bottomAnchor.constraint(equalTo: bottomAnchor),
            ])
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
