//
//  CollectionController.swift
//  WRLDS
//
//  Created by Garrett Jester on 7/22/20.
//  Copyright © 2020 WRLDS. All rights reserved.
//

import UIKit

/// A helper class for displaying UICollectionView content.

open class CollectionController: DefaultViewController {
    
    var direction: UICollectionView.ScrollDirection!
    var manager: CollectionManager!
    
    
    public init(manager: CollectionManager?, scrollDirection: UICollectionView.ScrollDirection?) {
        super.init(nibName: nil, bundle: nil)
        guard let manager = manager else {return}
        self.manager = manager
        self.direction = scrollDirection
    }
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nil, bundle: nil)
    }
    

    public lazy var collectionView: UICollectionView = {
        let lyt = UICollectionViewFlowLayout()
        lyt.scrollDirection = .vertical
        let cv = UICollectionView(frame: view.frame, collectionViewLayout: lyt)
        cv.backgroundColor = .backgroundGray
        cv.delegate = manager
        cv.dataSource = manager
        if let cells = manager.cells { cv.register(cells: cells) }
        return cv
    }()
    
    
    public override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .backgroundGray
        setupCollectionView()
    }
    
    
    private func setupCollectionView() {
        view.addSubview(collectionView)
        collectionView.reloadData()
    }
    
    func layoutCollectionView() {
        collectionView.fillSuperview()
        self.view.layoutIfNeeded()
    }
    
    required public init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}


extension CollectionController {
    func reload(items: [Int]) {
        self.collectionView.reloadItems(items: items)
    }
}
