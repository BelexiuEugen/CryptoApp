//
//  DetailViewModel.swift
//  CryptoApp
//
//  Created by Jan on 28/05/2025.
//

import Foundation
import Combine

@Observable
class DetailViewModel{
    
    @ObservationIgnored
    @Published var overviewStatistic: [StatisticModel] = []
    @ObservationIgnored
    @Published var additionalStatistic: [StatisticModel] = []
    
    @ObservationIgnored
    @Published var coinDescription: String? = nil
    var websiteURL: String? = nil
    var redditURL: String? = nil
    
    @ObservationIgnored
    @Published var coin: CoinModel
    private let coinDetailService: CoinDetailDataService
    private var cancellabels = Set<AnyCancellable>()
    
    init(coin: CoinModel){
        self.coin = coin;
        self.coinDetailService = CoinDetailDataService(coin: coin)
        self.addSubscribers()
    }
    
    private func addSubscribers(){
        
        coinDetailService.$coinDetails
            .combineLatest($coin)
            .map(mapDataToStatistics)
            .sink { [weak self] returnedArray in
                self?.overviewStatistic = returnedArray.overview
                self?.additionalStatistic = returnedArray.additional
            }
            .store(in: &cancellabels)
        
        coinDetailService.$coinDetails
            .sink { returnedCoinDetails in
            self.coinDescription = returnedCoinDetails?.readableDescription
            self.websiteURL = returnedCoinDetails?.links?.homepage?.first
            self.redditURL = returnedCoinDetails?.links?.subredditURL
        }
        .store(in: &cancellabels)

    }
    
    private func mapDataToStatistics(coinDetailModel: CoinDetailModel?, coinModel: CoinModel) -> (overview: [StatisticModel], additional: [StatisticModel]){
        
        let overviewArray: [StatisticModel] = createOverArray(coinModel: coinModel)
        let additionalArray: [StatisticModel] = createAdditionalArray(coinModel: coinModel, coinDetailModel: coinDetailModel)
        
        return (overviewArray, additionalArray)
    }
    
    private func createOverArray(coinModel: CoinModel) -> [StatisticModel]{
        let pricePercentage = coinModel.currentPrice.asCurrencyWith2Decimals()
        let pricePercentageChange = coinModel.priceChangePercentage24H
        let priceStat = StatisticModel(title: "Current Price", value: pricePercentage, percentageChange: pricePercentageChange)
        
        let marketCap = "$" + (coinModel.marketCap?.formattedWithAbbreviations() ?? "")
        let marketCapPercentageChange = coinModel.marketCapChange24H
        let marketCapStat = StatisticModel(title: "Market capitalization", value: marketCap, percentageChange: marketCapPercentageChange)
        
        let rank = "\(coinModel.rank)"
        let rankStat = StatisticModel(title: "Rank", value: rank)
        
        let volume = "$" + (coinModel.totalVolume?.formattedWithAbbreviations() ?? "")
        let volumeStat = StatisticModel(title: "Volume", value: volume)
        
        let overviewArray: [StatisticModel] = [
            priceStat,
            marketCapStat,
            rankStat,
            volumeStat
        ]
        
        return overviewArray
    }
    
    private func createAdditionalArray(coinModel: CoinModel, coinDetailModel: CoinDetailModel?) -> [StatisticModel]{
        let high = coinModel.high24H?.asCurrencyWith6Decimals() ?? "n/a"
        let highStat = StatisticModel(title: "24h High", value: high)
        
        let low = coinModel.low24H?.asCurrencyWith6Decimals() ?? "n/a"
        let lowStat = StatisticModel(title: "24h Low", value: low)
        
        let priceChange = coinModel.priceChange24H?.asCurrencyWith6Decimals() ?? "n/a"
        let pricePercentageChange = coinModel.priceChangePercentage24H
        let priceChangeStat = StatisticModel(title: "24h Price Change", value: priceChange, percentageChange: pricePercentageChange)
        
        let marketCapChange = "$" + (coinModel.marketCapChange24H?.formattedWithAbbreviations() ?? "")
        let marketCapPercentageChange = coinModel.marketCapChangePercentage24H
        let marketCapChangeStat = StatisticModel(title: "24h market cap change", value: marketCapChange, percentageChange: marketCapPercentageChange)
        
        let blockTime = coinDetailModel?.blockTimeInMinutes ?? 0
        let blockTimeString = blockTime == 0 ? "n/a" : "\(blockTime)"
        let blockStat = StatisticModel(title: "Block Time", value: blockTimeString)
        
        let hashing = coinDetailModel?.hashingAlgorithm ?? "n/a"
        let hashingStat = StatisticModel(title: "Hashing Algorithm", value: hashing)
        
        let additionalArray: [StatisticModel] = [
            highStat,
            lowStat,
            priceChangeStat,
            marketCapChangeStat,
            blockStat,
            hashingStat
        ]
        
        return additionalArray
    }
}
