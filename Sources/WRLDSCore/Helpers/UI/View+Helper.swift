//
//  UIView+Anchors.swift
//  WRLDS
//
//  Created by Garrett Jester on 1/04/21.
//  Copyright © 2020 WRLDS. All rights reserved.
//

@_exported import UIKit

extension UIView {

    convenience init(color: UIColor) {
        self.init(frame: .zero)
        self.backgroundColor = color
    }
    
    /// Make the view circular.
    func roundCircular() {
        self.clipsToBounds = true
        self.layer.cornerRadius = self.frame.width/2
    }

    
    func roundSmoothEdges(height: CGFloat) {
        self.clipsToBounds = true
        self.layer.cornerRadius = height/2
    }

    
    /// Add multiple subviews to the view.
    /// - Parameter views: The subviews to be added.
    func addSubviews(_ views: UIView...) {
        views.forEach { addSubview($0) }
    }

    /// Sets the corner radius of the view's layer.
    var cornerRadius: CGFloat {
        get { return layer.cornerRadius }
        set { layer.cornerRadius = newValue }
     }
    
    
    func fadeIn(duration: TimeInterval = 2.0, delay: TimeInterval = 0.0, completion: @escaping ((Bool) -> Void) = {(finished: Bool) -> Void in}) {
        UIView.animate(withDuration: duration, delay: delay, options: .curveEaseIn, animations: {
            self.alpha = 1.0
        }, completion: completion)
    }
    
    
    func fadeOut(duration: TimeInterval = 1.0, delay: TimeInterval = 3.0, completion: @escaping (Bool) -> Void = {(finished: Bool) -> Void in}) {
        UIView.animate(withDuration: duration, delay: delay, options: .curveEaseIn, animations: {
            self.alpha = 0.0
        }, completion: completion)
    }
    
    // MARK: -- AUTOLAYOUT HELPERS --
    
    /// Pins the view to the superview's edges.
    public func fillSuperview() {
        translatesAutoresizingMaskIntoConstraints = false
        if let superview = superview {
            leftAnchor.constraint(equalTo: superview.leftAnchor).isActive = true
            rightAnchor.constraint(equalTo: superview.rightAnchor).isActive = true
            topAnchor.constraint(equalTo: superview.topAnchor).isActive = true
            bottomAnchor.constraint(equalTo: superview.bottomAnchor).isActive = true
        }
    }

    
    /// Configures auto-layout constraints to a view. Useful for static UI configuration.
    ///
    /// - Parameters:
    ///   - top: The top anchor to bind to
    ///   - left: The left anchor to bind to
    ///   - bottom: The bottom anchor to bind to
    ///   - right: The right anchor to bind to
    ///   - topConstant: The offset from the top anchor
    ///   - leftConstant: The offset from the left anchor
    ///   - bottomConstant: The offset from the bottom anchor
    ///   - rightConstant: The offset from the view's right anchor
    ///   - width: The width anchor to bind to (nil if setting constant)
    ///   - widthConstant: The offset from the view's width anchor. If width anchor is nil,
    ///      this is the fixed width of the view.
    ///   - height: The height anchor to bind to
    ///   - heightConstant: The offset from the view's height anchor. If height anchor is nil,
    ///     this is the fixed height of the view
    ///   - centerXInSuperView: Should the view be horizontally centered?
    ///   - centerYInSuperView: Should the view be vertically centered?
    
    public func anchor(_ top: NSLayoutYAxisAnchor? = nil, left: NSLayoutXAxisAnchor? = nil, bottom: NSLayoutYAxisAnchor? = nil, right: NSLayoutXAxisAnchor? = nil, topConstant: CGFloat = 0,
                       leftConstant: CGFloat = 0, bottomConstant: CGFloat = 0, rightConstant: CGFloat = 0, width: NSLayoutAnchor<NSLayoutDimension>? = nil,
                       widthConstant: CGFloat = 0, height: NSLayoutAnchor<NSLayoutDimension>? = nil,
                       heightConstant: CGFloat = 0, centerXInSuperView: Bool = false, centerYInSuperView: Bool = false) {
        translatesAutoresizingMaskIntoConstraints = false
        
        _ = anchorWithReturnAnchors(top, left: left, bottom: bottom, right: right, topConstant: topConstant, leftConstant: leftConstant,
                                    bottomConstant: bottomConstant, rightConstant: rightConstant,height: height,width: width, widthConstant: widthConstant, heightConstant: heightConstant)
        if centerXInSuperView {
            anchorCenterXToSuperview()
        }
        if centerYInSuperView {
            anchorCenterYToSuperview()
        }
    }
    
    
    
    
    
    /// Generates constraints for the view and returns the array of constraints. Useful if the view's constraints
    /// need to be accessed after being set (ex. dynamic layouts).
    ///
    /// - Parameters:
    ///   - top: The top anchor to bind to
    ///   - left: The left anchor to bind to
    ///   - bottom: The bottom anchor to bind to
    ///   - right: The right anchor to bind to
    ///   - topConstant: The offset from the top anchor
    ///   - leftConstant: The offset from the left anchor
    ///   - bottomConstant: The offset from the bottom anchor
    ///   - rightConstant: The offset from the view's right anchor
    ///   - width: The width anchor to bind to (nil if setting constant)
    ///   - widthConstant: The offset from the view's width anchor. If width anchor is nil,
    ///      this is the fixed width of the view.
    ///   - height: The height anchor to bind to
    ///   - heightConstant: The offset from the view's height anchor. If height anchor is nil,
    ///     this is the fixed height of the view
    ///
    /// - Returns: The configured constraints for the view.
    
    public func anchorWithReturnAnchors(_ top: NSLayoutYAxisAnchor? = nil, left: NSLayoutXAxisAnchor? = nil, bottom: NSLayoutYAxisAnchor? = nil,
                                        right: NSLayoutXAxisAnchor? = nil, topConstant: CGFloat = 0, leftConstant: CGFloat = 0, bottomConstant: CGFloat = 0, rightConstant: CGFloat = 0,  height: NSLayoutAnchor<NSLayoutDimension>? = nil, width: NSLayoutAnchor<NSLayoutDimension>? = nil,
                                        widthConstant: CGFloat = 0, heightConstant: CGFloat = 0) -> [NSLayoutConstraint] {
        translatesAutoresizingMaskIntoConstraints = false
        
        var anchors = [NSLayoutConstraint]()
        
        if let top = top {
            anchors.append(topAnchor.constraint(equalTo: top, constant: topConstant))
        }
        
        if let left = left {
            anchors.append(leftAnchor.constraint(equalTo: left, constant: leftConstant))
        }
        
        if let bottom = bottom {
            anchors.append(bottomAnchor.constraint(equalTo: bottom, constant: -bottomConstant))
        }
        
        if let right = right {
            anchors.append(rightAnchor.constraint(equalTo: right, constant: -rightConstant))
        }
        
        if let height = height {
            anchors.append(heightAnchor.constraint(equalTo: height, constant: heightConstant))
        } else {
            if heightConstant > 0 {
                anchors.append(heightAnchor.constraint(equalToConstant: heightConstant))
            }
        }
        
        if let width = width {
            anchors.append(widthAnchor.constraint(equalTo: width, constant: widthConstant))
        } else {
            if widthConstant > 0 {
                anchors.append(widthAnchor.constraint(equalToConstant: widthConstant))
            }
        }
        anchors.forEach({$0.isActive = true})
        
        return anchors
    }
    
    
    

    public func anchorCenterXToSuperview(constant: CGFloat = 0) {
        translatesAutoresizingMaskIntoConstraints = false
        if let anchor = superview?.centerXAnchor {
            centerXAnchor.constraint(equalTo: anchor, constant: constant).isActive = true
        }
    }
    
    
    
    public func anchorCenterYToSuperview(constant: CGFloat = 0) {
        translatesAutoresizingMaskIntoConstraints = false
        if let anchor = superview?.centerYAnchor {
            centerYAnchor.constraint(equalTo: anchor, constant: constant).isActive = true
        }
    }
    
    public func anchorCenterSuperview(constantX: CGFloat = 0, constantY: CGFloat = 0) {
        anchorCenterXToSuperview(constant: constantX)
        anchorCenterYToSuperview(constant: constantY)
    }
    
    
    
    /// Adds auto-layout constraints with the provided visual formatting string.
    /// - Parameters:
    ///   - format: String written in visual format.
    ///   - views: The views to be constrained. Should be referenced by
    ///   index in format string (i.e. 'v2' for third view).
    ///
    public func addContraintsWithFormat(_ format: String, views: UIView...) {
        var viewDict = [String: UIView]()
        
        for (index, view) in views.enumerated() {
            let key = "v\(index)"
            view.translatesAutoresizingMaskIntoConstraints = false
            viewDict[key] = view
        }
        addConstraints(NSLayoutConstraint.constraints(withVisualFormat: format, options: NSLayoutConstraint.FormatOptions(rawValue: 0), metrics: nil, views: viewDict))
    }
    
    
    
}
