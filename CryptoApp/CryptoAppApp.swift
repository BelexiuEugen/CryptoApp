//
//  CryptoAppApp.swift
//  CryptoApp
//
//  Created by Jan on 13/05/2025.
//

import SwiftUI

@main
struct CryptoAppApp: App {
    
    init(){
        UINavigationBar.appearance().largeTitleTextAttributes = [.foregroundColor : UIColor(Color.theme.accent)]
        UINavigationBar.appearance().titleTextAttributes = [.foregroundColor : UIColor(Color.theme.accent)]
    }
    
    var body: some Scene {
        WindowGroup {
            NavigationStack{
                HomeView()
                    .toolbarVisibility(.hidden)
            }
            .environment(HomeViewModel())
        }
    }
}
