//
//  TimeInterval+Extensions.swift
//  WRLDS
//
//  Created by Garrett Jester on 12/27/20.
//  Copyright © 2020 WRLDS. All rights reserved.
//

import Foundation

extension TimeInterval {
    
    var durationString: String {
        let formatter = DateComponentsFormatter()
        formatter.zeroFormattingBehavior = .pad
        if self >= 3600 {
            formatter.allowedUnits = [.hour, .minute, .second];
        } else {
            formatter.allowedUnits = [.minute, .second];
        }
        return formatter.string(from: self)!
    }
}
