//
//  UILabel+Helper.swift
//  WRLDS
//
//  Created by Ahmed Amr on 5/24/20.
//  Copyright © 2020 WRLDS. All rights reserved.
//

import UIKit

/// Extends the UILabel class with custom methods and initializers.

extension UILabel {
    
    convenience init(text: String?, font: UIFont?, color: UIColor?, textAlignment: NSTextAlignment? = nil, numberOfLines: Int? = 1 ) {
        self.init(frame: .zero)
        self.text = text
        self.font = font
        self.textColor = color
        self.textAlignment = textAlignment ?? .left
        self.numberOfLines = numberOfLines ?? 1
    }
}


