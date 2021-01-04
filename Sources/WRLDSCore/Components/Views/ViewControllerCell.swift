//
//  ViewControllerCell.swift
//  WRLDS
//
//  Created by Garrett Jester on 6/9/20.
//  Copyright © 2020 WRLDS. All rights reserved.
//
import UIKit


/// Used display a UIViewController's view inside of a cell (ex. in a PageCollectionView).

class ViewControllerCell: UICollectionViewCell {

    static let reuseID = "ViewControllerCell"
    
    /// The controller's view.
    var hostedView: UIView? {
        didSet {
            layout()
        }
    }
    
    /// Add view and constraints.
    private func layout() {
        guard let v = hostedView else {return}
        self.addSubview(v)
        v.backgroundColor = .backgroundGray
        v.translatesAutoresizingMaskIntoConstraints = false
        hostedView?.topAnchor.constraint(equalTo: topAnchor).isActive = true
        hostedView?.leftAnchor.constraint(equalTo: leftAnchor).isActive = true
        hostedView?.rightAnchor.constraint(equalTo: rightAnchor).isActive = true
        hostedView?.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true 
    }
    
    /// Clean.
    override func prepareForReuse() {
        super.prepareForReuse()
        self.hostedView?.removeFromSuperview()
        self.hostedView = nil
    }
}
