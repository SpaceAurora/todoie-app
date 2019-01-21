//
//  Word.swift
//  todoie
//
//  Created by Mustafa Khalil on 1/21/19.
//  Copyright © 2019 Aurora. All rights reserved.
//

import UIKit

struct Word {
    let word: String
    let isHighlighted: Bool
    
    // Returns the word Attributed
    func getAttributedWord(color: UIColor) -> NSAttributedString {
        let fontsize: CGFloat = 650 > UIScreen.main.bounds.height ? 25 : 33
        let currentColor = isHighlighted ? color : .black
        return NSAttributedString(string: word, attributes: [NSAttributedString.Key.font: UIFont.systemFont(ofSize: fontsize, weight: .heavy), NSAttributedString.Key.foregroundColor: currentColor])
    }
}
