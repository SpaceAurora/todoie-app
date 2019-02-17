//
//  PriorityView.swift
//  todoie
//
//  Created by Mustafa Khalil on 2/11/19.
//  Copyright © 2019 Aurora. All rights reserved.
//

import UIKit

protocol PriorityViewDelegate: class {
    func getPriority(priority: Priority)
}

class PriorityView: UIView {
    
    private weak var delegate: PriorityViewDelegate?
    
    private lazy var lowButton: PriorityButton = {
        let b = PriorityView.ButtonFactory(priority: .low)
        b.addTarget(self, action: #selector(handlePrioritySelected(_ :)), for: .touchUpInside)
        return b
    }()
    private lazy var mediumButton: PriorityButton = {
        let b = PriorityView.ButtonFactory(priority: .medium)
        b.addTarget(self, action: #selector(handlePrioritySelected(_ :)), for: .touchUpInside)
        return b
    }()
    private lazy var highButton: PriorityButton = {
        let b = PriorityView.ButtonFactory(priority: .high)
        b.addTarget(self, action: #selector(handlePrioritySelected(_ :)), for: .touchUpInside)
        return b
    }()
    
    fileprivate let priorityLabel: UILabel = {
        let l = UILabel()
        l.text = "Priority"
        l.translatesAutoresizingMaskIntoConstraints = false
        l.font = UIFont.systemFont(ofSize: 14, weight: .regular)
        l.textColor = .white
        return l
    }()
    
    fileprivate let separator = UISeparator()
    
    init(delegate: PriorityViewDelegate?) {
        self.delegate = delegate
        super.init(frame: .zero)
        translatesAutoresizingMaskIntoConstraints = false
        
        addSubview(separator)
        addSubview(priorityLabel)
        
        let stack = UIStackView(arrangedSubviews: [lowButton, mediumButton, highButton])
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.axis = .horizontal
        stack.distribution = .equalCentering
        stack.spacing = 30
        addSubview(stack)
        
        NSLayoutConstraint.activate([
            priorityLabel.topAnchor.constraint(equalTo: topAnchor),
            priorityLabel.leadingAnchor.constraint(equalTo: leadingAnchor),
            priorityLabel.bottomAnchor.constraint(equalTo: bottomAnchor),
            priorityLabel.widthAnchor.constraint(equalTo: widthAnchor, multiplier: 0.28),
            
            stack.leadingAnchor.constraint(equalTo: priorityLabel.trailingAnchor),
            stack.bottomAnchor.constraint(equalTo: separator.bottomAnchor, constant: -4),
            stack.topAnchor.constraint(equalTo: topAnchor, constant: 4),
            stack.widthAnchor.constraint(equalTo: widthAnchor, multiplier: 0.6),
            
            separator.leadingAnchor.constraint(equalTo: leadingAnchor),
            separator.trailingAnchor.constraint(equalTo: trailingAnchor),
            separator.bottomAnchor.constraint(equalTo: bottomAnchor),
            ])
    }
    
    static func ButtonFactory(priority: Priority) -> PriorityButton {
        let btn = PriorityButton(type: .system)
        btn.setupButton(withPriority: priority)
        return btn
    }
    
    @objc func handlePrioritySelected(_ sender: UIButton) {
        [lowButton, mediumButton, highButton].forEach { (btn) in
            let selected = btn == sender
            btn.shouldShowCircularPath(isSelected: selected)
        }
        delegate?.getPriority(priority: Priority(rawValue: sender.tag) ?? .low)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
