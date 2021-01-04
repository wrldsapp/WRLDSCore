//
//  MenuBar.swift
//  WRLDS
//
//  Created by Garrett Jester on 7/25/20.
//  Copyright © 2020 WRLDS. All rights reserved.
//

import UIKit

/// An object that supplies the tab content for a MenuBar.
protocol MenuBarDataSource {
    var preselectedIndex: IndexPath? { get }
    var tabs: [String] { get }
    var isIcon: Bool { get }
}

/// An object that responds to actions taken in a MenuBar.
protocol MenuBarDelegate {
    func didSelectTab(at indexPath: IndexPath)
}

/// A tab bar used to manage selection between multiple items.
class MenuBar: UIView {
    
    init(frame: CGRect, delegate: MenuBarDelegate?, dataSource: MenuBarDataSource) {
        super.init(frame: frame)
        self.delegate = delegate
        self.dataSource = dataSource
        layout()
    }
    
    var delegate: MenuBarDelegate!
    var dataSource: MenuBarDataSource!
    
    
    lazy var slider: Slider = {
        let slider = Slider(
            tabCount: self.dataSource.tabs.count,
            frame: CGRect(x: 0, y: frame.height - 2, width: frame.width, height: 2))
        return slider
    }()
    
    
    lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        let cv = UICollectionView(frame: CGRect(x: 0, y: 0, width: 100, height: 30), collectionViewLayout: layout)
        cv.registerCell(MenuBarCell.self)
        cv.backgroundColor = .backgroundGray
        cv.dataSource = self
        cv.delegate = self
        cv.translatesAutoresizingMaskIntoConstraints = false
        return cv
    }()
    
    
    private func layout() {
        addSubviews(collectionView, slider)
        collectionView.fillSuperview()
        //slider.anchor(nil, left: leftAnchor, bottom: bottomAnchor, right: rightAnchor, topConstant: 0, leftConstant: 0, bottomConstant: 0, rightConstant: 0, width: nil, widthConstant: 0, height: nil, heightConstant: 2, centerXInSuperView: true, centerYInSuperView: false)
        
        collectionView.reloadData()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}



extension MenuBar: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return dataSource.tabs.count
    }
    
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let dataSource = dataSource else { fatalError("Unexpectedly found nil in MenuBar datasource.")}
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MenuBarCell.reuseID, for: indexPath) as! MenuBarCell
        cell.configure(withString: dataSource.tabs[indexPath.item], asIcon: dataSource.isIcon)
        let selected = dataSource.preselectedIndex ?? IndexPath(item: 0, section: 0)
        if indexPath == selected {
            cell.isSelected = true
            collectionView.selectItem(at: indexPath, animated: false, scrollPosition: [])
        }
        cell.backgroundColor = .clear
        return cell
    }
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: frame.width/CGFloat(dataSource.tabs.count), height: frame.height)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        delegate.didSelectTab(at: indexPath)
    }
}
