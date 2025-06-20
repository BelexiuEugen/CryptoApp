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
    
    @ObservationIgnored
    @Published var portofolioCoins: [CoinModel] = []
    
    var isLoading: Bool = false;
    
    @ObservationIgnored
    @Published var serachText: String = ""
    
    @ObservationIgnored
    @Published var sortOption: SortOption = .holdings
    
    private let coinDataService = CoinDataService()
    private let marketDataService = MarketDataService()
    private let portofolioDataService = PortofolioDataService()
    
    private var cancellables = Set<AnyCancellable>()
    
    enum SortOption{
        case rank
        case rankReverse
        case holdings
        case holdingReverse
        case price
        case priceReverse
    }
    
    init(){
        addSubscribers()
    }
    
    func addSubscribers(){
        
        //update allCoins.
        $serachText
            .combineLatest(coinDataService.$allCoins, $sortOption)
            .debounce(for: .seconds(0.5) , scheduler: DispatchQueue.main)
            .map(filterAndSortCoins)
            .sink { [weak self] returnedCoins in
                
                print("I was here");
                
                guard let self = self else { return }
                                
                self.portofolioCoins = self.sortPortofolioCoinsIfNeeded(coins: returnedCoins)
                self.allCoins = returnedCoins
            }
            .store(in: &cancellables)
        
        $allCoins
            .combineLatest(portofolioDataService.$savedEntities)
            .map(mapAllCoinsToPortofolioCoins)
            .sink { [weak self] returnedCoins in
                self?.portofolioCoins = returnedCoins
                self?.isLoading = false;
            }
            .store(in: &cancellables)
        
        marketDataService.$marketData
            .combineLatest($portofolioCoins)
            .map(mapGLobalMarketData)
            .sink { [weak self] returnedStats in
                self?.statistics = returnedStats
            }
            .store(in: &cancellables)
    }
    
    func updatePortofolio(coin: CoinModel, amount: Double){
        portofolioDataService.updatePortofolio(coin: coin, amount: amount)
    }
    
    func reloadData(){
        
        isLoading = true;
        
        coinDataService.getCoins()
        marketDataService.getData()
        HapticManager.notification(type: .success)
    }
    
    private func filterAndSortCoins(text: String, coins: [CoinModel], sort: SortOption) -> [CoinModel]{
        
        var updatedCoins = filterCoins(text: text, coins: coins)
        sortCoins(sort: sort, coins: &updatedCoins)
        return updatedCoins
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
    
    private func sortCoins(sort: SortOption, coins: inout [CoinModel]){
        switch sort{
        case .rank, .holdings:
            coins.sort { $0.rank < $1.rank}
        case .rankReverse, .holdingReverse:
            coins.sort { $0.rank > $1.rank}
        case .price:
            coins.sort { $0.currentPrice < $1.currentPrice}
        case .priceReverse:
            coins.sort { $0.currentPrice > $1.currentPrice}
        }
    }
    
    private func sortPortofolioCoinsIfNeeded(coins: [CoinModel]) -> [CoinModel]{
        
        switch sortOption{
        case .holdings:
            return coins.sorted(by: { $0.currentHoldingsValue > $1.currentHoldingsValue})
        case .holdingReverse:
            return coins.sorted(by: { $0.currentHoldingsValue < $1.currentHoldingsValue})
        default:
            return coins;
        }
    }
    
    private func mapAllCoinsToPortofolioCoins(allCoins: [CoinModel], portofolioCoins: [PortofolioEntity]) -> [CoinModel]{
        allCoins
            .compactMap { coin -> CoinModel? in
                
                guard let entity = portofolioCoins.first(where: { $0.coinID == coin.id}) else {
                    return nil
                }
                
                return coin.updateHoldings(amount: entity.amount)
            }
    }
    
    private func mapGLobalMarketData(marketDataModel: MarketDataModel?, portofolioCoins: [CoinModel]) -> [StatisticModel]{
        
        var stats: [StatisticModel] = []
        
        guard let data = marketDataModel else{
            return stats
        }
        
        let marketCap = StatisticModel(title: "Market Cap", value: data.marketCap, percentageChange: data.marketCapChangePercentage24HUsd)
        let volume = StatisticModel(title: "24h Volume", value: data.volume)
        let btcDominance = StatisticModel(title: "BTC Dominance", value: data.btcDominance)
        
        let portofolioValue =
        portofolioCoins
            .map { $0.currentHoldingsValue }
            .reduce(0, +)
        
        let previeosValue =
        portofolioCoins
            .map{ coin -> Double in
            let currentValue = coin.currentHoldingsValue
            let percentageChange = coin.priceChangePercentage24H ?? 0 / 100
            let previousValue = currentValue / (1 + percentageChange)
            
            return previousValue
            
            // 25 % -> 25 -> 0.25
        }.reduce(0, +)
        
        let percentageChange = ((portofolioValue - previeosValue) / previeosValue)
        
        let portofolio = StatisticModel(title: "Portofolio Value", value: portofolioValue.asCurrencyWith2Decimals(), percentageChange: percentageChange)
        
        
        
        stats.append(contentsOf: [
            marketCap,
            volume,
            btcDominance,
            portofolio
        ])
        
        return stats
    }
}
