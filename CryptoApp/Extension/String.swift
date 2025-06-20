//
//  String.swift
//  CryptoApp
//
//  Created by Jan on 29/05/2025.
//

import Foundation

extension String{
    
    var removingHTMLOccurance: String{
        return self.replacingOccurrences(of: "<[^>]+>", with: "", options: .regularExpression, range: nil)
    }
}
