//
//  CalenderView.swift
//  todoie
//
//  Created by Mustafa Khalil on 2/10/19.
//  Copyright © 2019 Aurora. All rights reserved.
//

import UIKit

class CalenderView: UIView {
    
    fileprivate let dayLabel: UILabel = {
        let l = UILabel()
        l.translatesAutoresizingMaskIntoConstraints = false
        l.font = UIFont.systemFont(ofSize: 56, weight: .regular)
        l.text = "19"
        l.textColor = .white
        return l
    }()
    
    fileprivate let monthLabel: UILabel = {
        let l = UILabel()
        l.translatesAutoresizingMaskIntoConstraints = false
        
        l.font = UIFont.systemFont(ofSize: 12, weight: .regular)
        l.text = "JANUARY 2019"
        l.textColor = .white
        l.textAlignment = .center
        return l
    }()
    
    fileprivate let dateLabel: UILabel = {
        let l = UILabel()
        l.translatesAutoresizingMaskIntoConstraints = false
        l.font = UIFont.systemFont(ofSize: 24, weight: .regular)
        l.text = "Saturday"
        l.textColor = .white
        l.textAlignment = .center
        return l
    }()
    
    fileprivate let separator = UISeparator()
    
    init() {
        super.init(frame: .zero)
        translatesAutoresizingMaskIntoConstraints = false
        let stackView = UIStackView(arrangedSubviews: [dateLabel, monthLabel])
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.distribution = .fillEqually
        
        let mainStack = UIStackView(arrangedSubviews: [dayLabel, stackView])
        mainStack.translatesAutoresizingMaskIntoConstraints = false
        mainStack.spacing = 20
        addSubview(mainStack)
        addSubview(separator)
        
        NSLayoutConstraint.activate([
            mainStack.centerYAnchor.constraint(equalTo: centerYAnchor),
            mainStack.centerXAnchor.constraint(equalTo: centerXAnchor),
            separator.leadingAnchor.constraint(equalTo: leadingAnchor),
            separator.trailingAnchor.constraint(equalTo: trailingAnchor),
            separator.bottomAnchor.constraint(equalTo: bottomAnchor),
            ])
        setDate()
    }
    
    func setDate(date: Date = Date()) {
        monthLabel.text = date.getDate(withFormat: "MMMM YYYY")
        dayLabel.text = date.getDate(withFormat: "dd")
        dateLabel.text = date.getDate(withFormat: "EEEE")
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
