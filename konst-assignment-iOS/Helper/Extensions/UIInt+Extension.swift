//
//  UIInt+Extension.swift
//  konst-assignment-iOS
//
//  Created by Rahul Tak on 29/07/23.
//

import Foundation
extension Int {
    
    var localCurrency: String {
        return getCurrency(self) //NSNumber(value: self).currency(for: Locale.current)
    }
}
