//
//  CoinDetailDataService.swift
//  CryptoApp
//
//  Created by Jan on 28/05/2025.
//

import Foundation
import Combine

class CoinDetailDataService{
    
    @Published var coinDetails: CoinDetailModel? = nil
//    private var cancellables: Set<AnyCancellable> = Set<AnyCancellable>()
    var coinDetailSubscribtion: AnyCancellable?
    let coin: CoinModel
    
    init(coin: CoinModel){
        self.coin = coin
        getCoinsDetails()
    }
    
    func getCoinsDetails(){
        
        let url = URL(string: "https://api.coingecko.com/api/v3/coins/\(coin.name)?localization=false&tickers=false&market_data=false&community_data=false&developer_data=false&sparkline=false")
        
        guard let url = url else { return }
        
        coinDetailSubscribtion = NetworkingManager.download(url: url)
            .decode(type: CoinDetailModel.self, decoder: JSONDecoder())
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: NetworkingManager.handleCompletion, receiveValue: { [weak self] returnedCoinDetails in
                self?.coinDetails = returnedCoinDetails
                self?.coinDetailSubscribtion?.cancel()
            })
//            .store(in: &cancellables)

    }
}
