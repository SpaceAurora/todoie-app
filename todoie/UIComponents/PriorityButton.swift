//
//  PriorityButton.swift
//  todoie
//
//  Created by Mustafa Khalil on 2/11/19.
//  Copyright © 2019 Aurora. All rights reserved.
//

import UIKit

class PriorityButton: UIButton {
    private let circularLayer = CAShapeLayer()
    
    func setupButton(withPriority priority: Priority) {
        backgroundColor = priority.getColor()
        translatesAutoresizingMaskIntoConstraints = false
        tag = priority.rawValue
        heightAnchor.constraint(equalToConstant: 30).isActive = true
        widthAnchor.constraint(equalToConstant: 30).isActive = true
        layer.cornerRadius = 30 * 0.5
        
        let circlePath = UIBezierPath(arcCenter: CGPoint(x: 15, y: 15), radius: CGFloat(15), startAngle: CGFloat(0), endAngle:CGFloat(Double.pi * 2), clockwise: true)
        circularLayer.path = circlePath.cgPath
        
        //change the fill color
        circularLayer.fillColor = UIColor.clear.cgColor
        //you can change the stroke color
        circularLayer.strokeColor = UIColor.white.cgColor
        //you can change the line width
        circularLayer.lineWidth = 3.0
    }
    
    func shouldShowCircularPath(isSelected: Bool) {
        if isSelected {
            layer.addSublayer(circularLayer)
        } else {
            circularLayer.removeFromSuperlayer()
        }
    }
}
