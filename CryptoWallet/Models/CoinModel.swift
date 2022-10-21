//
//  CoreModel.swift
//  CryptoWallet
//
//  Created by Aleksandr on 16.10.2022.
//

import Foundation

/*
 https://api.coingecko.com/api/v3/coins/markets?vs_currency=usd&order=market_cap_desc&per_page=250&page=1&sparkline=true&price_change_percentage=24h
 
 refer to this json
 */

// MARK: - CoinModel
struct CoinModel: Identifiable, Codable {
    let id, symbol, name: String?
    let image: String?
    let currentPrice: Double
    let marketCap, marketCapRank, fullyDilutedValuation: Int?
    let high24H, low24H, priceChange24H, priceChangePercentage24H, totalVolume: Double?
    let marketCapChange24H, marketCapChangePercentage24H: Double?
    let circulatingSupply, totalSupply, maxSupply, ath: Double?
    let athChangePercentage: Double?
    let athDate: String?
    let atl, atlChangePercentage: Double?
    let atlDate: String?
    let lastUpdated: String?
    let sparklineIn7D: SparklineIn7D?
    let priceChangePercentage24HInCurrency: Double?
    let currentHoldings: Double?
    
    init(id: String?, symbol: String?, name: String?, image: String?, currentPrice: Double, marketCap: Int?, marketCapRank: Int?, fullyDilutedValuation: Int?, high24H: Double?, low24H: Double?, priceChange24H: Double?, priceChangePercentage24H: Double?, totalVolume: Double?, marketCapChange24H: Double?, marketCapChangePercentage24H: Double?, circulatingSupply: Double?, totalSupply: Double?, maxSupply: Double?, ath: Double?, athChangePercentage: Double?, athDate: String?, atl: Double?, atlChangePercentage: Double?, atlDate: String?, lastUpdated: String?, sparklineIn7D: SparklineIn7D?, priceChangePercentage24HInCurrency: Double?, currentHoldings: Double? = 1) {
        self.id = id
        self.symbol = symbol
        self.name = name
        self.image = image
        self.currentPrice = currentPrice
        self.marketCap = marketCap
        self.marketCapRank = marketCapRank
        self.fullyDilutedValuation = fullyDilutedValuation
        self.high24H = high24H
        self.low24H = low24H
        self.priceChange24H = priceChange24H
        self.priceChangePercentage24H = priceChangePercentage24H
        self.totalVolume = totalVolume
        self.marketCapChange24H = marketCapChange24H
        self.marketCapChangePercentage24H = marketCapChangePercentage24H
        self.circulatingSupply = circulatingSupply
        self.totalSupply = totalSupply
        self.maxSupply = maxSupply
        self.ath = ath
        self.athChangePercentage = athChangePercentage
        self.athDate = athDate
        self.atl = atl
        self.atlChangePercentage = atlChangePercentage
        self.atlDate = atlDate
        self.lastUpdated = lastUpdated
        self.sparklineIn7D = sparklineIn7D
        self.priceChangePercentage24HInCurrency = priceChangePercentage24HInCurrency
        self.currentHoldings = currentHoldings
    }

    enum CodingKeys: String, CodingKey {
        case id, symbol, name, image
        case currentPrice = "current_price"
        case marketCap = "market_cap"
        case marketCapRank = "market_cap_rank"
        case fullyDilutedValuation = "fully_diluted_valuation"
        case totalVolume = "total_volume"
        case high24H = "high_24h"
        case low24H = "low_24h"
        case priceChange24H = "price_change_24h"
        case priceChangePercentage24H = "price_change_percentage_24h"
        case marketCapChange24H = "market_cap_change_24h"
        case marketCapChangePercentage24H = "market_cap_change_percentage_24h"
        case circulatingSupply = "circulating_supply"
        case totalSupply = "total_supply"
        case maxSupply = "max_supply"
        case ath
        case athChangePercentage = "ath_change_percentage"
        case athDate = "ath_date"
        case atl
        case atlChangePercentage = "atl_change_percentage"
        case atlDate = "atl_date"
        case lastUpdated = "last_updated"
        case sparklineIn7D = "sparkline_in_7d"
        case priceChangePercentage24HInCurrency = "price_change_percentage_24h_in_currency"
        case currentHoldings
    }
    
    var currentHoldingValue: Double {
        return (currentHoldings ?? 0) * currentPrice
    }
    
    var rank: Int  {
        return Int(marketCapRank ?? 0)
    }
    
    func updateHoldings(amount: Double) -> CoinModel {
        return CoinModel(id: id,
                         symbol: symbol,
                         name: name,
                         image: image,
                         currentPrice: currentPrice,
                         marketCap: marketCap,
                         marketCapRank: marketCapRank,
                         fullyDilutedValuation: fullyDilutedValuation,
                         high24H: totalVolume,
                         low24H: high24H,
                         priceChange24H: low24H,
                         priceChangePercentage24H: priceChange24H,
                         totalVolume: priceChangePercentage24H,
                         marketCapChange24H: marketCapChange24H,
                         marketCapChangePercentage24H: marketCapChangePercentage24H,
                         circulatingSupply: circulatingSupply,
                         totalSupply: totalSupply,
                         maxSupply: maxSupply,
                         ath: ath,
                         athChangePercentage: athChangePercentage,
                         athDate: athDate,
                         atl: atl,
                         atlChangePercentage: atlChangePercentage,
                         atlDate: atlDate,
                         lastUpdated: lastUpdated,
                         sparklineIn7D: sparklineIn7D,
                         priceChangePercentage24HInCurrency: priceChangePercentage24HInCurrency,
                         currentHoldings: amount)
    }
}

// MARK: - SparklineIn7D
struct SparklineIn7D: Codable {
    let price: [Double]
}
