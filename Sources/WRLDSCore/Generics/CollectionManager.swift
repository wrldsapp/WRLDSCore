//
//  CollectionManager.swift
//  WRLDS
//
//  Created by Garrett Jester on 11/8/20.
//  Copyright © 2020 WRLDS. All rights reserved.
//

import UIKit

public protocol CollectionManager: UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    var items: [Configurator]? { get }
    var cells: [UICollectionViewCell.Type]? { get }
}

public extension CollectionManager {
    var cells: [UICollectionViewCell.Type]? {
        print("ATTEMPTING TO GET CELLS")
        guard let items = self.items else {return nil}
        print("GOT ITEMS")
        return items.map { type(of: $0).collectionCellType }}
   var items: [Configurator]? { return nil }
}

@objc public protocol CollectionManagerDelegate {
    func reloadItems(at indexPath: IndexPath, tag: Int) -> Void
    @objc optional func shouldStartProcess() -> Void
    @objc optional func shouldEndProcess() -> Void
    @objc optional func presentModal(vc: UIViewController) -> Void
    @objc optional func push(vc: UIViewController) -> Void
    @objc optional func showNext(sender: Any) -> Void
}

