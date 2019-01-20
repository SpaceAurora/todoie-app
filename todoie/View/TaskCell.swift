//
//  TaskCell.swift
//  todoie
//
//  Created by Mustafa Khalil on 1/18/19.
//  Copyright © 2019 Aurora. All rights reserved.
//

import UIKit

class TaskCell: GenericCell<TaskViewModel> {
    
    override var data: TaskViewModel! {
        didSet {
            titleLabel.text = data.title
            descriptionLabel.text = data.description
            timingLabel.text = data.time
            circleColor.backgroundColor = data.priority
        }
    }
    
    private let lineView = LineView()
    private let circleColor = CircleView()
    
    private let titleLabel: UILabel = {
        let l = UILabel()
        l.textColor = .mainScreenTitles
        l.font = UIFont.systemFont(ofSize: 16, weight: .bold)
        l.translatesAutoresizingMaskIntoConstraints = false
        return l
    }()
    
    private let descriptionLabel = DescriptionTextView()
    private let timingLabel = TimingLabel()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}


extension TaskCell {
    
    fileprivate func setupUI() {
        translatesAutoresizingMaskIntoConstraints = false
        backgroundColor = .white
        
        addSubview(timingLabel)
        addSubview(titleLabel)
        addSubview(descriptionLabel)
        addSubview(lineView)
        addSubview(circleColor)
        
        lineView.setupView(leadingAnchor: leadingAnchor)
        
        NSLayoutConstraint.activate([
            lineView.topAnchor.constraint(equalTo: topAnchor),
            lineView.bottomAnchor.constraint(equalTo: bottomAnchor),
            
            circleColor.centerXAnchor.constraint(equalTo: lineView.centerXAnchor, constant: 0),
            circleColor.topAnchor.constraint(equalTo: topAnchor, constant: 30),
            
            titleLabel.leadingAnchor.constraint(equalTo: circleColor.trailingAnchor, constant: 8),
            titleLabel.topAnchor.constraint(equalTo: topAnchor, constant: 25),
            titleLabel.trailingAnchor.constraint(equalTo: timingLabel.leadingAnchor, constant: -8),
            titleLabel.heightAnchor.constraint(equalToConstant: 20),
            
            timingLabel.topAnchor.constraint(equalTo: topAnchor, constant: 25),
            timingLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -4),
            
            descriptionLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 4),
            descriptionLabel.leadingAnchor.constraint(equalTo: lineView.leadingAnchor, constant: 16),
            descriptionLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -8),
            descriptionLabel.bottomAnchor.constraint(equalTo: bottomAnchor),
            
            ])
    }
}

fileprivate class CircleView: UIView {
    
    let size: CGFloat = 10
    
    init() {
        super.init(frame: .zero)
        layer.cornerRadius = size * 0.5
        translatesAutoresizingMaskIntoConstraints = false
        clipsToBounds = true
        backgroundColor = .blue
        widthAnchor.constraint(equalToConstant: size).isActive = true
        heightAnchor.constraint(equalToConstant: size).isActive = true
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

fileprivate class DescriptionTextView: UITextView {

    override init(frame: CGRect, textContainer: NSTextContainer?) {
        super.init(frame: frame, textContainer: textContainer)
        isEditable = false
        isSelectable = false
        isScrollEnabled = false
        textColor = .lightGray
        font = UIFont.systemFont(ofSize: 12, weight: .regular)
        translatesAutoresizingMaskIntoConstraints = false
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

fileprivate class TimingLabel: UILabel {
    
    init() {
        super.init(frame: .zero)
        font = UIFont.systemFont(ofSize: 12, weight: .regular)
        textColor = .lightGray
        numberOfLines = 0
        translatesAutoresizingMaskIntoConstraints = false
        widthAnchor.constraint(equalToConstant: 60).isActive = true
        heightAnchor.constraint(equalToConstant: 18).isActive = true
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
