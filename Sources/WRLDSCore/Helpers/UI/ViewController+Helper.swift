//
//  UIViewController+Extensions.swift
//  WRLDS
//
//  Created by Garrett Jester on 7/24/20.
//  Copyright © 2020 WRLDS. All rights reserved.
//

import UIKit

public extension UIViewController {
    
    
    /// Displays a navbar with standard formatting (no separator & standard background).
    func addDefaultNavBar(withSeparator separator: Bool) {
        navigationController?.navigationBar.barTintColor = .backgroundGray
        navigationController?.navigationBar.isTranslucent = false
        navigationController?.navigationBar.setBackgroundImage(UIImage(color: .backgroundGray), for: .default)
        navigationController?.navigationBar.shadowImage = UIImage()
        //if separator { showNavSeparator()}
    }
}

