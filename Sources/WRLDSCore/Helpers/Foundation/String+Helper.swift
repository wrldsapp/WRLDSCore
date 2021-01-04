//
//  String+Extensions.swift
//  WRLDS
//
//  Created by Garrett Jester on 7/21/20.
//  Copyright © 2020 WRLDS. All rights reserved.
//

import UIKit

public extension String {
    
    var length: Int {
        return count
    }
    
    subscript (i: Int) -> String {
        return self[i ..< i + 1]
    }
    
    func substring(fromIndex: Int) -> String {
        return self[min(fromIndex, length) ..< length]
    }
    
    func substring(toIndex: Int) -> String {
        return self[0 ..< max(0, toIndex)]
    }
    
    subscript (r: Range<Int>) -> String {
        let range = Range(uncheckedBounds: (lower: max(0, min(length, r.lowerBound)),
                                            upper: min(length, max(0, r.upperBound))))
        let start = index(startIndex, offsetBy: range.lowerBound)
        let end = index(start, offsetBy: range.upperBound - range.lowerBound)
        return String(self[start ..< end])
    }
    

    func height(withConstrainedWidth width: CGFloat, font: UIFont) -> CGFloat {
        let constraintRect = CGSize(width: width, height: .greatestFiniteMagnitude)
        let boundingBox = self.boundingRect(with: constraintRect, options: .usesLineFragmentOrigin, attributes: [NSAttributedString.Key.font: font], context: nil)
        return ceil(boundingBox.height)
    }

    func width(withConstrainedHeight height: CGFloat, font: UIFont) -> CGFloat {
        let constraintRect = CGSize(width: .greatestFiniteMagnitude, height: height)
        let boundingBox = self.boundingRect(with: constraintRect, options: .usesLineFragmentOrigin, attributes: [NSAttributedString.Key.font: font], context: nil)
        return ceil(boundingBox.width)
    }
    
    func sizeOfString(usingFont font: UIFont) -> CGSize {
        let fontAttributes = [NSAttributedString.Key.font: font]
        return self.size(withAttributes: fontAttributes)
    }
    
    
    /// Adds highlighting for user handles and hashtags.
    func formattedString(string: String) {
        let s = string as NSString
        let attr = NSMutableAttributedString(string: s as String)
        let range = s.range(of: "@\\w.*?\\b", options: .regularExpression, range: NSMakeRange(0, s.length))
        if range.length > 0 {
            attr.addAttributes([NSAttributedString.Key.foregroundColor : UIColor.primaryText, NSAttributedString.Key.font: UIFont.systemFont(ofSize: 13, weight: .semibold)], range: range)
        }
        
    }
    
    var isValidUsernameCharacter: Bool {
        let characterSet = CharacterSet(charactersIn: "0123456ABCDEFGHIJKLMNOPQRSTUVWYXZabcdefghijklmnopqrstuvwxyz._").inverted
        let components = self.components(separatedBy: characterSet)
        let filtered = components.joined(separator: "")
        return self == filtered
    }
}




public extension NSMutableAttributedString {
    
    /// Adds underline formatting to terms within a string.
    /// - Parameter terms: the substrings to be underlined
    /// - Returns: the full string, with underlined terms
    
    func formatLinks(terms: [String], underlined: Bool, linkColor: UIColor, textSize: CGFloat) -> NSMutableAttributedString {
        for t in terms {
            guard let underlineRange = string.range(of: t) else {return NSMutableAttributedString()}
            let startPosition = string.distance(from: t.startIndex, to: underlineRange.lowerBound)
            let nsrange = NSRange(location: startPosition, length: t.count)
            addAttributes([NSMutableAttributedString.Key.foregroundColor: linkColor,
                           NSMutableAttributedString.Key.underlineColor: linkColor,
                           NSMutableAttributedString.Key.font: UIFont.systemFont(ofSize: textSize, weight: .semibold)], range: nsrange)
            
            if underlined {
                addAttribute(NSMutableAttributedString.Key.underlineStyle, value: NSUnderlineStyle.single.rawValue, range: nsrange)
                
            }
        }
        return self
    }
    
    func highlightRequirements(reqs: [Requirement]) -> NSMutableAttributedString {
        for r in reqs {
            guard let range = string.range(of: r.title) else { return NSMutableAttributedString()}
            let start = string.distance(from: r.title.startIndex, to: range.lowerBound)
            let nsrange = NSRange(location: start, length: r.title.count)
            addAttributes([
                NSMutableAttributedString.Key.foregroundColor: r.satisfied ? UIColor.secondaryText : UIColor.primaryText,
                ], range: nsrange
            )
        }
        return self
    }
    
    
    var fontSize:CGFloat { return 14 }
    var boldFont:UIFont { return UIFont(name: "AvenirNext-Bold", size: fontSize) ?? UIFont.boldSystemFont(ofSize: fontSize) }
    var normalFont:UIFont { return UIFont(name: "AvenirNext-Regular", size: fontSize) ?? UIFont.systemFont(ofSize: fontSize)}
    
    func bold(_ value:String) -> NSMutableAttributedString {
        
        let attributes:[NSAttributedString.Key : Any] = [
            .font : boldFont
        ]
        
        self.append(NSAttributedString(string: value, attributes:attributes))
        return self
    }
    
    func normal(_ value:String) -> NSMutableAttributedString {
        
        let attributes:[NSAttributedString.Key : Any] = [
            .font : normalFont,
        ]
        
        self.append(NSAttributedString(string: value, attributes:attributes))
        return self
    }
    /* Other styling methods */
    func orangeHighlight(_ value:String) -> NSMutableAttributedString {
        
        let attributes:[NSAttributedString.Key : Any] = [
            .font :  normalFont,
            .foregroundColor : UIColor.white,
            .backgroundColor : UIColor.orange
        ]
        
        self.append(NSAttributedString(string: value, attributes:attributes))
        return self
    }
    
    func blackHighlight(_ value:String) -> NSMutableAttributedString {
        
        let attributes:[NSAttributedString.Key : Any] = [
            .font :  normalFont,
            .foregroundColor : UIColor.white,
            .backgroundColor : UIColor.black
            
        ]
        
        self.append(NSAttributedString(string: value, attributes:attributes))
        return self
    }
    
    func underlined(_ value:String) -> NSMutableAttributedString {
        
        let attributes:[NSAttributedString.Key : Any] = [
            .font :  normalFont,
            .underlineStyle : NSUnderlineStyle.single.rawValue
            
        ]
        
        self.append(NSAttributedString(string: value, attributes:attributes))
        return self
    }
}

