//
//  PortofolioView.swift
//  CryptoApp
//
//  Created by Jan on 22/05/2025.
//

import SwiftUI

struct PortofolioView: View {

    @Environment(HomeViewModel.self) private var vm;
    @State private var selectedCoin: CoinModel? = nil;
    @State private var quantityText: String = ""
    @State private var showCheckmark: Bool = false;
    
    var body: some View {
        
        @Bindable var vm = vm;
        
        NavigationStack{
            ScrollView {
                VStack(alignment: .leading, spacing: 0){
                    SearchBarView(serachText: $vm.serachText)
                    
                    coinLogoList
                    
                    if selectedCoin != nil{
                        portofolioInputSection
                    }
                }
            }
            .navigationTitle("Edit Portofolio")
            .toolbar {
                ToolbarItem(placement: .topBarLeading) {
                    XMarkButton()
                }
                
                ToolbarItem(placement: .topBarTrailing) {
                    trailiningNavBarItemes
                }
            }
            .onChange(of: vm.serachText) {
                if vm.serachText == ""{
                    removeSelectedCoins()
                }
            }
        }
    }
}

#Preview {
    PortofolioView()
        .environment(HomeViewModel())
}

extension PortofolioView{
    
    private var coinLogoList: some View{
        ScrollView(.horizontal, showsIndicators: false) {
            LazyHStack(spacing: 10){
                ForEach(vm.serachText.isEmpty ? vm.portofolioCoins : vm.allCoins){ coin in
                    CoinLogoView(coin: coin)
                        .frame(width: 75)
                        .padding(4)
                        .onTapGesture{
                            withAnimation(.easeIn){
                                updateSelectedCoin(coin: coin)
                                
                            }
                        }
                        .background(
                            RoundedRectangle(cornerRadius: 10)
                                .stroke( selectedCoin?.id == coin.id ? Color.theme.green : Color.clear
                                         , lineWidth: 1)
                        )
                }
            }
            .frame(height: 120)
            .padding(.leading)
        }
    }
    
    private func updateSelectedCoin(coin: CoinModel){
        selectedCoin = coin;
        
        if let portofolioCoin = vm.portofolioCoins.first(where: { $0.id == coin.id}),
           let amount = portofolioCoin.currentHoldings{
            quantityText = "\(amount)"
        } else{
            quantityText = ""
        }
        
        
    }
    
    private func getCurrentValue() -> Double{
        
        if let quantity = Double(quantityText){
            return quantity * (selectedCoin?.currentPrice ?? 0)
        }
        
        return 0;
    }
    
    private var portofolioInputSection: some View{
        VStack(spacing: 20){
            HStack{
                Text("Current Price \(selectedCoin?.symbol.uppercased() ?? ""):")
                Spacer()
                Text(selectedCoin?.currentPrice.asCurrencyWith6Decimals() ?? "")
            }
            Divider()
            HStack{
                Text("Amount in your portofolio:")
                Spacer()
                TextField("Ex: 1.4", text: $quantityText)
                    .multilineTextAlignment(.trailing)
                    .keyboardType(.decimalPad)
            }
            Divider()
            HStack{
                Text("Current Value:")
                Spacer()
                Text(getCurrentValue().asCurrencyWith2Decimals())
            }
        }
        .padding()
        .font(.headline)
    }
    
    private var trailiningNavBarItemes: some View{
        HStack(spacing: 10){
            Image(systemName: "checkmark")
                .opacity(showCheckmark ? 1.0 : 0.0)
            
            Button {
                saveButtonPressed()
            } label: {
                Text("Save".uppercased())
            }
            .opacity(
                (selectedCoin != nil && selectedCoin?.currentHoldings != Double(quantityText)) ? 1.0 : 0.0
            )
        }
        .font(.headline)
    }
    
    private func saveButtonPressed(){
        
        guard
            let coin = selectedCoin,
            let amount = Double(quantityText)
        else{ return }
        
        vm.updatePortofolio(coin: coin, amount: amount)
        
        withAnimation(.easeIn) {
            showCheckmark = true;
            removeSelectedCoins()
        }
        
        UIApplication.shared.endEditing()
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 2.0){
            showCheckmark = false;
        }
    }
    
    private func removeSelectedCoins(){
        selectedCoin = nil
        vm.serachText = ""
    }
}
