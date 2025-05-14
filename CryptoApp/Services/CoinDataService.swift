//
//  CoinDataService.swift
//  CryptoApp
//
//  Created by Jan on 14/05/2025.
//

import Foundation
import Combine

class CoinDataService{
    
    @Published var allCoins: [CoinModel] = []
    private var url = URL(string: "https://api.coingecko.com/api/v3/coins/markets?vs_currency=usd&order=market_cap_desc&per_page=250&page=1&sparkline=true&price_change_percentage=24h")
//    private var cancellables: Set<AnyCancellable> = Set<AnyCancellable>()
    var coinSubscribtion: AnyCancellable?
    
    init(){
        getCoins()
    }
    
    private func getCoins(){
        
        guard let url = url
        else { return }
        
        coinSubscribtion = URLSession.shared.dataTaskPublisher(for: url)
            .subscribe(on: DispatchQueue.global(qos: .default))
            .tryMap { output in
                guard let response = output.response as? HTTPURLResponse,
                      response.statusCode >= 200 && response.statusCode < 300 else{
                    throw URLError(.badServerResponse)
                }
                return output.data
            }
            .receive(on: DispatchQueue.main)
            .decode(type: [CoinModel].self, decoder: JSONDecoder())
            .sink { completion in
                switch completion{
                case .finished:
                    break
                case .failure(let error):
                    print(error.localizedDescription)
                
                }
            } receiveValue: { [weak self] returnedCoins in
                self?.allCoins = returnedCoins
                self?.coinSubscribtion?.cancel()
            }
//            .store(in: &cancellables)

    }
}
