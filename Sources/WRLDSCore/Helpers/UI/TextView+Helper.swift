//
//  UITextView+Helper.swift
//  WRLDS
//
//  Created by Ahmed Amr on 5/24/20.
//  Copyright © 2020 WRLDS. All rights reserved.
//

import UIKit

public extension UITextView {
    
    convenience init(text: String?, font: UIFont?, color: UIColor?, isEditable: Bool = true) {
        self.init(frame: .zero)
        self.text = text
        self.textColor = color
        self.font = font
        self.backgroundColor = .clear
        self.isEditable = isEditable
    }
    
    
    var spacing: CGFloat? {
        get {
            if let style = self.typingAttributes[NSAttributedString.Key.paragraphStyle] as? NSMutableParagraphStyle {
                return style.lineSpacing
            } else {return nil}
        }
        set (newVal) {
            guard let spacing = newVal else {return}
            let style = NSMutableParagraphStyle()
            style.lineSpacing = spacing
            self.typingAttributes = [NSAttributedString.Key.paragraphStyle: style,
                                     NSAttributedString.Key.font: self.font ?? UIFont.systemFont(ofSize: 14)
            ]
        }
    }
}


extension UITextField {
    convenience init(placeholder: String = "", font: UIFont? = nil, backgroundColor: UIColor = .clear, borderStyle: UITextField.BorderStyle = .none) {
        self.init(frame: .zero)
        self.placeholder = placeholder
        self.backgroundColor = backgroundColor
        self.borderStyle = borderStyle
        if let font = font {
            self.font = font
        }
    }
}
