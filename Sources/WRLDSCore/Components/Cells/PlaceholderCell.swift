//
//  PlaceholderCell.swift
//  ---------------------
//  A cell used as background when a CollectionView's content
//  is empty. Can be configured with multiple styles.
//
//  Created by Garrett Jester on 3/5/21.
//

import UIKit

public class PlaceholderCell: UICollectionViewCell, ConfigurableCell {
    
    public var model: PlaceholderViewModel!
    private var button: UIButton?
    private var imageView: UIImageView?
    private var titleLabel: UILabel?
    private var messageLabel: UILabel?
    
    
    public override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .backgroundGray
    }
    
    
    public func configure(model: PlaceholderViewModel) {
        
        if let image = model.image {
            imageView = UIImageView(image: image)
            imageView?.translatesAutoresizingMaskIntoConstraints = false
            self.contentView.addSubview(imageView!)
            imageView?.bottomAnchor.constraint(equalTo: centerYAnchor, constant: -(imageView?.frame.height ?? -30)).isActive = true
            imageView?.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
            imageView?.tintColor = .wrldsGrayText
        }
        
        if let title = model.title {
            titleLabel = UILabel(text: title, font: .systemFont(ofSize: 15, weight: .bold), color: .primaryText, textAlignment: .center, numberOfLines: 0)
            self.contentView.addSubview(titleLabel!)
            titleLabel?.translatesAutoresizingMaskIntoConstraints = false
            titleLabel?.topAnchor.constraint(
                equalTo: model.image == nil ? centerYAnchor : imageView!.bottomAnchor,
                constant: model.image == nil ? -120 : 16).isActive = true
            titleLabel?.leftAnchor.constraint(
                equalTo: leftAnchor,
                constant: 45).isActive = true
            titleLabel?.rightAnchor.constraint(
                equalTo: rightAnchor,
                constant: -45).isActive = true
        }
        
        
        if let message = model.message {
            messageLabel = UILabel(text: message, font: .systemFont(ofSize: 14, weight: .regular), color: .secondaryText, textAlignment: .center, numberOfLines: 0)
            
            messageLabel?.translatesAutoresizingMaskIntoConstraints = false
            self.contentView.addSubview(messageLabel!)
            
            messageLabel?.leftAnchor.constraint(
                equalTo: leftAnchor,
                constant: 30).isActive = true
            
            messageLabel?.rightAnchor.constraint(
                equalTo: rightAnchor,
                constant: -30).isActive = true
            
            messageLabel?.topAnchor.constraint(
                equalTo: (titleLabel == nil && imageView == nil) ? centerYAnchor: // If both image & title are nil, center message
                    titleLabel != nil ? titleLabel!.bottomAnchor: // Pin message to title bottom..
                    imageView!.bottomAnchor, // Pin message to image bottom
                constant: (titleLabel == nil && imageView == nil) ? -150 : 5
            ).isActive = true
        }
        
        
        if let buttonTitle = model.buttonTitle {
            button = (model.style == .condensed) ? UIButton(type: .system) : DefaultButton()
            self.contentView.addSubview(button!)
            button?.setTitle(buttonTitle, for: .normal)
            if model.style == .fullscreen {
                button?.anchor(nil,left: leftAnchor, bottom: bottomAnchor, right: rightAnchor, topConstant: 0, leftConstant: 30, bottomConstant: 120, rightConstant: 30, width: nil, widthConstant: 0, height: nil, heightConstant: 45, centerXInSuperView: true, centerYInSuperView: false)
            } else {
                button?.translatesAutoresizingMaskIntoConstraints = false
                button?.topAnchor.constraint(equalTo: messageLabel == nil ? titleLabel!.bottomAnchor : messageLabel!.bottomAnchor, constant: 20).isActive = true
                button?.heightAnchor.constraint(equalToConstant: 40).isActive = true
                button?.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 0.65).isActive = true
                button?.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
                button?.titleLabel?.font = UIFont.systemFont(ofSize: 15, weight: .medium)
                button?.tintColor = .wrldsBlue
            }
            button?.addTarget(self, action: #selector(buttonTapped(_:)), for: .touchUpInside)
        }
    }
    
    
    @objc func buttonTapped(_ sender: Any) {
        model.delegate?.didTap(sender)
    }
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
