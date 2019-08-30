//
//  Extensions.swift
//  BeSecur_Weather
//
//  Created by Sheerien Manzoor on 8/27/19.
//  Copyright © 2019 Muhammad Shahrukh. All rights reserved.
//

import UIKit

extension UILabel {
    convenience init(text: String, font: UIFont, numberOfLines: Int = 1, color: UIColor?) {
        self.init(frame: .zero)
        self.text = text
        self.font = font
        self.numberOfLines = numberOfLines
        if let color = color {
            self.textColor = color
        }
    }
}

extension UIImageView {
    convenience init(cornerRadius: CGFloat, image: String?) {
        if let image = image {
            self.init(image: UIImage(named: image)?.withRenderingMode(.alwaysOriginal))
        } else {
            self.init(image: nil)
        }
        self.layer.cornerRadius = cornerRadius
        self.clipsToBounds = true
        self.contentMode = .scaleAspectFill
    }
}


extension UIButton {
    convenience init(title: String) {
        self.init(type: .system)
        self.setTitle(title, for: .normal)
    }
}
