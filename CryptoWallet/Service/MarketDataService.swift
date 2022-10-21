//
//  MarketDataService.swift
//  CryptoWallet
//
//  Created by Aleksandr on 21.10.2022.
//

import Foundation
import Combine

protocol MarketDataServiceProtocol {
    func getMarket() -> AnyPublisher<[StatisticModel], Error>
}

final class MarketDataService: MarketDataServiceProtocol {
    
    enum APIError: Error {
        case invalidRequestError(String)
    }
    
    private let manager: MarketNetworkManager
 
    init(manager: MarketNetworkManager) {
        self.manager = manager
    }
    
    func getMarket() -> AnyPublisher<[StatisticModel], Error> {
        guard let url = URL(string: "https://api.coingecko.com/api/v3/global")
        else {
            return Fail(error: APIError.invalidRequestError("Error get market")).eraseToAnyPublisher()
        }
    
       return manager.download(url: url)
    }
}
