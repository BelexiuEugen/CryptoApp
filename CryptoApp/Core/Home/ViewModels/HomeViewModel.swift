//
//  HomeViewModel.swift
//  CryptoApp
//
//  Created by Jan on 14/05/2025.
//

import Foundation
import Combine

@Observable
class HomeViewModel{
    
    var statistics: [StatisticModel] = []
    
    @ObservationIgnored
    @Published var allCoins: [CoinModel] = []
    var portofolioCoins: [CoinModel] = []
    
    @ObservationIgnored
    @Published var serachText: String = ""
    
    private let coinDataService = CoinDataService()
    private let marketDataService = MarketDataService()
    private let portofolioDataService = PortofolioDataService()
    
    private var cancellables = Set<AnyCancellable>()
    
    init(){
        addSubscribers()
    }
    
    func addSubscribers(){
        
        //update allCoins.
        $serachText
            .combineLatest(coinDataService.$allCoins)
            .debounce(for: .seconds(0.5) , scheduler: DispatchQueue.main)
            .map(filterCoins)
            .sink { [weak self] returnedCoins in
                self?.allCoins = returnedCoins
            }
            .store(in: &cancellables)
        
        marketDataService.$marketData
            .map(mapGLobalMarketData)
            .sink { [weak self] returnedStats in
                self?.statistics = returnedStats
            }
            .store(in: &cancellables)
        
        $allCoins
            .combineLatest(portofolioDataService.$savedEntities)
            .map { coinModels, portofolioEntities -> [CoinModel] in
                
                coinModels
                    .compactMap { coin -> CoinModel? in
                        
                        guard let entity = portofolioEntities.first(where: { $0.coinID == coin.id}) else {
                            return nil
                        }
                        
                        return coin.updateHoldings(amount: entity.amount)
                    }
            }
            .sink { [weak self] returnedCoins in
                self?.portofolioCoins = returnedCoins
            }
            .store(in: &cancellables)
    }
    
    func updatePortofolio(coin: CoinModel, amount: Double){
        portofolioDataService.updatePortofolio(coin: coin, amount: amount)
    }
    
    private func filterCoins(text: String, coins: [CoinModel]) -> [CoinModel]{
        guard !text.isEmpty else {
            return coins
        }
        
        let lowerCaseText = text.lowercased()
        
        return coins.filter{
            $0.name.lowercased().contains(lowerCaseText)
            || $0.symbol.lowercased().contains(lowerCaseText)
            || $0.id.lowercased().contains(lowerCaseText)
        }
    }
    
    private func mapGLobalMarketData(marketDataModel: MarketDataModel?) -> [StatisticModel]{
        
        var stats: [StatisticModel] = []
        
        guard let data = marketDataModel else{
            return stats
        }
        
        let marketCap = StatisticModel(title: "Market Cap", value: data.marketCap, percentageChange: data.marketCapChangePercentage24HUsd)
        let volume = StatisticModel(title: "24h Volume", value: data.volume)
        let btcDominance = StatisticModel(title: "BTC Dominance", value: data.btcDominance)
        let portofolio = StatisticModel(title: "Portofolio Value", value: "$0.00", percentageChange: 0)
        
        stats.append(contentsOf: [
            marketCap,
            volume,
            btcDominance,
            portofolio
        ])
        
        return stats
    }
}
