//
//  Page.swift
//  todoie
//
//  Created by Mustafa Khalil on 1/20/19.
//  Copyright © 2019 Aurora. All rights reserved.
//

import UIKit

struct Page {
    let image: UIImage
    let title: [Word]
    let description: String
    let textColor: UIColor
    let lineColor: UIColor
    
    // returns a ViewModel of this object
    func toViewModel() -> PageViewModel {
        let attTitle = getTitle()
        let paragraph = NSMutableParagraphStyle()
        paragraph.alignment = .center
        let attDescription = NSMutableAttributedString(string: description, attributes: [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 14, weight: .regular), .paragraphStyle: paragraph])
        return PageViewModel(image: image, title: attTitle, description: attDescription, lineColor: lineColor)
    }
    
    // Sets the title of the Page highlighted according to the word
    fileprivate func getTitle() -> NSMutableAttributedString {
        let paragraph = NSMutableParagraphStyle()
        paragraph.alignment = .center
        let attText = NSMutableAttributedString()
        title.forEach { (word) in
            attText.append(word.getAttributedWord(color: textColor))
        }
        let range = NSMakeRange(0, attText.string.count)
        attText.addAttribute(.paragraphStyle, value: paragraph, range: range)
        return attText
    }
}
