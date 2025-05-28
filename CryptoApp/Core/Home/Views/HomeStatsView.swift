//
//  HomeStatsView.swift
//  CryptoApp
//
//  Created by Jan on 20/05/2025.
//

import SwiftUI

struct HomeStatsView: View {
    
    @Environment(HomeViewModel.self) private var vm;
    
    @Binding var showPortofolio: Bool
    
    var body: some View {
        HStack{
            ForEach(vm.statistics) { stat in
                StatisticView(stat: stat)
                    .frame(width: UIScreen.main.bounds.width / 3)
            }
        }
        .frame(width: UIScreen.main.bounds.width,
               alignment: showPortofolio ? .trailing : .leading
        )
    }
}

#Preview {
    HomeStatsView(showPortofolio: .constant(false))
        .environment(HomeViewModel())
}
