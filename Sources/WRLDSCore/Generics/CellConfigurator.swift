//
//  CellConfigurator.swift
//  WRLDS
//  Created by Garrett Jester on 6/10/20.
//  Copyright © 2020 WRLDS. All rights reserved.
//
//  Inspriation from Chili Labs:
//  https://medium.com/chili-labs/configuring-multiple-cells-with-generics-in-swift-dcd5e209ba16
//

import UIKit

/// A generic class for configuring a UICollectionView with multiple custom subclasses.
class CellConfigurator<CellType: ConfigurableCell, DataType>: Configurator where CellType.DataType == DataType, CellType: UIView {
    
    let item: DataType
    
    static var reuseId: String {
        return String(describing: CellType.self)
    }
    
    init(item: DataType) {
        self.item = item
    }
    
    static var collectionCellType: UICollectionViewCell.Type {
        guard let type = CellType.self as? UICollectionViewCell.Type else {
            fatalError("Could not case Configurable cell as UICollectionViewCell.")
        }
        return type
    }

    
    static var tableCellType: UITableViewCell.Type {
        guard let type = CellType.self as? UITableViewCell.Type else {
            fatalError("Could not case Configurable cell as UITableViewCell.")
        }
        return type
    }
    

    func configure(cell: UIView) {
        (cell as! CellType).configure(model: item)
    }
}


protocol ConfigurableCell {
    associatedtype DataType
    func configure(model: DataType)
    
}


protocol Configurator {
    static var reuseId: String {get}
    static var collectionCellType: UICollectionViewCell.Type {get}
    static var tableCellType: UITableViewCell.Type {get}
    func configure(cell: UIView)
}
