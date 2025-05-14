//
//  Double.swift
//  CryptoApp
//
//  Created by Jan on 14/05/2025.
//

import Foundation

extension Double{
    
    /// convert a Double into a currency with 2-6 deciaml places
    ///```
    /// There is my awsome documentation that i can furthure use
    ///```
    
    private var currencyFormatter2: NumberFormatter{
        let formatter = NumberFormatter()
        formatter.usesGroupingSeparator = true
        formatter.numberStyle = .currency
        formatter.locale = .current // <- Default value
        formatter.currencyCode = "usd" // <- Currency
        formatter.currencySymbol = "$" // <- symbol
        formatter.minimumFractionDigits = 2
        formatter.maximumFractionDigits = 2
        return formatter
    }
    
    /// convert double into currency as a string with 2-6 deciaml place
    /// ```
    ///convert double into currency as a string with 2-6 deciaml place
    ///
    
    func asCurrencyWith2Decimals() -> String{
        
        let number = NSNumber(value: self)
        
        return currencyFormatter2.string(from: number) ?? "$0.00"
    }
    
    /// convert a Double into a currency with 2-6 deciaml places
    ///```
    /// There is my awsome documentation that i can furthure use
    ///```
    
    private var currencyFormatter6: NumberFormatter{
        let formatter = NumberFormatter()
        formatter.usesGroupingSeparator = true
        formatter.numberStyle = .currency
        formatter.locale = .current // <- Default value
        formatter.currencyCode = "usd" // <- Currency
        formatter.currencySymbol = "$" // <- symbol
        formatter.minimumFractionDigits = 2
        formatter.maximumFractionDigits = 6
        return formatter
    }
    
    /// convert double into currency as a string with 2-6 deciaml place
    /// ```
    ///convert double into currency as a string with 2-6 deciaml place
    ///
    
    func asCurrencyWith6Decimals() -> String{
        
        let number = NSNumber(value: self)
        
        return currencyFormatter6.string(from: number) ?? "$0.00"
    }
    
    ///```
    ///convert 1.2345 to "1.23"
    ///```
    
    func asNumberString() -> String{
        return String(format: "%.2f", self)
    }
    
    func asPercentString() -> String{
        return asNumberString() + "%"
    }
}
