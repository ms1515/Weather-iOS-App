//
//  String.swift
//  BeSecur_Weather
//
//  Created by Sheerien Manzoor on 8/27/19.
//  Copyright © 2019 Muhammad Shahrukh. All rights reserved.
//

import UIKit

extension NSMutableAttributedString {
    
    class func setupWithText(_ text: String, description: String, textFont: UIFont, descriptionFont: UIFont, textColor: UIColor, descriptionColor: UIColor) -> NSMutableAttributedString?{
        
        let textAttribute = [NSAttributedString.Key.font: textFont, NSAttributedString.Key.foregroundColor: textColor] 
        let descriptionAttribute = [NSAttributedString.Key.font: descriptionFont, NSAttributedString.Key.foregroundColor: descriptionColor]
        
        let attributedText = NSMutableAttributedString(string: text, attributes: textAttribute)
        let descriptionAttributedString = NSMutableAttributedString(string: description, attributes:  descriptionAttribute)
        attributedText.append(descriptionAttributedString)
        return attributedText
    }
}
