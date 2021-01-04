//
//  CollectionController.swift
//  WRLDS
//
//  Created by Garrett Jester on 11/3/20.
//  Copyright © 2020 WRLDS. All rights reserved.
//

import UIKit

open class CollectionPageController: DefaultViewController {
    
    public var manager: CollectionPageManager!
    public var collectionView: PageCollectionView!
    public var menubar: MenuBar!
    public var placeholderView: PlaceholderView?
    
    public init() {
        super.init(nibName: nil, bundle: nil)
    }
    
    open override func viewDidLoad() {
        super.viewDidLoad()
        collectionView = PageCollectionView(frame: CGRect(x: 0, y: view.safeAreaLayoutGuide.layoutFrame.minY + 35, width: view.frame.width, height: view.safeAreaLayoutGuide.layoutFrame.height - 150))
        menubar = MenuBar(frame: CGRect(x:0, y: self.view.safeAreaLayoutGuide.layoutFrame.minY, width: view.frame.width, height: 35), delegate: self, dataSource: manager)
        
        view.addSubviews(menubar, collectionView)
        collectionView.backgroundColor = .backgroundGray
        
        collectionView.anchor(view.safeAreaLayoutGuide.topAnchor, left: view.leftAnchor, bottom: view.bottomAnchor, right: view.rightAnchor, topConstant: 35, leftConstant: 0, bottomConstant: 0, rightConstant: 0, width: nil, widthConstant: 0, height: nil, heightConstant: 0, centerXInSuperView: true, centerYInSuperView: false)
        
        view.layoutIfNeeded()
        collectionView.delegate = self
        collectionView.dataSource = self
    }
    
    
    func showEmptyPlaceholder() {
        guard let model = self.manager.placeholderModel else {fatalError("Found nil when asked to present a placeholder view.")}
        self.placeholderView = PlaceholderView(model: model)
        self.collectionView.addSubview(placeholderView!)
        placeholderView?.anchor(collectionView.topAnchor, left: collectionView.leftAnchor, bottom: collectionView.bottomAnchor, right: collectionView.rightAnchor, topConstant: 0, leftConstant: 0, bottomConstant: 0, rightConstant: 0, width: nil, widthConstant: 0, height: nil, heightConstant: 0, centerXInSuperView: true, centerYInSuperView: true)
    }
    
    func hidePlaceholder() {
        self.placeholderView?.removeFromSuperview()
    }
    
    
    func showLoader() {
        
    }
    
    
    required public init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}


extension CollectionPageController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    public func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int { return manager.numberOfPages }
    
    
    public func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ViewControllerCell.reuseID, for: indexPath) as! ViewControllerCell
        cell.hostedView = manager.collectionView(withFrame: cell.frame, forCellAt: indexPath)
        return cell
    }
    
    
    public func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return collectionView.frame.size
    }
    
    
    public func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    
    public func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    
    public func scrollViewDidScroll(_ scrollView: UIScrollView) {
        if scrollView is UICollectionView {
            let pagesFloat = CGFloat(self.manager.numberOfPages)
            let percentage = scrollView.contentOffset.x / view.frame.width
            let tabWidth: CGFloat = self.view.frame.width / pagesFloat
            
            menubar.slider.indicator.center.x = tabWidth/2 + (percentage * ((1/pagesFloat) * view.frame.width))
            
            // Check if user has scrolled to one of the defined indexes.
            if percentage.truncatingRemainder(dividingBy: 1.0) == 0 {
                let pageIndex = Int(percentage)
                menubar.collectionView.selectItem(at: IndexPath(item: pageIndex, section: 0), animated: false, scrollPosition: [])
                // Notify the manager that the scroll view has been scrolled.
                manager.didScroll(to: pageIndex)
            } else { return }
        }
    }
}


extension CollectionPageController: MenuBarDelegate {
    public func didSelectTab(at indexPath: IndexPath) {
        collectionView.scrollToItem(at: indexPath, at: .left, animated: true)
    }
}


public protocol CollectionPageManager: MenuBarDataSource {
    var placeholderModel: PlaceholderViewModel? { get }
    var numberOfPages: Int { get }
    func collectionView(withFrame frame: CGRect, forCellAt indexPath: IndexPath) -> UICollectionView
    func didScroll(to page: Int) -> Void
}


public extension CollectionPageManager {
    var placeholderModel: PlaceholderViewModel? { return nil }
}


