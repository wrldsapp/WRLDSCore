//
//  TableView+Helper.swift
//  WRLDS
//
//  Created by Garrett Jester on 12/29/20.
//  Copyright © 2020 WRLDS. All rights reserved.
//

import UIKit

public extension UITableView {
    
    /// Registers a custom TableView cell class. 
    func registerCell<Cell: UITableViewCell>(_ cellClass: Cell.Type) {
        self.register(cellClass, forCellReuseIdentifier: String(describing: cellClass))
    }
    
    /// Registers a group of custom TableView cell classes.
    func register(cells: [UITableViewCell.Type]) {
        for cell in cells {
            self.registerCell(cell)
        }
    }
}
