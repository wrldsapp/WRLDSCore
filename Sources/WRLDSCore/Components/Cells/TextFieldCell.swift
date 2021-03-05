//
//  TextFieldCell.swift
//  -------------------
//  A cell for displaying a default-styled
//  TextField.
//
//  Use TextFieldCellModel to configure.
//
//  Created by Garrett Jester on 7/24/20.
//  Copyright © 2022 WRLDS. All rights reserved.
//

import UIKit

typealias TextFieldItem = CellConfigurator<TextFieldCell, TextFieldCellModel>

public protocol TextFieldCellDelegate: UITextFieldDelegate {
    func textFieldDidChange(text: String, tag: Int)
}

public struct TextFieldCellModel {
    var text: String?
    var tag: Int?
    var fieldType: FieldInputType?
    var delegate: TextFieldCellDelegate?
}


public class TextFieldCell: UICollectionViewCell, ConfigurableCell {
    
    static let reuseID = "TextFieldCell"
    
    var delegate: TextFieldCellDelegate?
    var separator = UIView(color: .separator)
    var field = TextField()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        layout()
    }
    
    
    private func layout() {
        addSubviews(field, separator)
        field.anchor(nil, left: leftAnchor, bottom: nil, right: rightAnchor, topConstant: 8, leftConstant: 30, bottomConstant: 0, rightConstant: 30, width: nil, widthConstant: 0, height: nil, heightConstant: 38, centerXInSuperView: true, centerYInSuperView: true)
    
        separator.anchor(field.bottomAnchor, left: field.leftAnchor, bottom: nil, right: field.rightAnchor, topConstant: 0, leftConstant: 0, bottomConstant: 0, rightConstant: 0, width: nil, widthConstant: 0, height: nil, heightConstant: 0.5, centerXInSuperView: true, centerYInSuperView: false)
        
        field.addTarget(self, action: #selector(fieldDidChange), for: .editingChanged)
    }
    
    
    public func configure(model: TextFieldCellModel) {
        field.type = model.fieldType
        field.text = model.text
        field.delegate = model.delegate
        delegate = model.delegate
        guard let tag = model.tag else {return}
        field.tag = tag
        
    }
    
    
    @objc private func fieldDidChange() {
        guard let text = field.text else {return}
        delegate?.textFieldDidChange(text: text, tag: field.tag)
    }
 
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}


