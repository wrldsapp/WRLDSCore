//
//  MenuBarCell.swift
//  WRLDS
//
//  Created by Garrett Jester on 7/25/20.
//  Copyright © 2020 WRLDS. All rights reserved.
//

import UIKit

class MenuBarCell: UICollectionViewCell {
    
    public static let reuseID = "MenuBarCell"
    var isImage: Bool!
   
    lazy var imageView: UIImageView = {
        let iv = UIImageView()
        iv.contentMode = .scaleAspectFit
        iv.tintColor = .wrldsGrayText
        return iv
    }()
    
    
    lazy var label: UILabel = {
        let lbl = UILabel(text: nil, font: UIFont.systemFont(ofSize: 15, weight: .regular), color: .disabledButtonText, textAlignment: .center, numberOfLines: 1)
        return lbl
    }()
    
    
    override var isHighlighted: Bool {
        didSet {
            updateState()
            
        }
    }
    
    override var isSelected: Bool {
        didSet {
            super.isSelected = isSelected
            updateState()
        }
    }
    
    
    /// Updates the cell's highlighted state.
    private func updateState() {
        if isImage { // Check here to prevent initializing the wrong view if it's not needed.
            imageView.tintColor = (isHighlighted || isSelected) ? .primaryText : .wrldsGrayText
        } else {
            label.font = (isHighlighted || isSelected) ? UIFont.systemFont(ofSize: 15, weight: .semibold) : UIFont.systemFont(ofSize: 15, weight: .medium)
            label.textColor = (isHighlighted || isSelected) ? .primaryText : .disabledButtonText
        }
    }
    
    
    /// Configures the menu tab accoring to its content.
    /// - Parameter title: The title of the tab.
    func configure(withString string: String, asIcon: Bool) {
        asIcon ? setImage(withImageString: string) : setLabel(withTitle: string)
    }
    
    
  
    private func setImage(withImageString string: String) {
        isImage = true
        addSubview(imageView)
        addContraintsWithFormat("H:[v0(25)]", views: imageView)
        addContraintsWithFormat("V:[v0(22)]", views: imageView)
        imageView.anchorCenterXToSuperview()
        imageView.topAnchor.constraint(equalTo: self.topAnchor, constant: 2).isActive = true
        imageView.image = UIImage(named: string)
    }
    
    
    private func setLabel(withTitle title: String) {
        isImage = false
        addSubview(label)
        label.text = title
        label.anchor(topAnchor, left: leftAnchor, bottom: bottomAnchor, right: rightAnchor, topConstant: 0, leftConstant: 15, bottomConstant: 0, rightConstant: 15, width: nil, widthConstant: 0, height: nil, heightConstant: 0, centerXInSuperView: true, centerYInSuperView: true)
    }
}
    
