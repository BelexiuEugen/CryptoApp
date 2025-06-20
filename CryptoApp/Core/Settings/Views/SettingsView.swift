//
//  SettingsView.swift
//  CryptoApp
//
//  Created by Jan on 29/05/2025.
//

import SwiftUI

struct SettingsView: View {
    
    let defaultURL = URL(string: "https://www.google.com")!
    let youtubeURL = URL(string: "https://www.youtube.com/@SwiftfulThinking")!
    let coffeURL = URL(string: "https://buymeacoffee.com/nicksarno")!
    let coingGekoURL = URL(string: "https://www.coingecko.com")!
    let personalURL = URL(string: "https://github.com/BelexiuEugen")!
    
    var body: some View {
        NavigationStack{
            ZStack{
                
                Color.theme.background.ignoresSafeArea()
                
                List{
                    swiftulThinkingSection
                        .listRowBackground(Color.theme.background.opacity(0.5))
                    coinGekoSection
                        .listRowBackground(Color.theme.background.opacity(0.5))
                    developerSection
                        .listRowBackground(Color.theme.background.opacity(0.5))
                    applicationSection
                        .listRowBackground(Color.theme.background.opacity(0.5))
                }
            }
            .font(.headline)
            .tint(.blue)
            .listStyle(.grouped)
            .navigationTitle("Settings")
            .toolbar {
                ToolbarItem(placement: .topBarLeading) {
                    XMarkButton()
                }
            }
        }
    }
}

#Preview {
    SettingsView()
}

extension SettingsView{
    
    private var swiftulThinkingSection: some View{
            Section {
                VStack(alignment: .leading){
                    Image("logo")
                        .resizable()
                        .frame(width: 100, height: 100)
                        .clipShape(RoundedRectangle(cornerRadius: 20))
                    Text("This app was made by following a @Swiftull thinking tutorial")
                        .font(.callout)
                        .fontWeight(.medium)
                        .foregroundStyle(Color.theme.accent)
                    
                }
                .padding(.horizontal)
                
                Link("Subscribe on youtube", destination: youtubeURL)
                Link("Subscribe his coffe addiction", destination: coffeURL)
                
            } header: {
                Text("Swiftul Thinking")
            }
            .padding(.vertical)
    }
    
    private var coinGekoSection: some View{
            Section {
                VStack(alignment: .leading){
                    Image("coingecko")
                        .resizable()
                        .scaledToFit()
                        .frame(height: 100)
                        .clipShape(RoundedRectangle(cornerRadius: 20))
                    Text("The data that was used in this app was from this api")
                        .font(.callout)
                        .fontWeight(.medium)
                        .foregroundStyle(Color.theme.accent)
                    
                }
                .padding(.horizontal)
                
                Link("Visit Coin Gecko", destination: coingGekoURL)
            } header: {
                Text("Coin Geko")
            }
            .padding(.vertical)
    }
    
    private var developerSection: some View{
            Section {
                VStack(alignment: .leading){
                    Image("logo")
                        .resizable()
                        .frame(width: 100, height: 100)
                        .clipShape(RoundedRectangle(cornerRadius: 20))
                    Text("This app was developed by Belexiu Eugeniu, it used swiftUI. The projects benefits from multi-threading, publisher/subscribtion, and data persistance.")
                        .font(.callout)
                        .fontWeight(.medium)
                        .foregroundStyle(Color.theme.accent)
                    
                }
                .padding(.horizontal)
                
                Link("Visit Website", destination: personalURL)
            } header: {
                Text("Developer")
            }
            .padding(.vertical)
    }
    
    private var applicationSection: some View{
            Section {
                Link("Terms of service", destination: defaultURL)
                Link("Privacy Police", destination: defaultURL)
                Link("Company Website", destination: defaultURL)
                Link("Learn more", destination: defaultURL)
            } header: {
                Text("Application")
            }
            .padding(.vertical)
    }
}
