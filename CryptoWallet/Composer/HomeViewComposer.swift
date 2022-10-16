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
            HomeView(service: CoinDataService(manager: CoinManager()),
                     showPortfolio: false)
        }
    }
}
