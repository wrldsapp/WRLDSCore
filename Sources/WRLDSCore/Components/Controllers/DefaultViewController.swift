//
//  DefaultViewController.swift
//  WRLDS
//
//  Created by Garrett Jester on 9/24/20.
//  Copyright © 2020 WRLDS. All rights reserved.
//

import UIKit
import Lottie

open class DefaultViewController: UIViewController {

    open override var title: String? {
        didSet {
            let attributes = [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 15, weight: .bold)]
            self.navigationController?.navigationBar.titleTextAttributes = attributes
        }
    }
    
    lazy var loader = Loader(parent: self.view)
    var tapToDismissGesture: UITapGestureRecognizer!
    
    public override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .backgroundGray
        navigationController?.navigationBar.barTintColor = .backgroundGray
        navigationController?.navigationBar.isTranslucent = false
        navigationController?.navigationBar.setBackgroundImage(UIImage(color: .backgroundGray), for: .default)
        navigationController?.navigationBar.shadowImage = UIImage()
        
        tapToDismissGesture = UITapGestureRecognizer(target: self.view, action: #selector(UIView.endEditing(_:)))
        tapToDismissGesture.cancelsTouchesInView = false
        self.view.addGestureRecognizer(tapToDismissGesture)
    }
    
    
    public func add(asChildViewController childController: UIViewController) {
        addChild(childController)
        view.addSubview(childController.view)
        childController.view.anchor(view.topAnchor, left: view.leftAnchor, bottom: view.bottomAnchor, right: view.rightAnchor, topConstant: 0, leftConstant: 0, bottomConstant: 0, rightConstant: 0, width: nil, widthConstant: 0, height: nil, heightConstant: 0, centerXInSuperView: true, centerYInSuperView: true)
        childController.didMove(toParent: self)
    }
    
    
    public func remove(asChildViewController childController: UIViewController) {
        childController.willMove(toParent: nil)
        childController.view.removeFromSuperview()
        childController.removeFromParent()
    }
    

    func presentDetail(_ viewControllerToPresent: UIViewController) {
        let transition = CATransition()
        transition.duration = 0.25
        transition.type = CATransitionType.push
        transition.subtype = CATransitionSubtype.fromRight
        self.view.window!.layer.add(transition, forKey: kCATransition)
        
        present(viewControllerToPresent, animated: false)
    }
    
    
    public func startProcess() {
        DispatchQueue.main.async {
            self.view.isUserInteractionEnabled = false
            NotificationCenter.default.post(name: .processStarted, object: nil)
        }
    }
    
    
    public func endProcess() {
        DispatchQueue.main.async {
            self.view.isUserInteractionEnabled = true
            NotificationCenter.default.post(name: .processFinished, object: nil)
        }
    }
    
    
    func dismissDetail() {
        let transition = CATransition()
        transition.duration = 0.25
        transition.type = CATransitionType.push
        transition.subtype = CATransitionSubtype.fromLeft
        self.view.window!.layer.add(transition, forKey: kCATransition)
        dismiss(animated: false)
    }
    
    
    public func startLoader(message: String? = nil) {
        self.view.isUserInteractionEnabled = false
        self.loader.startAnimating()
    }
    
    public func stopLoader() {
        self.view.isUserInteractionEnabled = true
        self.loader.animator.stop()
        self.loader.removeFromSuperview()
    }
    
    
    public func addHomeButtonBackground() {
        if DeviceManager.shared.hasHomeButton {
            let background = UIView(color: .backgroundGray)
            view.addSubview(background)
            background.anchor(view.safeAreaLayoutGuide.bottomAnchor, left: view.leftAnchor, bottom: view.bottomAnchor, right: view.rightAnchor, topConstant: 0, leftConstant: 0, bottomConstant: 0, rightConstant: 0, width: nil, widthConstant: 0, height: nil, heightConstant: 0, centerXInSuperView: true, centerYInSuperView: false)
        }
    }
    
    
    func showNavSeparator() {
        if let nav = self.navigationController as? NavigationController {
            nav.showNavSeparator()
        }
    }
}


