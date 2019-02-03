//
//  Float+Formatter.swift
//  FintechDemo
//
//  Created by Eduardo Nieto on 03/02/2019.
//  Copyright © 2019 Eduardo Nieto. All rights reserved.
//

import Foundation
extension Float {
    
    func formatNumber() -> String? {
        let currencyFormatter = NumberFormatter()
        currencyFormatter.usesGroupingSeparator = true
        currencyFormatter.numberStyle = .decimal
        let number = NSNumber(value: self)
        
        currencyFormatter.decimalSeparator = ","
        currencyFormatter.groupingSeparator = "."
        currencyFormatter.maximumFractionDigits = 2
        
        currencyFormatter.locale = NSLocale.current
        
        let priceString = currencyFormatter.string(from: number)
        
        return priceString
    }
}
