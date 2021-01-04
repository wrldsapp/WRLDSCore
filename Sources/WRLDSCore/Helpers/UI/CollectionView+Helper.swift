//
//  UICollectionViewExtensions.swift
//  WRLDS
//
//  Created by Gillian Reynolds-Titko on 3/9/20.
//  Copyright © 2020 WRLDS. All rights reserved.
//

import UIKit

extension UICollectionView {
    
    
    /// Registers a custom UICollectionViewCell class. Configures it's reuseID
    /// to a string describing the class name (i.e. "UserCell")
    /// - Parameter cellClass: The UICollectionView cell class to be registered.
    
    func registerCell<Cell: UICollectionViewCell>(_ cellClass: Cell.Type) {
        register(cellClass, forCellWithReuseIdentifier:String(describing: cellClass))
    }
    
    
    /// Dequeues a UICollectionViewCell class with it's given reuseID.
    /// - Parameter indexPath: The indexPath at which to display the cell.
    /// - Returns: An initialized UICollectionViewCell to be displayed by the CollectionView.
    func dequeueReusableCell<Cell: UICollectionViewCell>(forIndexPath indexPath: IndexPath) -> Cell {
        let identifier = String(describing: Cell.self)
        guard let cell = self.dequeueReusableCell(withReuseIdentifier: identifier, for: indexPath) as? Cell else {
            fatalError("Error for cell id: \(identifier) at \(indexPath)")
        }
        return cell
    }
    
    
    /// Get's the indexPaths of all text in a given CGRect.
    /// - Parameter rect: The CGRect containing the cells of interest.
    /// - Returns: An array of IndexPaths for the cells in the CGRect of interest.
    func indexPathsForElements(in rect: CGRect) -> [IndexPath] {
        let allLayoutAttributes = collectionViewLayout.layoutAttributesForElements(in: rect)!
        return allLayoutAttributes.map { $0.indexPath }
    }
    
   
    /// Registers an array of UICollectionViewCells to be used in a UICollectionView.
    /// - Parameter cells: The cell classes to be registered.
    func register(cells: [UICollectionViewCell.Type]) {
        for cell in cells {
            registerCell(cell)
        }
    }
    
    
    /// Sizes a collection cell as a portion of CollectionView's height with fixed with.
    /// - Parameter heightMultiplier: The fraction of the CollectionView's height that the cell should fill.
    /// - Returns: Cell size (to be used in sizeForItem)
    func cellSize(heightMultiplier: CGFloat) -> CGSize {
        let w = self.frame.width
        let h = self.frame.height * heightMultiplier
        return CGSize(width: w, height: h)
    }
    
    
    
    /// Sizes a fixed-width collection cell with the given height.
    /// - Parameter height: The height of the cell
    /// - Returns: Cell size (to be used in sizeForItem)
    func cellSize(withHeight height: CGFloat) -> CGSize {
        return CGSize(width: self.frame.width, height: height)
    }
    
    
    func reloadItems(items: [Int]) {
        var indexPaths = [IndexPath]()
        for i in items { indexPaths.append(IndexPath(item: i, section: 0)) }
        reloadItems(at: indexPaths)
    }
    
    
    /// Finds the first nested textfield in collection and makes it the first responder.
    @objc func becomeFirstResponderTextField() {
        outer: for cell in visibleCells {
            for view in cell.subviews {
                if let textfield = view as? TextField {
                    textfield.becomeFirstResponder()
                    break outer
                }
            }
        }
    }
}



extension UICollectionViewLayout {
    
    static func grid(rowCount: CGFloat, frame: CGRect) -> UICollectionViewFlowLayout {
        let lyt = UICollectionViewFlowLayout()
        lyt.scrollDirection = .vertical
        let side = (frame.width - (rowCount - 1))/rowCount
        lyt.itemSize = CGSize(width: side, height: side)
        return lyt
    }
}
