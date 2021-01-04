//
//  UIColor+Helper.swift
//  WRLDS
//
//  Created by Ahmed Amr on 5/24/20.
//  Copyright © 2020 WRLDS. All rights reserved.
//

import UIKit

/// Helper methods and initializers to extend UIColor functionality.
public extension UIColor {
    
    // MARK: -- INITIALIZERS --
    convenience init(redValue: CGFloat, greenValue: CGFloat, blueValue: CGFloat, alphaValue: CGFloat) {
        self.init(red: redValue/255, green: greenValue/255, blue: blueValue/255, alpha: alphaValue)
    }

    convenience init(hex: Int ) {
        let (red, green, blue) = (CGFloat((hex >> 16) & 0xFF), CGFloat((hex >> 8) & 0xFF), CGFloat(hex & 0xFF))
        self.init(redValue: red, greenValue: green, blueValue: blue, alphaValue: 1.0)
    }

    convenience init(hex: Int, alpha: CGFloat) {
        let (red, green, blue) = (CGFloat((hex >> 16) & 0xFF), CGFloat((hex >> 8) & 0xFF), CGFloat(hex & 0xFF))
        self.init(redValue: red, greenValue: green, blueValue: blue, alphaValue: alpha)
    }
    

    
    /// Creates a custom semantic color.
    /// - Parameters:
    ///   - lightMode: The color displayed when the interface is in .LightMode
    ///   - darkMode: The color displayed when the interface is in .darkMode
    /// - Returns: The correct color for the current interface mode.
    
    class func dynamicColor(lightMode: UIColor, darkMode: UIColor) -> UIColor {
        if #available(iOS 13, *) {
            return UIColor { (UITraitCollection: UITraitCollection) -> UIColor in
                if UITraitCollection.userInterfaceStyle == .dark {
                    /// Return the color for Dark Mode
                    return darkMode
                } else {
                    /// Return the color for Light Mode
                    return lightMode
                }
            }
        } else {
            /// Return a fallback color for iOS 12 and lower.
            return lightMode
        }
    }
    
    
    
}
