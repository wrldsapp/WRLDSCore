//
//  ProfileCollection.swift
//  
//
//  Created by Garrett Jester on 6/9/20.
//

import UIKit

public class PageCollectionView: UICollectionView {
 
    public init(frame: CGRect) {
        let fl = UICollectionViewFlowLayout()
        fl.scrollDirection = .horizontal
        super.init(frame: frame, collectionViewLayout: fl)
        configure()
    }

    private func configure() {
        self.showsHorizontalScrollIndicator = false
        self.showsVerticalScrollIndicator = false
        self.isPagingEnabled = true
        self.bounces = false
        self.registerCell(ViewControllerCell.self)
    }    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}
