//
//  File.swift
//  
//
//  Created by Garrett Jester on 1/4/21.
//

import Foundation

struct Requirement {
    var title: String
    var satisfied: Bool = false
    
    init(title: String, satisfied: Bool) {
        self.title = title
        self.satisfied = satisfied
    }
}

