//
//  AlertController.swift
//  WRLDS
//
//  Created by Garrett Jester on 11/17/20.
//  Copyright © 2020 WRLDS. All rights reserved.
//

import UIKit

/// A custom alert
public class AlertController: UIViewController {

    public var alertTitle: String!
    public var subtitle: String?
    public var dismissTitle: String?
    
    lazy var titleLabel = UILabel(text: self.alertTitle, font: .systemFont(ofSize: 17, weight: .semibold), color: .primaryText, textAlignment: .center, numberOfLines: 1)
    
    lazy var subtitleLabel = UILabel(text: self.subtitle, font: .systemFont(ofSize: 14, weight: .regular), color: .secondaryText, textAlignment: .center, numberOfLines: 0)
    
    lazy var contentView: UIView = {
        let v = UIView(color: .containerBackground)
        v.cornerRadius = 10
        v.clipsToBounds = true
        v.translatesAutoresizingMaskIntoConstraints = false
        return v
    }()
    
    lazy var stackView: UIStackView = {
        let sv = UIStackView()
        sv.axis = .horizontal
        sv.addArrangedSubview(cancelButton)
        sv.distribution = .fillEqually
        return sv
    }()
    
    lazy var cancelButton = AlertButton(title: dismissTitle ?? "Cancel", style: .cancel)
    lazy var separator = UIView(color: .separator)
    lazy var ySeparator = UIView(color: .separator)
    
    public init(title: String, subtitle: String? = nil, dismissTitle: String? = nil) {
        super.init(nibName: nil, bundle: nil)
        self.alertTitle = title
        self.modalPresentationStyle = .overFullScreen
        self.modalTransitionStyle = .crossDissolve
        self.subtitle = subtitle
        layout()
    }


    private func layout() {
        self.view.addSubview(contentView)
        
        self.contentView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        self.contentView.widthAnchor.constraint(equalTo: self.view.widthAnchor, multiplier: 0.65).isActive = true
        self.contentView.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        self.contentView.addSubviews(titleLabel, stackView, separator, subtitleLabel)
        
        subtitleLabel.translatesAutoresizingMaskIntoConstraints = false
        subtitleLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 5).isActive = true
        subtitleLabel.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 30).isActive = true
        subtitleLabel.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: -30).isActive = true
        subtitleLabel.heightAnchor.constraint(greaterThanOrEqualToConstant: 15).isActive = true
        
        titleLabel.anchor(contentView.topAnchor, left: contentView.leftAnchor, bottom: nil, right: contentView.rightAnchor, topConstant: 15, leftConstant: 30, bottomConstant: 0, rightConstant: 30, width: nil, widthConstant: 0, height: nil, heightConstant: 40, centerXInSuperView: true, centerYInSuperView: false)
        
        separator.anchor(subtitleLabel.bottomAnchor, left: contentView.leftAnchor, bottom: nil, right: contentView.rightAnchor, topConstant: 20, leftConstant: 0, bottomConstant: 0, rightConstant: 0, width: nil, widthConstant: 0, height: nil, heightConstant: 0.5, centerXInSuperView: true, centerYInSuperView: false)
        
        stackView.anchor(separator.bottomAnchor, left: contentView.leftAnchor, bottom: contentView.bottomAnchor, right: contentView.rightAnchor, topConstant: 0, leftConstant: 0, bottomConstant: 0, rightConstant: 0, width: nil, widthConstant: 0, height: nil, heightConstant: 50, centerXInSuperView: true, centerYInSuperView: false)
        
        self.contentView.bottomAnchor.constraint(equalTo: cancelButton.bottomAnchor).isActive = true
        cancelButton.addTarget(self, action: #selector(cancelTapped), for: .touchUpInside)
    }
    
    
    @objc func cancelTapped() {
        dismiss(animated: true)
    }
    
    
    public func addButton(title: String, handler: @escaping ()->()) {
        let button = AlertButton(title: title, style: .confirm)
        button.addAction(action: handler)
        stackView.addArrangedSubview(button)
        self.contentView.addSubview(ySeparator)
        ySeparator.anchor(separator.bottomAnchor, left: nil, bottom: contentView.bottomAnchor, right: nil, topConstant: 0, leftConstant: 0, bottomConstant: 0, rightConstant: 0, width: nil, widthConstant: 0.5, height: nil, heightConstant: 0, centerXInSuperView: true, centerYInSuperView: false)
    }
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    public override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.black.withAlphaComponent(0.5)
        // Do any additional setup after loading the view.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}


class ClosureSleeve {
    let closure: () -> ()
    init(attachTo: AnyObject, closure: @escaping () -> ()) {
        self.closure = closure
        objc_setAssociatedObject(attachTo, "[\(arc4random())]", self, .OBJC_ASSOCIATION_RETAIN)
    }

    @objc func invoke() {
        closure()
    }
}

extension UIControl {
    func addAction(for controlEvents: UIControl.Event = .primaryActionTriggered, action: @escaping () -> ()) {
        let sleeve = ClosureSleeve(attachTo: self, closure: action)
        addTarget(sleeve, action: #selector(ClosureSleeve.invoke), for: controlEvents)
    }
}

