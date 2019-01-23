//
//  TodoieDateTimePicker.swift
//  todoie
//
//  Created by Mustafa Khalil on 2/10/19.
//  Copyright © 2019 Aurora. All rights reserved.
//

import UIKit

class TodoieDateTimePicker: UIDatePicker {
    
    init(dateMode: Mode) {
        super.init(frame: .zero)
        setValue(UIColor.white, forKey: "textColor")
        translatesAutoresizingMaskIntoConstraints = false
        datePickerMode = dateMode
        isHidden = true
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

