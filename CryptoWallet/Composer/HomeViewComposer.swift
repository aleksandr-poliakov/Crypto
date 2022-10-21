//
//  HomeViewComposer.swift
//  CryptoWallet
//
//  Created by Aleksandr on 16.10.2022.
//

import SwiftUI

enum CompositionRoot {
    static var composeApp: some View {
        NavigationView {
            HomeView(coinService: CoinDataService(manager: CoinManager()),
                     marketService: MarketDataService(manager: MarketManager()),
                     showPortfolio: false)
        }
    }
}
