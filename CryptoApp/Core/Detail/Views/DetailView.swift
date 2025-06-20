//
//  DetailView.swift
//  CryptoApp
//
//  Created by Jan on 28/05/2025.
//

import SwiftUI

struct DetailLoadingView: View{
    
    @Binding var coin: CoinModel?
    
    var body: some View {
        ZStack{
            if let coin = coin{
                DetailView(coin: coin)
            }
        }
    }
}

struct DetailView: View {
    
    @State var vm: DetailViewModel
    @State private var showFullDescription: Bool = false;
    
    let coin: CoinModel
    
    private let column: [GridItem] = [
        GridItem(.flexible()),
        GridItem(.flexible())
    ]
    
    private let spacing: CGFloat = 30
    
    init(coin: CoinModel){
        self.coin = coin
        _vm = State(wrappedValue: DetailViewModel(coin: coin))
        print("Initializing Detail View for \(coin.name)")
    }
    
    var body: some View {
        ScrollView {
            VStack{
                
                ChartView(coin: vm.coin)
                    .padding(.vertical)
                
                VStack(spacing: 20){
                    overViewTitle
                    Divider()
                    
                    descriptionSection
                    
                    overviewGrid
                    additionalTitle
                    Divider()
                    additionalGrid
                    
                    websiteSection
                }
                .padding()
            }
        }
        .background(Color.theme.background.ignoresSafeArea())
        .navigationTitle(vm.coin.name)
        .toolbar {
            ToolbarItem(placement: .topBarTrailing) {
                navigationBarTrailingAction
            }
        }
    }
}

#Preview {
    NavigationStack{
        DetailView(coin: DeveloperPreview.instance.coin)
    }
}

extension DetailView{
    
    private var navigationBarTrailingAction: some View{
        HStack {
            Text(vm.coin.symbol.uppercased())
                .font(.headline)
                .foregroundStyle(Color.theme.secondaryText)
            CoinImageView(coin: vm.coin)
                .frame(width: 25, height: 25)
        }
    }
    
    private var overViewTitle: some View{
        Text("Overview")
            .font(.title)
            .bold()
            .foregroundStyle(Color.theme.accent)
            .frame(maxWidth: .infinity, alignment: .leading)
    }
    
    private var additionalTitle: some View{
        Text("Additional Details")
            .font(.title)
            .bold()
            .foregroundStyle(Color.theme.accent)
            .frame(maxWidth: .infinity, alignment: .leading)
    }
    
    private var descriptionSection: some View{
        ZStack{
            if let coinDescription = vm.coinDescription, !coinDescription.isEmpty{
                VStack(alignment: .leading){
                    Text(coinDescription)
                        .lineLimit(showFullDescription ? nil : 3)
                        .font(.callout)
                        .foregroundStyle(Color.theme.secondaryText)
                }
                Button {
                    withAnimation(.easeInOut) {
                        showFullDescription.toggle()
                    }
                } label: {
                    Text(showFullDescription ? "Less" : "Read more...")
                        .font(.caption)
                        .fontWeight(.bold)
                        .padding(.vertical, 4)
                }
                .tint(.blue)
                .frame(maxWidth: .infinity, alignment: .leading)

            }
        }
    }
    
    private var overviewGrid: some View{
        LazyVGrid(columns: column, alignment: .leading, spacing: spacing) {
            ForEach(vm.overviewStatistic){ stat in
                StatisticView(stat: stat)
            }
        }
    }
    
    private var additionalGrid: some View{
        LazyVGrid(columns: column, alignment: .leading, spacing: spacing) {
            ForEach(vm.additionalStatistic){ stat in
                StatisticView(stat: stat)
            }
        }
    }
    
    private var websiteSection: some View{
        VStack(alignment: .leading, spacing: 20){
            if let websiteString = vm.websiteURL,
               let url = URL(string: websiteString){
                Link("website", destination: url)
            }
            
            if let redditString = vm.redditURL,
               let url = URL(string: redditString){
                Link("Reddit", destination: url)
            }
        }
        .tint(.blue)
        .frame(maxWidth: .infinity, alignment: .leading)
        .font(.headline)
    }
}
