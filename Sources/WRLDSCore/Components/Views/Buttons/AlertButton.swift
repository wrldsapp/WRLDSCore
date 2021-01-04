//
//  AlertButton.swift
//  WRLDS
//
//  Created by Garrett Jester on 11/17/20.
//  Copyright © 2020 WRLDS. All rights reserved.
//

import UIKit

public class AlertButton: UIButton {
    
    var title: String!
    var style: AlertButtonStyle!
    
    public override var isHighlighted: Bool {
        didSet {
            backgroundColor = isHighlighted ? .selectedCellBackground : .containerBackground
        }
    }
    
    public init(title: String, style: AlertButtonStyle) {
        super.init(frame: CGRect.zero)
        self.title = title
        self.style = style
        layout()
    }
    
    private func layout() {
        self.setTitle(title, for: .normal)
        self.setTitleColor(style == .cancel ? .secondaryText : .primaryText, for: .normal)
        self.titleLabel?.font = .systemFont(ofSize: 14, weight: style == .cancel ? .regular : .semibold)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }


    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */

}


public enum AlertButtonStyle {
    case cancel
    case confirm
}
