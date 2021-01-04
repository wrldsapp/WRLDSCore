//
//  AttributedLabel.swift
//  WRLDS
//
//  Created by Garrett Jester on 7/23/20.
//  Copyright © 2020 WRLDS. All rights reserved.
//

import UIKit


public protocol AttributedLabelDelegate {
    func didSelect(term: String)
}


public class AttributedLabel: UILabel {

    var delegate: AttributedLabelDelegate?
    var termRanges: [String: NSRange]?
    
    public init() {
        super.init(frame: CGRect.zero)
        configureTap()
    }
    
    // Add tap gesture to label.
    private func configureTap() {
        isUserInteractionEnabled = true
        lineBreakMode = .byWordWrapping
        let tap = UITapGestureRecognizer(target: self, action: #selector(labelTapped(_:)))
        addGestureRecognizer(tap)
    }
    
    
    // Format the linked text.
    func addLinkedText(color: UIColor, underline: Bool, terms: [String]) {
        guard let text = text else {return}
        updateTermStore(terms: terms)
        let nsmas = NSMutableAttributedString(string: text).formatLinks(terms: terms, underlined: underline, linkColor: color, textSize: self.font.pointSize)
        self.attributedText = nsmas
    }
    
    
    func highlightRequirements(reqs: [Requirement]) {
        guard let text = text else {return}
        let nsmas = NSMutableAttributedString(string: text).highlightRequirements(reqs: reqs)
        self.attributedText = nsmas
    }
    
    
    // Respond to tap events and route taps on linked text.
    @objc func labelTapped(_ sender: UITapGestureRecognizer) {
        guard let dict = termRanges else {return}
        print("Label tapped!")
        for (term, range) in dict {
            if sender.didTapAttributedTextInLabel(label: self, inRange: range) {
                delegate?.didSelect(term: term)
            }
        }
    }
    
    
    private func updateTermStore(terms: [String]) {
        var dict = [String:NSRange]()
        let stringText = text! as NSString
        for t in terms {
            dict[t] = stringText.range(of: t)
        }
        self.termRanges = dict
    }
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
