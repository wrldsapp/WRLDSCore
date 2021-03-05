//
//  ErrorCellCollectionViewCell.swift
//  ---------------------------------
//  A cell for displaying error messages.

//  See the Err object for information about
//  custom error messages & codes.
//
//  Created by Garrett Jester on 9/1/20.
//  Copyright © 2021 WRLDS. All rights reserved.
//

import UIKit

public typealias ErrorItem = CellConfigurator<ErrorCell, Err?>

public class ErrorCell: UICollectionViewCell, ConfigurableCell {
    
    
    private lazy var errorIcon: UIImageView = {
        let iv = UIImageView(image: UIImage(named: "error"))
        iv.contentMode = .scaleAspectFit
        iv.tintColor = .error
        iv.translatesAutoresizingMaskIntoConstraints = false
        return iv
    }()
    
    lazy var errorLabel: UILabel = {
        let lbl = UILabel(text: "", font: .error, color: .error, textAlignment: .left, numberOfLines: 0)
        lbl.translatesAutoresizingMaskIntoConstraints = false
        return lbl
    }()
    
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        layout()
    }
    
    
    private func layout() {
        self.clipsToBounds = true
        
        addSubviews(errorIcon, errorLabel)

        errorIcon.anchor(nil, left: leftAnchor, bottom: nil, right: nil, topConstant: 0, leftConstant: 30, bottomConstant: 0, rightConstant: 0, width: nil, widthConstant: 12, height: nil, heightConstant: 12, centerXInSuperView: false, centerYInSuperView: true)
        
        errorLabel.anchor(nil, left: errorIcon.rightAnchor, bottom: nil, right: rightAnchor, topConstant: 0, leftConstant: 8, bottomConstant: 0, rightConstant: 30, width: nil, widthConstant: 0, height: heightAnchor, heightConstant: 0, centerXInSuperView: false, centerYInSuperView: true)
    }
    
    
    public func configure(model: Err?) {
        guard model != nil else {return}
        self.errorLabel.text = model!.message
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
