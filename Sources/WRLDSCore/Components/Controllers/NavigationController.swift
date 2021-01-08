//
//  NavigationController.swift
//  WRLDS
//
//  Created by Garrett Jester on 7/24/20.
//  Copyright © 2020 WRLDS. All rights reserved.
//

import UIKit

open class NavigationController: UINavigationController, UINavigationControllerDelegate {
    
    public var separator: UIView?
   
    open override func viewDidLoad() {
        super.viewDidLoad()
        self.delegate = self
        layoutNavBar()
    }
    
    
    private func layoutNavBar() {
        let backImage = UIImage(named: "back")?.withAlignmentRectInsets(UIEdgeInsets(top: 0, left: -10, bottom: 0, right: 0))
        navigationBar.backIndicatorImage = backImage
        navigationBar.tintColor = .primaryText
        navigationBar.backIndicatorTransitionMaskImage = backImage
        navigationBar.isTranslucent = false
        navigationBar.shadowImage = UIImage()
        navigationBar.setBackgroundImage(UIImage(color: .backgroundGray), for: .default)
    }
    
    
    public func showNavSeparator() {
        if separator == nil {
            separator =  UIView(color: .separator)
            navigationBar.addSubview(separator!)
            separator?.anchor(navigationBar.bottomAnchor, left: navigationBar.leftAnchor, bottom: nil, right: navigationBar.rightAnchor, topConstant: 0, leftConstant: 0, bottomConstant: 0, rightConstant: 0, width: view.widthAnchor, widthConstant: 0, height: nil, heightConstant: 0.25, centerXInSuperView: true, centerYInSuperView: false)
            
        }
        separator?.isHidden = false
    }
    
    
    public func hideSeparator() {
        separator?.isHidden = true
    }
    
    
    public override init(rootViewController: UIViewController) {
        super.init(rootViewController: rootViewController)
        self.updateBarTint()
    }
    
    
    public func navigationController(_ navigationController: UINavigationController, willShow viewController: UIViewController, animated: Bool) {
        viewController.navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
        viewController.viewWillAppear(animated)
        
    }
    
    
    public override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
        super.traitCollectionDidChange(previousTraitCollection)
        self.updateBarTint()
    }
    
    /// Updates the 
    private func updateBarTint() {
        //let background = (UITraitCollection.current.userInterfaceStyle == .dark) ?
        if #available(iOS 13.0, *) {
            navigationBar.setBackgroundImage(UIImage(color: .backgroundGray), for: .default)
        }
    }
    

    required public init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        updateBarTint()
    }
}
