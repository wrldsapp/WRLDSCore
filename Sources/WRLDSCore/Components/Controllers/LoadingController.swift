//
//  File.swift
//  
//
//  Created by Garrett Jester on 1/5/21.
//

import UIKit
import Lottie

public class LoadingController: UIViewController {
    
    var message: String?
    var animator: AnimationView!
    var container: UIView!
    
    public init() {
        super.init(nibName: nil, bundle: nil)
        self.modalPresentationStyle = .overFullScreen
        self.modalTransitionStyle = .coverVertical
    }
    

    public override func viewDidLoad() {
        super.viewDidLoad()
        self.animator = AnimationView(filePath: Bundle.module.path(forResource: "loader", ofType: "json")!)
        self.container = UIView(color: .containerBackground)
        self.view.addSubviews(container, animator)
        self.view.backgroundColor = .clear
        self.container.cornerRadius = 5
        
        container.anchor(nil, left: nil, bottom: nil, right: nil, topConstant: 0, leftConstant: 0, bottomConstant: 0, rightConstant: 0, width: nil, widthConstant: 75, height: nil, heightConstant: 75, centerXInSuperView: true, centerYInSuperView: true)
        
        animator.anchor(nil, left: nil, bottom: nil, right: nil, topConstant: 0, leftConstant: 0, bottomConstant: 0, rightConstant: 0, width: nil, widthConstant: 150, height: nil, heightConstant: 150, centerXInSuperView: true, centerYInSuperView: true)
        
        colorize()
    }
    
    
    public override func viewDidAppear(_ animated: Bool) {
        startAnimating()
    }
    
    
    func colorize() {
        let color = UIColor.dynamicColor(lightMode: .black, darkMode: .white).lottieColorValue
        let provider = ColorValueProvider(color)
        let keyPath = AnimationKeypath(keypath:"**.椭圆 1.填充 1.Color")
        animator.setValueProvider(provider, keypath: keyPath)
    }
    
    
    func startAnimating() {
        animator.animationSpeed = 1.5
        animator.play(fromProgress: 1, toProgress: 0, loopMode: .loop, completion: nil)
    }
    
    
    
    override public func dismiss(animated flag: Bool, completion: (() -> Void)? = nil) {
        self.animator.stop()
        super.dismiss(animated: true, completion: completion)
    }
    
   
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
