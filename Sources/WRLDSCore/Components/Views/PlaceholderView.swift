//
//  PlaceholderView.swift
//  WRLDS
//
//  Created by Garrett Jester on 10/14/20.
//  Copyright © 2020 WRLDS. All rights reserved.
//

import UIKit

public class PlaceholderView: UIView {
    
    var model: PlaceholderViewModel!
    var button: UIButton?
    var imageView: UIImageView?
    var titleLabel: UILabel?
    var messageLabel: UILabel?
    
    public init(model: PlaceholderViewModel) {
        super.init(frame: CGRect.zero)
        self.model = model
        layoutForStyle(style: model.style)
    }
    
    
    private func layoutForStyle(style: PlaceholderStyle) {
        backgroundColor = .backgroundGray
    
        if let image = model.image {
            imageView = UIImageView(image: image)
            imageView?.backgroundColor = .wrldsBlue
            //imageView?.contentMode = .center
            imageView?.translatesAutoresizingMaskIntoConstraints = false
            self.addSubview(imageView!)
            imageView?.bottomAnchor.constraint(equalTo: centerYAnchor, constant: imageView?.frame.height ?? 30).isActive = true
            imageView?.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
            imageView?.tintColor = .wrldsGrayText
        }
        
        if let title = model.title {
            titleLabel = UILabel(text: title, font: .systemFont(ofSize: 15, weight: .bold), color: .primaryText, textAlignment: .center, numberOfLines: 0)
            self.addSubview(titleLabel!)
            titleLabel?.translatesAutoresizingMaskIntoConstraints = false
            titleLabel?.topAnchor.constraint(
                equalTo: model.image == nil ? centerYAnchor : imageView!.bottomAnchor,
                constant: model.image == nil ? -120 : 10).isActive = true
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
            addSubview(messageLabel!)
            
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
            self.addSubview(button!)
            button?.setTitle(buttonTitle, for: .normal)
            if model.style == .fullscreen {
                button?.anchor(nil,left: leftAnchor, bottom: bottomAnchor, right: rightAnchor, topConstant: 0, leftConstant: 30, bottomConstant: 120, rightConstant: 30, width: nil, widthConstant: 0, height: nil, heightConstant: 45, centerXInSuperView: true, centerYInSuperView: false)
            } else {
                button?.translatesAutoresizingMaskIntoConstraints = false
                button?.topAnchor.constraint(equalTo: messageLabel == nil ? titleLabel!.bottomAnchor : messageLabel!.bottomAnchor, constant: 20).isActive = true
                button?.heightAnchor.constraint(equalToConstant: 40).isActive = true
                button?.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 0.75).isActive = true
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



public struct PlaceholderViewModel {
    var style: PlaceholderStyle
    var title: String?
    var message: String?
    var image: UIImage?
    var buttonTitle: String?
    var delegate: ActionDelegate?
    
    public init(style: PlaceholderStyle, title: String?, message: String?, image: UIImage?, buttonTitle: String?, delegate: ActionDelegate?) {
        self.style = style
        self.title = title
        self.message = message
        self.image = image
        self.buttonTitle = buttonTitle
        self.delegate = delegate
    }
}


public protocol ActionDelegate {
    func didTap(_ sender: Any)
}


public enum PlaceholderStyle {
    case fullscreen
    case condensed
}
