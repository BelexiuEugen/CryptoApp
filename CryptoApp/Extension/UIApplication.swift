//
//  UIApplication.swift
//  CryptoApp
//
//  Created by Jan on 19/05/2025.
//

import SwiftUI

extension UIApplication{
    
    func endEditing(){
        sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
    }
}
