//
//  CoinDataService.swift
//  CryptoWallet
//
//  Created by Aleksandr on 16.10.2022.
//

import Foundation
import Combine


protocol CoinDataServiceProtocol {
    func getCoins() -> AnyPublisher<[CoinModel], Error>
}

final class CoinDataService: CoinDataServiceProtocol {
    //https://api.coingecko.com/api/v3/coins/markets?vs_currency=usd&order=market_cap_desc&per_page=250&page=1&sparkline=true&price_change_percentage=24h

    enum APIError: Error {
        case invalidRequestError(String)
    }
    
    private let manager: NetworkManager<[CoinModel]>
    
    init(manager: NetworkManager<[CoinModel]>) {
        self.manager = manager
    }
    
    func getCoins() -> AnyPublisher<[CoinModel], Error> {
        guard let url = URL(string: "https://api.coingecko.com/api/v3/coins/markets?vs_currency=usd&order=market_cap_desc&per_page=250&page=1&sparkline=true&price_change_percentage=24h")
        else {
            return Fail(error: APIError.invalidRequestError("URL invalid"))
                .eraseToAnyPublisher()
        }
        
        return manager.download(url: url)
    }
}
