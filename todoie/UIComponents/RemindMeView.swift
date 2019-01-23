//
//  RemindMeView.swift
//  todoie
//
//  Created by Mustafa Khalil on 2/10/19.
//  Copyright © 2019 Aurora. All rights reserved.
//

import UIKit

class RemindMeView: UIView {
    
    weak var delegate: RemindMeViewDelegate?
    
    fileprivate let whenLabel: UILabel = {
        let l = UILabel()
        l.text = "Remind me on a day"
        l.translatesAutoresizingMaskIntoConstraints = false
        l.font = UIFont.systemFont(ofSize: 14, weight: .regular)
        l.textColor = .white
        return l
    }()
    
    fileprivate let control: UISwitch = {
        let l = UISwitch()
        l.addTarget(self, action: #selector(handleControlChanged), for: .valueChanged)
        l.translatesAutoresizingMaskIntoConstraints = false
        return l
    }()
    
    @objc func handleControlChanged() {
        delegate?.shouldShowRemindMeView(isOn: control.isOn)
    }
    
    fileprivate let separator = UISeparator()
    
    init(delegate: RemindMeViewDelegate) {
        self.delegate = delegate
        super.init(frame: .zero)
        translatesAutoresizingMaskIntoConstraints = false
        addSubview(whenLabel)
        addSubview(control)
        addSubview(separator)
        NSLayoutConstraint.activate([
            whenLabel.topAnchor.constraint(equalTo: topAnchor),
            whenLabel.leadingAnchor.constraint(equalTo: leadingAnchor),
            whenLabel.bottomAnchor.constraint(equalTo: bottomAnchor),
            whenLabel.trailingAnchor.constraint(equalTo: control.leadingAnchor),
            
            control.topAnchor.constraint(equalTo: topAnchor),
            control.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -8),
            control.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16),
            
            separator.leadingAnchor.constraint(equalTo: leadingAnchor),
            separator.trailingAnchor.constraint(equalTo: trailingAnchor),
            separator.bottomAnchor.constraint(equalTo: bottomAnchor),
            ])
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
