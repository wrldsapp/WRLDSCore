//
//  Slider.swift
//  WRLDS
//
//  Created by Garrett Jester on 7/27/20.
//  Copyright © 2020 WRLDS. All rights reserved.
//

import UIKit

class Slider: UIView {
    
    var indicator: UIView!
    var count: CGFloat!
    
    lazy var separator: UIView = {
        let v = UIView(color: .separator)
        return v
    }()
    
    init(tabCount: Int, frame: CGRect) {
        super.init(frame: frame)
        self.count = CGFloat(tabCount)
        layout()
    }

    
    private func layout() {
        addSubviews(separator)
        addIndicator()
        separator.anchor(nil, left: leftAnchor, bottom: bottomAnchor, right: rightAnchor, topConstant: 0, leftConstant: 0, bottomConstant: 0, rightConstant: 0, width: nil, widthConstant: 0, height: nil, heightConstant: 0.5, centerXInSuperView: true, centerYInSuperView: false)
    }
    
    
    /// Creates the indicator for the slider and adds it to the view.
    private func addIndicator() {
        print("TABCOUNT \(count)")
      
        indicator = UIView(frame: CGRect(x: 0, y: self.frame.height - 2, width: (self.frame.width/count)/2, height: 2))
        addSubview(indicator)
        indicator.backgroundColor = .primaryText
        indicator.center.x = (frame.width/count)/2
    }
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
