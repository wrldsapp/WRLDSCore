//
//  Font+Helpers.swift
//  WRLDS
//
//  Created by Garrett Jester on 9/1/20.
//  Copyright © 2020 WRLDS. All rights reserved.
//

import UIKit

extension UIFont {
    
    @nonobjc class var textField: UIFont {
        return UIFont.systemFont(ofSize: 15, weight: .regular)
    }
    
    @nonobjc class var error: UIFont {
        return UIFont.systemFont(ofSize: 13, weight: .medium)
    }
    
    @nonobjc class var headerTitle: UIFont {
        return UIFont.systemFont(ofSize: 23, weight: .bold)
    }
    
    @nonobjc class var headerTitleCondensed: UIFont {
        return UIFont.systemFont(ofSize: 20, weight: .bold)
    }
    
    @nonobjc class var headerSubtitle: UIFont {
        return UIFont.systemFont(ofSize: 14, weight: .regular)
    }
    
    @nonobjc class var headerSubtitleCondensed: UIFont {
        return UIFont.systemFont(ofSize: 13, weight: .regular)
    }
}
