//
//  HomeView.swift
//  CryptoApp
//
//  Created by Jan on 13/05/2025.
//

import SwiftUI

struct HomeView: View {
    
    @State private var showPortofolio: Bool = false;
    
    var body: some View {
        ZStack{
            Color.theme.background.ignoresSafeArea()
            
            VStack{
                homeHeader
                Spacer(minLength: 0)
            }
        }
    }
}

#Preview {
    NavigationStack{
        HomeView()
            .toolbarVisibility(.hidden)
    }
}

extension HomeView{
    
    private var homeHeader: some View{
        HStack{
            CircleButtonView(iconName: showPortofolio ? "plus" : "info")
                .animation(nil, value: showPortofolio)
                .background {
                    CircleButtonAnimationView(animated: $showPortofolio)
                }
            
            Spacer()
            
            Text(showPortofolio ? "Portofolio" : "Live Prices")
                .animation(nil, value: showPortofolio)
                .font(.headline)
                .fontWeight(.heavy)
                .foregroundStyle(Color.theme.accent)
            
            Spacer()
            
            CircleButtonView(iconName: "chevron.right")
                .rotationEffect(Angle(degrees: showPortofolio ? 180 : 0))
                .onTapGesture {
                    withAnimation(.spring()) {
                        showPortofolio.toggle()
                    }
                }
        }
        .padding(.horizontal)
    }
}
