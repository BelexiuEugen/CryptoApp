//
//  CoinDataService.swift
//  CryptoApp
//
//  Created by Jan on 14/05/2025.
//

import Foundation
import Combine

class MarketDataService{
    
    @Published var marketData: MarketDataModel? = nil
    private var url = URL(string: "https://api.coingecko.com/api/v3/global")
//    private var cancellables: Set<AnyCancellable> = Set<AnyCancellable>()
    var marketDataSubscribtion: AnyCancellable?
    
    init(){
        getData()
    }
    
    private func getData(){
        
        guard let url = url else { return }
        
        marketDataSubscribtion = NetworkingManager.download(url: url)
            .decode(type: GlobalData.self, decoder: JSONDecoder())
            .sink(receiveCompletion: NetworkingManager.handleCompletion, receiveValue: { [weak self] returnedGlobalData in
                self?.marketData = returnedGlobalData.data
                self?.marketDataSubscribtion?.cancel()
            })
//            .store(in: &cancellables)

    }
}
