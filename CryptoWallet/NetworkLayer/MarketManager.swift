//
//  MarketManager.swift
//  CryptoWallet
//
//  Created by Aleksandr on 21.10.2022.
//

import Foundation
import Combine

protocol MarketNetworkManager {
    func download(url: URL) -> AnyPublisher<[StatisticModel], Error>
}

final class MarketManager: MarketNetworkManager {
    enum NetworkingError: LocalizedError {
        case badURLResponse(url: URL)
        case unknown
        
        var errorDescription: String? {
            switch self {
            case .badURLResponse(let url): return "Bad response from url: \(url)"
            case .unknown: return "Unknown error"
            }
        }
    }
    
    func download(url: URL) -> AnyPublisher<[StatisticModel], Error> {
        URLSession.shared.dataTaskPublisher(for: url)
            .subscribe(on: DispatchQueue.global(qos: .default))
            .tryMap({ try MarketManager.handleURLResponse(output: $0, url: url) })
            .decode(type: GlobalData.self, decoder: JSONDecoder())
            .map({ market -> [StatisticModel] in
                var stats: [StatisticModel] = []
                
                let marketCap = StatisticModel(title: "Market Cap", value: market.data?.marketCap ?? "", percentageChange: market.data?.marketCapChangePercentage24HUsd)
                let volume = StatisticModel(title: "24h Volume", value: market.data?.volume ?? "", percentageChange: nil)
                let btcDominance = StatisticModel(title: "BTC Dominance", value: market.data?.btcDominance ?? "", percentageChange: nil)
                let portfolio = StatisticModel(title: "Portfolio Value", value: "$0.00", percentageChange: nil)
                
                stats.append(contentsOf: [marketCap, volume, btcDominance, portfolio])
                return stats
            })
            .receive(on: DispatchQueue.main)
            .eraseToAnyPublisher()
    }

    static private func handleURLResponse(output: URLSession.DataTaskPublisher.Output, url: URL) throws -> Data {
        guard let response = output.response as? HTTPURLResponse,
              response.statusCode >= 200 && response.statusCode < 300 else {
            throw NetworkingError.badURLResponse(url: url)
        }
        return output.data
    }
}
