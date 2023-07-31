//
//  UILabel+Extension.swift
//  konst-assignment-iOS
//
//  Created by Rahul Tak on 30/07/23.
//

import UIKit

extension UILabel {
    func setSubTextColor(pSubString : String, pColor : UIColor, isStrike: Bool = true){
        let attributedString: NSMutableAttributedString = self.attributedText != nil ? NSMutableAttributedString(attributedString: self.attributedText!) : NSMutableAttributedString(string: self.text!);
        
        let range = attributedString.mutableString.range(of: pSubString, options:NSString.CompareOptions.caseInsensitive)
        var attributes: [NSAttributedString.Key : Any] = [NSAttributedString.Key.foregroundColor: pColor]
        if isStrike {
            attributes = [ NSAttributedString.Key.foregroundColor: pColor,
                           NSAttributedString.Key.strikethroughStyle: NSUnderlineStyle.single.rawValue]
        }
        if range.location != NSNotFound {
            attributedString.addAttributes(attributes, range: range)
        }
        self.attributedText = attributedString
    }
    
}
