//
//  CollectionView.swift
//  WRLDS
//
//  Created by Garrett Jester on 11/4/20.
//  Copyright © 2020 WRLDS. All rights reserved.
//

import UIKit

class CollectionView: UICollectionView {
    
    var topInset: CGFloat
    var placeholder: PlaceholderView?
    var manager: CollectionManager?
    
    init(frame: CGRect? = nil, manager: CollectionManager? = nil, topInset: CGFloat = 0) {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        self.topInset = topInset
        super.init(frame: frame ?? CGRect.zero, collectionViewLayout: layout)
        configure()
        self.manager = manager
        self.delegate = manager
        self.dataSource = manager
        guard let cells = manager?.cells else {return}
        register(cells: cells)
    }
    
    private func configure() {
        self.keyboardDismissMode = .onDrag
        self.alwaysBounceVertical = true
        self.contentInset = UIEdgeInsets(top: topInset, left: 0, bottom: 0, right: 0)
        let notificationCenter = NotificationCenter.default
        notificationCenter.addObserver(self, selector: #selector(adjustForKeyboard), name: UIResponder.keyboardWillHideNotification, object: nil)
        notificationCenter.addObserver(self, selector: #selector(adjustForKeyboard), name: UIResponder.keyboardWillChangeFrameNotification, object: nil)
    }
    
    @objc func adjustForKeyboard(notification: Notification) {
        guard let keyboardValue = notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue else { return }

        let keyboardScreenEndFrame = keyboardValue.cgRectValue
        //let keyboardViewEndFrame = self.convert(keyboardScreenEndFrame, from: UIApplication.shared.keyWindow)

        if notification.name == UIResponder.keyboardWillHideNotification {
            self.contentInset = UIEdgeInsets(top: topInset, left: 0, bottom: 0, right: 0)
        } else {
            self.contentInset = UIEdgeInsets(top: topInset, left: 0, bottom: keyboardScreenEndFrame.height, right: 0)
        }
        self.scrollIndicatorInsets = self.contentInset
    }
    
    //keyboardViewEndFrame.height - self.safeAreaInsets.bottom
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    func showEmptyPlaceholder(model: PlaceholderViewModel) {
        self.placeholder = PlaceholderView(model: model)
        self.addSubview(placeholder!)
        placeholder?.anchor(self.topAnchor, left: self.leftAnchor, bottom: self.bottomAnchor, right: self.rightAnchor, topConstant: 0, leftConstant: 0, bottomConstant: 0, rightConstant: 0, width: nil, widthConstant: 0, height: nil, heightConstant: 0, centerXInSuperView: true, centerYInSuperView: true)
        showsVerticalScrollIndicator = false
        alwaysBounceVertical = false
        contentInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
    }
    
    
    func hidePlaceholder() {
        self.placeholder?.removeFromSuperview()
        self.placeholder = nil
        showsVerticalScrollIndicator = true
        alwaysBounceVertical = true
        contentInset = UIEdgeInsets(top: topInset, left: 0, bottom: 0, right: 0)
    }
}

