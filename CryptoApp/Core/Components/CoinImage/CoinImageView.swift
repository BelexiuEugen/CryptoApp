//
//  CoinImageView.swift
//  CryptoApp
//
//  Created by Jan on 14/05/2025.
//

import SwiftUI

struct CoinImageView: View {
    
    @State var viewModel: CoinImageViewModel;
    
    init(coin: CoinModel){
        _viewModel = State(wrappedValue: CoinImageViewModel(coin: coin))
    }
    
    var body: some View {
        ZStack{
            if let image = viewModel.image{
                Image(uiImage: image)
                    .resizable()
                    .scaledToFit()
            } else if viewModel.isLoading{
                ProgressView()
            } else{
                Image(systemName: "questionmark")
                    .foregroundStyle(Color.theme.secondaryText)
            }
        }
    }
}

#Preview(traits: .sizeThatFitsLayout) {
    CoinImageView(coin: DeveloperPreview.instance.coin)
        .padding()
}
