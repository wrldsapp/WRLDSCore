//
//  TextField.swift
//  WRLDS
//
//  Created by Garrett Jester on 8/1/20.
//  Copyright © 2020 WRLDS. All rights reserved.
//

import UIKit

/// Default text field. Can be configured for various FieldInputType cases
class TextField: UITextField {
    
    var type: FieldInputType? {
        didSet {
            guard let type = type else {return}
            setup(forType: type)
        }
    }
    
    override var placeholder: String? {
        didSet {
            guard let placeholder = placeholder else {return}
            self.attributedPlaceholder = NSAttributedString(string: placeholder, attributes: [NSAttributedString.Key.foregroundColor: UIColor.disabledButtonText])
        }
    }
    
    
    init() {
        super.init(frame: CGRect.zero)
        layout()
    }
    
    private func layout() {
        backgroundColor = .clear
        textColor = .primaryText
        tintColor = .wrldsBlue
        font = .textField
    }
    
    
    private func setup(forType: FieldInputType) {
        switch type {
        case .birthday:
            placeholder = "Date of birth"
            isUserInteractionEnabled = false
        case .password:
            placeholder = "Password"
            isSecureTextEntry = true
            clearButtonMode = .always
            keyboardType = .asciiCapable
        case .phone:
            placeholder = "Phone number"
            keyboardType = .phonePad
        case .email:
            placeholder = "Email"
            keyboardType = .emailAddress
            autocapitalizationType = .none
            autocorrectionType = .no
        case .username:
            placeholder = "username"
            keyboardType = .asciiCapable
            autocorrectionType = .no
        case .emailUsername:
            placeholder = "Email or username"
            keyboardType = .default
            autocorrectionType = .no
            autocapitalizationType = .none
        case .name:
            placeholder = "Name"
            autocapitalizationType = .words
            keyboardType = .default
        case .none:
            return
        }
    }
    

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}


enum FieldInputType {
    case birthday
    case phone
    case email
    case password
    case username
    case emailUsername
    case name
}








