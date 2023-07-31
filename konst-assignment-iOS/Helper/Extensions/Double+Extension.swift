//
//  Double+Extension.swift
//  konst-assignment-iOS
//
//  Created by Rahul Tak on 30/07/23.
//

import Foundation

extension Double {
    
    var localCurrency: String {
        return getCurrency(self) //NSNumber(value: self).currency(for: Locale.current)
    }
}
