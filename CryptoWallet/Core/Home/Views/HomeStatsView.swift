//
//  HomeStatsView.swift
//  CryptoWallet
//
//  Created by Aleksandr on 21.10.2022.
//

import SwiftUI

struct HomeStatsView: View {
    
    @StateObject private var viewModel: HomeViewModel
    @Binding private var showPortfolio: Bool
    
    init(viewModel: StateObject<HomeViewModel>, showPortfolio: Binding<Bool>) {
        self._viewModel = viewModel
        self._showPortfolio = showPortfolio
    }
    
    var body: some View {
        HStack {
            ForEach(viewModel.statistics) { statistic in
                StatisticView(statistic: statistic)
                    .frame(width: UIScreen.main.bounds.width / 3)
            }
        }
        .frame(width: UIScreen.main.bounds.width,
               alignment: showPortfolio ? .trailing : .leading)
        .onAppear(perform: viewModel.loadMarketData)
    }
}

struct HomeStatsView_Previews: PreviewProvider {
    
    static var previews: some View {
        HomeStatsView(viewModel: .init(wrappedValue: dev.homeViewModel),
                      showPortfolio: .constant(false))
    }
}
