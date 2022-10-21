//
//  CoinDataService.swift
//  CryptoWallet
//
//  Created by Aleksandr on 16.10.2022.
//

import Foundation
import Combine


protocol CoinDataServiceProtocol {
    var allCoins: Published<[CoinModel]>.Publisher { get }
    
    func getCoins()
}

final class CoinDataService: CoinDataServiceProtocol {
    
    //https://api.coingecko.com/api/v3/coins/markets?vs_currency=usd&order=market_cap_desc&per_page=250&page=1&sparkline=true&price_change_percentage=24h

    enum APIError: Error {
        case invalidRequestError(String)
    }
    
    private let manager: CoinNetworkManager
    private var cancellable: AnyCancellable?
    @Published private var coins: [CoinModel] = []
    var allCoins: Published<[CoinModel]>.Publisher { $coins }
    
    init(manager: CoinNetworkManager) {
        self.manager = manager
    }
    
    func getCoins() {
        guard let url = URL(string: "https://api.coingecko.com/api/v3/coins/markets?vs_currency=usd&order=market_cap_desc&per_page=250&page=1&sparkline=true&price_change_percentage=24h")
        else {
            return
        }
    
        cancellable = manager.download(url: url).sink(receiveCompletion: { _ in
            
        }, receiveValue: { [weak self] coins in
            self?.coins = coins
            self?.cancellable?.cancel()
        })
    }
}
