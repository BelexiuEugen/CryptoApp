//
//  CoinImageViewModel.swift
//  CryptoApp
//
//  Created by Jan on 14/05/2025.
//

import SwiftUI
import Combine

@Observable
class CoinImageViewModel{
    
    var image: UIImage? = nil
    var isLoading: Bool = true
    
    private let coin: CoinModel
    private let dataService: CoinImageService
    
    private var cancellable = Set<AnyCancellable>()
    
    init(coin: CoinModel){
        self.coin = coin
        self.dataService = CoinImageService(coin: coin)
        self.isLoading = true;
        getImage()
    }
    
    private func getImage(){
        
        dataService.$image
            .sink(receiveCompletion: { _ in
                self.isLoading = false;
            }, receiveValue: { [weak self] recivedImage in
                self?.image = recivedImage
            })
            .store(in: &cancellable)
    }
}
