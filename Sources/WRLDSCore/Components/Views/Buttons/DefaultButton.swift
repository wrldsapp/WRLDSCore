//
//  DefaultButton.swift
//  WRLDS
//
//  Created by Garrett Jester on 7/24/20.
//  Copyright © 2020 WRLDS. All rights reserved.
//

import UIKit

public class DefaultButton: UIButton{
 
    var originalButtonText: String?
    var activityIndicator: UIActivityIndicatorView!
    
    public init() {
        super.init(frame: CGRect.zero)
        setupButton()
    }
    
    
    private func setupButton() {
        setTitleColor(.white, for: .normal)
        layer.cornerRadius = 4
        layer.masksToBounds = true
        titleLabel?.font = UIFont.systemFont(ofSize: 14, weight: .semibold)
        isUserInteractionEnabled = true
        isEnabled = true
    }
    
    public override func didMoveToWindow() {
        if self.window != nil {
              NotificationCenter.default.addObserver(self, selector: #selector(startLoading), name: .processStarted, object: nil)
              NotificationCenter.default.addObserver(self, selector: #selector(stopLoading), name: .processFinished, object: nil)
        }
    }
    
    public override func willMove(toWindow newWindow: UIWindow?) {
        if self.window == nil {
            NotificationCenter.default.removeObserver(self, name: .processStarted, object: nil)
            NotificationCenter.default.removeObserver(self, name: .processFinished, object: nil)
        }
    }
  
    
    /// Displays animated activity indicator inside button.
    @objc func startLoading() {
        self.isUserInteractionEnabled = false
        originalButtonText = self.titleLabel?.text
        self.setTitle("", for: .normal)
        
        if activityIndicator == nil {
            activityIndicator = newActivityIndicator()
        }
        showSpinning()
    }
    
    
    
    /// Stops the activity indicator and redisplays button text.
    @objc func stopLoading() {
        guard activityIndicator != nil else {return}
        self.isUserInteractionEnabled = true
        setTitle(originalButtonText, for: .normal)
        activityIndicator.stopAnimating()
    }
    
    
    
    private func newActivityIndicator() -> UIActivityIndicatorView {
        let av = UIActivityIndicatorView()
        av.hidesWhenStopped = true
        av.color = .white
        return av
    }
    
    
    private func showSpinning() {
        activityIndicator.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(activityIndicator)
        activityIndicator.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
        activityIndicator.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        activityIndicator.startAnimating()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    public override var isEnabled: Bool {
        didSet {
            backgroundColor = isEnabled ? .wrldsBlue : .disabledButton
            setTitleColor(isEnabled ? .white : .disabledButtonText, for: .normal)
        }
    }
    
    
    public override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesBegan(touches, with: event)
        self.alpha = 0.7
    }
    
    public override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesEnded(touches, with: event)
        self.alpha = 1.0
    }
    
    
    deinit {
        print("DEINITING BUTTON")
        NotificationCenter.default.removeObserver(self, name: .processStarted, object: nil)
        NotificationCenter.default.removeObserver(self, name: .processFinished, object: nil)
    }
}



