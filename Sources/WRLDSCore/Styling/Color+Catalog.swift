//
//  Color+Catalog.swift
//  WRLDS
//
//  Created by Garrett Jester on 11/5/20.
//  Copyright © 2020 WRLDS. All rights reserved.
//

import Foundation
import UIKit

extension UIColor {
    
    // MARK: -- WRLDS iOS COLOR CATALOG --
    // Full color catalog can be found on Zeplin: https://app.zeplin.io/project/5e41b7f485b42d946f765f64/styleguide
    
    @nonobjc class var wrldsBlue: UIColor {
        return UIColor(red:0.20, green:0.62, blue:1.00, alpha:1.0)
    }
    
    @nonobjc class var wrldsPink: UIColor {
        return UIColor(red:1.00, green:0.29, blue:0.94, alpha:1.0)
    }
    

    // BACKGROUND COLORS
    
    //UIColor(red:0.97, green:0.97, blue:0.97, alpha:1.0)
    @nonobjc class var backgroundGray: UIColor {
        return dynamicColor(lightMode: UIColor(red: 0.99, green: 0.99, blue: 0.99, alpha: 1.00),
                            darkMode: UIColor(red: 0.00, green: 0.00, blue: 0.00, alpha: 1.00))
    }
    
    @nonobjc class var containerBackground: UIColor {
        return dynamicColor(lightMode: .white, darkMode: UIColor(red: 0.15, green: 0.15, blue: 0.15, alpha: 1.00))
    }

    

    // TEXT COLORS
    @nonobjc class var primaryText: UIColor {
        dynamicColor(lightMode: .black, darkMode: UIColor(red: 0.98, green: 0.98, blue: 0.98, alpha: 1.00))
    }
   
    @nonobjc class var secondaryText: UIColor {
        return UIColor(redValue: 134, greenValue: 134, blueValue: 134, alphaValue: 1)
    }
    
    @nonobjc class var wrldsGrayText: UIColor {
        return UIColor(red:0.71, green:0.71, blue:0.71, alpha:1.0)
    }
    
    
    @nonobjc class var searchText: UIColor {
        return UIColor(red:0.50, green:0.50, blue:0.50, alpha:1.00)
    }
    
    @nonobjc class var darkText: UIColor {
        return UIColor(red:0.21, green:0.21, blue:0.21, alpha:1.0)
    }
    
    @nonobjc class var error: UIColor {
        return UIColor(red: 0.85, green: 0.00, blue: 0.00, alpha: 1.00)
    }
    
    @nonobjc class var grayBorder: UIColor {
        return UIColor(white: 212.0 / 255.0, alpha: 0.76)
    }
    
    @nonobjc class var containerBorder: UIColor {
        return dynamicColor(lightMode: UIColor(red: 0.92, green: 0.92, blue: 0.92, alpha: 1.00), darkMode: .clear)
    }
    
    @nonobjc class var containerHighlight: UIColor {
        return dynamicColor(lightMode: .searchField, darkMode: UIColor(red: 0.28, green: 0.28, blue: 0.28, alpha: 1.00))
    }
    
    @nonobjc class var disabledButton: UIColor {
        return dynamicColor(lightMode: UIColor(red:0.94, green:0.94, blue:0.94, alpha:1.0), darkMode: UIColor(red: 0.17, green: 0.17, blue: 0.17, alpha: 1.00))
    }
    
    @nonobjc class var disabledButtonText: UIColor {
        return dynamicColor(lightMode: UIColor(red:0.71, green:0.71, blue:0.71, alpha:1.0), darkMode: UIColor(red: 0.56, green: 0.56, blue: 0.56, alpha: 1.00))
    }
    
    @nonobjc class var mediumGray: UIColor {
        return UIColor(red:0.85, green:0.85, blue:0.85, alpha:1.0)
    }
    
    @nonobjc class var searchGray: UIColor {
        dynamicColor(lightMode: UIColor(red:0.83, green:0.83, blue:0.83, alpha:1.0),
                     darkMode: UIColor(red: 0.27, green: 0.27, blue: 0.27, alpha: 1.00)) 
    }
    
    @nonobjc class var separator: UIColor {
        return dynamicColor(lightMode: UIColor(red: 0.87, green: 0.87, blue: 0.87, alpha: 1.00),
                            darkMode: UIColor(red: 0.23, green: 0.23, blue: 0.23, alpha: 1.00))
    }
    
    @nonobjc class var searchField: UIColor {
        return dynamicColor(lightMode: UIColor(red: 0.94, green: 0.94, blue: 0.94, alpha: 1.00),
                            darkMode: UIColor(red: 0.16, green: 0.16, blue: 0.16, alpha: 1.00))
    }
    
    @nonobjc class var searchFieldHighlight: UIColor {
        return dynamicColor(lightMode: UIColor(red:0.85, green:0.85, blue:0.85, alpha:1.00),
                            darkMode: UIColor(red: 0.28, green: 0.28, blue: 0.28, alpha: 1.00))
    }
    
    @nonobjc class var darkGray: UIColor {
        return UIColor(red:0.45, green:0.42, blue:0.42, alpha:1.0)
    }
    
    @nonobjc class var lightGray: UIColor {
        return dynamicColor(lightMode: UIColor(red:0.94, green:0.94, blue:0.94, alpha:1.0) ,
                            darkMode: UIColor.clear)
    }
    
   @nonobjc class var trackControllerBackground: UIColor {
        return dynamicColor(lightMode: UIColor(red: 0.99, green: 0.99, blue: 0.99, alpha: 1.00),
                            darkMode: UIColor(red: 0.11, green: 0.11, blue: 0.11, alpha: 1.00))
    }
    
    @nonobjc class var purpleGradient: UIColor {
        return UIColor(red: 0.52, green: 0.06, blue: 1.00, alpha: 1.00)
    }
    
    @nonobjc class var pinkGradient: UIColor {
        return UIColor(red: 1.00, green: 0.13, blue: 0.82, alpha: 1.00)
    }
    
    
    @nonobjc class var selectedCellBackground: UIColor {
        dynamicColor(lightMode: UIColor(red: 0.94, green: 0.94, blue: 0.94, alpha: 1.00),
                     darkMode: UIColor(red: 0.19, green: 0.19, blue: 0.19, alpha: 1.00))
    }
    
    
    
    // MARK: -- MUSIC COLORS --
    
    
    
    @nonobjc class var rock: UIColor {
         UIColor(red: 1.00, green: 0.64, blue: 0.22, alpha: 1.00)
    }
    
    @nonobjc class var edm: UIColor {
        UIColor(red: 0.31, green: 0.49, blue: 0.98, alpha: 1.00)
    }

    @nonobjc class var pop: UIColor {
         UIColor(red: 0.35, green: 0.89, blue: 0.87, alpha: 1.00)
    }
    
    @nonobjc class var rapAndHipHop: UIColor {
        UIColor(red: 0.99, green: 0.21, blue: 0.42, alpha: 1.00)
    }
    
    @nonobjc class var indie: UIColor {
        UIColor(red: 0.70, green: 0.12, blue: 0.78, alpha: 1.00)
    }
}
