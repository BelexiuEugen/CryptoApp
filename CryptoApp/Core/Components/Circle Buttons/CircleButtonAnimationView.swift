//
//  CircleButtonAnimationView.swift
//  CryptoApp
//
//  Created by Jan on 13/05/2025.
//

import SwiftUI

struct CircleButtonAnimationView: View {
    
    @Binding var animated: Bool;
    
    var body: some View {
        Circle()
            .stroke(lineWidth: 5.0)
            .scale(animated ? 1.0 : 0)
            .opacity(animated ? 0 : 1)
            .animation(animated ? Animation.easeOut(duration: 1.0) : .none , value: animated)
            .onAppear{
                animated.toggle()
            }
            .onTapGesture {
                animated.toggle()
            }
        
    }
}

#Preview {
    CircleButtonAnimationView(animated: .constant(false))
        .foregroundStyle(.red )
        .frame(width: 100, height: 100)
}
