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
    @State private var showSettingsView: Bool = false;
    
    @State private var selectedCoin: CoinModel? = nil;
    @State private var showDetailView: Bool = false;
    
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
                    ZStack(alignment: .top){
                        if vm.portofolioCoins.isEmpty && vm.serachText.isEmpty{
                            portofolioEmptyText
                        } else{
                            portofolioCoinsList
                        }
                        portofolioCoinsList
                            .transition(.move(edge: .trailing))
                    }
                }
                
                Spacer(minLength: 0)
            }
            .sheet(isPresented: $showSettingsView) {
                SettingsView()
            }
        }
        .background(
            NavigationLink("", isActive: $showDetailView, destination: {
                DetailLoadingView(coin: $selectedCoin)
            })
        )
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
                    } else{
                        showSettingsView.toggle()
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
                    .onTapGesture {
                        seque(coin: coin)
                    }
                    .listRowBackground(Color.theme.background)
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
                    .onTapGesture {
                        seque(coin: coin)
                    }
                    .listRowBackground(Color.theme.background)
            }
        }
        .listStyle(.plain)
        .padding(.horizontal)
    }
    
    private var portofolioEmptyText: some View{
        Text("You haven't added any coins to your portofolio yet, click the plus button to get started")
            .font(.callout)
            .foregroundStyle(Color.theme.accent)
            .fontWeight(.medium)
            .multilineTextAlignment(.center)
            .padding()
    }
    
    private func seque(coin: CoinModel){
        selectedCoin = coin
        showDetailView.toggle()
    }
    
    private var columnTitle: some View{
        HStack{
            HStack(spacing: 4){
                Text("Coin")
                Image(systemName: "chevron.down")
                    .opacity((vm.sortOption == .rank || vm.sortOption == .rankReverse) ? 1.0 : 0.0)
                    .rotationEffect(Angle(degrees: vm.sortOption == .rank ? 0 : 180))
            }
            .onTapGesture {
                withAnimation(.default) {
                    vm.sortOption = vm.sortOption == .rank ? .rankReverse : .rank
                }
            }
            Spacer()
            if showPortofolio{
                HStack(spacing: 4){
                    Text("Holdings")
                    Image(systemName: "chevron.down")
                        .opacity((vm.sortOption == .holdings || vm.sortOption == .holdingReverse) ? 1.0 : 0.0)
                        .rotationEffect(Angle(degrees: vm.sortOption == .holdings ? 0 : 180))
                }
                .onTapGesture {
                    withAnimation(.default) {
                        vm.sortOption = vm.sortOption == .holdings  ? .holdingReverse : .holdings
                    }
                }
            }
            
            HStack(spacing: 4){
                Text("Price")
                    .frame(width: UIScreen.main.bounds.width / 3.5, alignment: .trailing)
                Image(systemName: "chevron.down")
                    .opacity((vm.sortOption == .price || vm.sortOption == .priceReverse) ? 1.0 : 0.0)
                    .rotationEffect(Angle(degrees: vm.sortOption == .price ? 0 : 180))
            }
            .onTapGesture {
                withAnimation(.default) {
                    vm.sortOption = vm.sortOption == .price  ? .priceReverse : .price
                }
            }
            
            Button {
                withAnimation(.linear(duration: 2.0)) {
                    vm.reloadData()
                }
            } label: {
                Image(systemName: "goforward")
            }
            .rotationEffect(Angle(degrees: vm.isLoading ? 360 : 0), anchor: .center)

        }
        .font(.caption)
        .foregroundStyle(Color.theme.secondaryText)
        .padding(.horizontal)
    }
}
