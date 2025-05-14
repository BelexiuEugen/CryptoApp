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
    
    var allCoins: [CoinModel] = []
    var portofolioCoins: [CoinModel] = []
    
    private let dataService = CoinDataService()
    
    private var cancellable = Set<AnyCancellable>()
    
    init(){
        addSubscribers()
    }
    
    func addSubscribers(){
        dataService.$allCoins
            .sink { [weak self] returnedCoins in
                self?.allCoins = returnedCoins
            }
            .store(in: &cancellable)
    }
}
