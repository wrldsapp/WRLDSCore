//
//  TitleCell.swift
//  WRLDS
//
//  Created by Garrett Jester on 7/21/20.
//  Copyright © 2020 WRLDS. All rights reserved.
//

import UIKit

public typealias HeaderItem = CellConfigurator<HeaderCell, HeaderModel>

public struct HeaderModel {
    var title: String
    var subtitle: String?
    var condensed: Bool
    var alignment: NSTextAlignment
}


/// A static header cell containing a title and subtitle label.
public class HeaderCell: UICollectionViewCell, ConfigurableCell {

    public static let reuseID = "HeaderCell"
    
    public var titleLabel = UILabel(text: nil, font: UIFont.systemFont(ofSize: 23, weight: .bold), color: .primaryText, textAlignment: .center, numberOfLines: 1)
    
    public var subtitleLabel = UILabel(text: nil, font: UIFont.systemFont(ofSize: 14, weight: .regular), color: .secondaryText, textAlignment: .center, numberOfLines: 0)

    public override init(frame: CGRect) {
        super.init(frame: frame)
        layout()
    }
    
    
    private func layout() {
        addSubviews(titleLabel, subtitleLabel)
        backgroundColor = .backgroundGray
        
        titleLabel.anchor(topAnchor, left: leftAnchor, bottom: nil, right: rightAnchor, topConstant: 0, leftConstant: 30, bottomConstant: 20, rightConstant: 30, width: nil, widthConstant: 0, height: nil, heightConstant: 28, centerXInSuperView: true, centerYInSuperView: false)
        
        
        subtitleLabel.anchor(titleLabel.bottomAnchor, left: titleLabel.leftAnchor, bottom: nil, right: rightAnchor, topConstant: 8, leftConstant: 0, bottomConstant: 0, rightConstant: 30, width: nil, widthConstant: 0, height: nil, heightConstant: 40, centerXInSuperView: true, centerYInSuperView: false)
    }
    
    
    public func configure(model: HeaderModel) {
        format(condensed: model.condensed)
        titleLabel.text = model.title
        titleLabel.textAlignment = model.alignment
        subtitleLabel.textAlignment = model.alignment
        subtitleLabel.text = model.subtitle
        subtitleLabel.sizeToFit()
    }
    
    
    private func format(condensed: Bool) {
        titleLabel.font = condensed ? .headerTitleCondensed : .headerTitle
        subtitleLabel.font = condensed ? .headerSubtitleCondensed : .headerSubtitle
        subtitleLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 0).isActive = condensed
    }
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
