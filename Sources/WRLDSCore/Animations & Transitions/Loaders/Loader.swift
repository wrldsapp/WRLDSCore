//
//  Loader.swift
//  WRLDS
//
//  Created by Garrett Jester on 11/5/20.
//  Copyright © 2020 WRLDS. All rights reserved.
//

import Foundation
import Lottie
import UIKit

public class Loader: UIView {
    
    var message: String?
    var animator: AnimationView!
    
    public init(parent: UIView, message: String? = nil) {
        super.init(frame: CGRect.zero)
        self.animator = AnimationView(name: "loader")
        animator.animationSpeed = 1.5
        animator.loopMode = .loop
        configure(parent: parent)
    }
    
    
    private func configure(parent: UIView) {
        parent.addSubview(self)

        self.anchor(nil, left: parent.leftAnchor, bottom: parent.centerYAnchor, right: nil, topConstant: 0, leftConstant: 0, bottomConstant: 10, rightConstant: 0, width: nil, widthConstant: 150, height: nil, heightConstant: 150, centerXInSuperView: true, centerYInSuperView: false)
        addSubview(animator)
        animator.anchor(nil, left: nil, bottom: nil, right: nil, topConstant: 0, leftConstant: 0, bottomConstant: 0, rightConstant: 0, width: nil, widthConstant: 150, height: nil, heightConstant: 150, centerXInSuperView: true, centerYInSuperView: true)
        
        colorize()
    }
    
    
    func colorize() {
        let color = UIColor.dynamicColor(lightMode: .black, darkMode: .white).lottieColorValue
        let provider = ColorValueProvider(color)
        let keyPath = AnimationKeypath(keypath:"**.椭圆 1.填充 1.Color")
        animator.setValueProvider(provider, keypath: keyPath)
    }
    
    
    func startAnimating() {
        animator.play(fromProgress: 1, toProgress: 0, loopMode: .loop, completion: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

