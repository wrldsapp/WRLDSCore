//
//  DeviceManager.swift
//  WRLDS
//
//  Created by Garrett Jester on 1/1/21.
//  Copyright © 2021 WRLDS. All rights reserved.
//

import Foundation
import UIKit

/// A class for managing the hardware and settings of the current device.
public final class DeviceManager {
    
    static let shared = DeviceManager()
    
    /// Determines if the current device model has a physical home button.
    var hasHomeButton: Bool {
        if #available(iOS 11.0, *),
        let keyWindow = UIApplication.shared.keyWindow,
        keyWindow.safeAreaInsets.bottom > 0 {
            return true
        }
        return false
    }
    
}
