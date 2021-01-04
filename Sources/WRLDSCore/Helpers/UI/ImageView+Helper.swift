//
//  UIImage+Helper.swift
//  WRLDS
//
//  Created by Ahmed Amr on 5/24/20.
//  Copyright © 2020 WRLDS. All rights reserved.
//

import UIKit

public extension UIImageView {
    convenience init(image: UIImage? = nil, contentMode: UIView.ContentMode? = .scaleAspectFill, tintColour: UIColor? = nil, cornerRadius: CGFloat? = 0, userInteraction: Bool? = false) {
        self.init(frame: .zero)
        self.image = image
        self.contentMode = contentMode ?? .scaleAspectFill
        self.isUserInteractionEnabled  = userInteraction ?? false
        if let cornerRadius = cornerRadius {
            self.clipsToBounds = true
            self.layer.cornerRadius = cornerRadius
        }
        if let tintColour = tintColour {
            self.image = self.image?.withRenderingMode(.alwaysTemplate)
            self.tintColor = tintColour
        }
    }
}

