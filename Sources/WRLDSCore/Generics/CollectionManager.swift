//
//  CollectionManager.swift
//  WRLDS
//
//  Created by Garrett Jester on 11/8/20.
//  Copyright © 2020 WRLDS. All rights reserved.
//

import UIKit


protocol CollectionManager: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    var items: [Configurator]? { get }
    var cells: [UICollectionViewCell.Type]? { get }
}

extension CollectionManager {
    var cells: [UICollectionViewCell.Type]? {
        guard let items = self.items else {return nil}
        return items.map { type(of: $0).collectionCellType }}
    var items: [Configurator]? { return nil }
}

@objc protocol CollectionManagerDelegate {
    func reloadItems(at indexPath: IndexPath, tag: Int) -> Void
    @objc optional func shouldStartProcess() -> Void
    @objc optional func shouldEndProcess() -> Void
    @objc optional func presentModal(vc: UIViewController) -> Void
    @objc optional func push(vc: UIViewController) -> Void
    @objc optional func showNext(sender: Any) -> Void
}

