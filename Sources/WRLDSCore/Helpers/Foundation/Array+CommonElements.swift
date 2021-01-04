//
//  Array+CommonElements.swift
//  WRLDS
//
//  Created by Garrett Jester on 11/2/20.
//  Copyright © 2020 WRLDS. All rights reserved.
//

import Foundation

public extension Array where Element: Hashable {

    func set() -> Set<Array.Element> {
        return Set(self)
    }

    func isSubset(of array: Array) -> Bool {
        self.set().isSubset(of: array.set())
    }

    func isSuperset(of array: Array) -> Bool {
        self.set().isSuperset(of: array.set())
    }

    func commonElements(between array: Array) -> Array {
        let intersection = self.set().intersection(array.set())
        return intersection.map({ $0 })
    }

    func hasCommonElements(with array: Array) -> Bool {
        return self.commonElements(between: array).count >= 1 ? true : false
    }
}
