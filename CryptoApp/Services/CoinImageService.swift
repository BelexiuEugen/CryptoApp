//
//  CoinImageService.swift
//  CryptoApp
//
//  Created by Jan on 14/05/2025.
//

import Foundation
import SwiftUI
import Combine

class CoinImageService{
    
    @Published var image: UIImage? = nil;
    private let coin: CoinModel
    
    var imageSubscribtion: AnyCancellable?
    
    init(coin: CoinModel){
        self.coin = coin
        getCoinImage()
    }
    
    private func getCoinImage(){
        
        guard let url = URL(string: coin.image) else { return }
        
        imageSubscribtion = NetworkingManager.download(url: url)
            .tryMap({ data -> UIImage? in
                return UIImage(data: data)
            })
            .sink(receiveCompletion: NetworkingManager.handleCompletion, receiveValue: { [weak self] returnedImage in
                self?.image = returnedImage
                self?.imageSubscribtion?.cancel()
            })
//            .store(in: &cancellables)
        
    }
}
