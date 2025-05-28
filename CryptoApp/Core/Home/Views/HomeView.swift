//
//  HomeView.swift
//  CryptoApp
//
//  Created by Jan on 13/05/2025.
//

import SwiftUI

// https://api.coingecko.com/api/v3/global

struct HomeView: View {
    
    @Environment(HomeViewModel.self) private var vm: HomeViewModel
    @State private var showPortofolio: Bool = false; // animate right
    @State private var showPortofolioView: Bool = false; // newSheet
    
    var body: some View {
        
        @Bindable var vm = vm;
        
        ZStack{
            Color.theme.background.ignoresSafeArea()
                .sheet(isPresented: $showPortofolioView) {
                    PortofolioView()
                        .environment(vm)
                }
            
            VStack{
                homeHeader
                
                HomeStatsView(showPortofolio: $showPortofolio)
                
                SearchBarView(serachText: $vm.serachText)
                
                columnTitle
                
                if !showPortofolio{
                    allCoinsList
                    .transition(.move(edge: .leading))
                }
                
                if showPortofolio{
                    portofolioCoinsList
                        .transition(.move(edge: .trailing))
                }
                
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
    .environment(DeveloperPreview.instance.homeVM)
}

extension HomeView{
    
    private var homeHeader: some View{
        HStack{
            CircleButtonView(iconName: showPortofolio ? "plus" : "info")
                .animation(nil, value: showPortofolio)
                .onTapGesture {
                    if showPortofolio{
                        showPortofolioView.toggle()
                    }
                }
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
    
    private var allCoinsList: some View{
        List{
            ForEach(vm.allCoins){ coin in
                CoinRowView(coin: coin, showHoldingsColumn: false)
                    .listRowInsets(.init(top: 10, leading: 0, bottom: 10, trailing: 0))
            }
        }
        .listStyle(.plain)
        .padding(.horizontal)
    }
    
    private var portofolioCoinsList: some View{
        List{
            ForEach(vm.portofolioCoins){ coin in
                CoinRowView(coin: coin, showHoldingsColumn: true)
                    .listRowInsets(.init(top: 10, leading: 0, bottom: 10, trailing: 0))
            }
        }
        .listStyle(.plain)
        .padding(.horizontal)
    }
    
    private var columnTitle: some View{
        HStack{
            Text("Coin")
            Spacer()
            if showPortofolio{
                Text("Holdings")
            }
            Text("Price")
                .frame(width: UIScreen.main.bounds.width / 3.5, alignment: .trailing)
        }
        .font(.caption)
        .foregroundStyle(Color.theme.secondaryText)
        .padding(.horizontal)
    }
}
