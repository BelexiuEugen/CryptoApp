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
    private let fileManager = LocalFileManager.instance
    private let folderName = "coin_images"
    private let imageName: String
    
    var imageSubscribtion: AnyCancellable?
    
    init(coin: CoinModel){
        self.coin = coin
        self.imageName = coin.id
        getCoinImage()
    }
    
    private func getCoinImage(){
        if let savedImage = fileManager.getImage(imageName: coin.id, folderName: folderName){
            image = savedImage
            print("Retrived image from File Manager!")
        } else{
            downloadCoinImage()
            print("Downloading image now")
        }
    }
    
    private func downloadCoinImage(){
        
        print("Downloading images now");
        
        guard let url = URL(string: coin.image) else { return }
        
        imageSubscribtion = NetworkingManager.download(url: url)
            .receive(on: DispatchQueue.main)
            .tryMap({ data -> UIImage? in
                return UIImage(data: data)
            })
            .sink(receiveCompletion: NetworkingManager.handleCompletion, receiveValue: { [weak self] returnedImage in
                
                guard
                    let self = self,
                    let downloadedImage = returnedImage
                else { return }
                
                self.image = returnedImage
                self.imageSubscribtion?.cancel()
                self.fileManager.saveImage(image: downloadedImage, imageName: self.imageName, folderName: self.folderName)
            })
//            .store(in: &cancellables)
        
    }
}
