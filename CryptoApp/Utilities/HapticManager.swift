//
//  HapticManager.swift
//  CryptoApp
//
//  Created by Jan on 28/05/2025.
//

import SwiftUI


class HapticManager{
    
    static let generator = UINotificationFeedbackGenerator()
    
    static func notification(type: UINotificationFeedbackGenerator.FeedbackType){
        generator.notificationOccurred(type)
    }
    
}
