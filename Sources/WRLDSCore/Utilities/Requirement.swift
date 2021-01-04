//
//  File.swift
//  
//
//  Created by Garrett Jester on 1/4/21.
//

import Foundation

public struct Requirement {
    var title: String
    var satisfied: Bool = false
    
    public init(title: String, satisfied: Bool) {
        self.title = title
        self.satisfied = satisfied
    }
}

