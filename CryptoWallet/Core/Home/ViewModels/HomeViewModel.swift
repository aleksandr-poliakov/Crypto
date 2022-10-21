//
//  HomeViewModel.swift
//  CryptoWallet
//
//  Created by Aleksandr on 16.10.2022.
//

import Foundation
import Combine

final class HomeViewModel: ObservableObject {
    
    private let coinService: CoinDataServiceProtocol
    private let marketService: MarketDataServiceProtocol
    private var cancellables: Set<AnyCancellable> = []
    @Published var allCoins: [CoinModel] = []
    @Published var statistics: [StatisticModel] = []
    @Published var portfolioCoins: [CoinModel] = []
    @Published var searchText: String = ""
    
    init(coinService: CoinDataServiceProtocol, marketService: MarketDataServiceProtocol) {
        self.coinService = coinService
        self.marketService = marketService
        addSubscribers()
    }
    
    func loadCoins() {
        coinService.getCoins()
    }
    
    func loadMarketData() {
        marketService.getMarket().sink { _ in }
        receiveValue: { [weak self] statistics in
            self?.statistics = statistics
        }.store(in: &cancellables)
    }
    
    private func addSubscribers() {
        $searchText
            .combineLatest(coinService.allCoins)
            .debounce(for: .seconds(0.5), scheduler: DispatchQueue.main)
            .map(filterCoins)
            .sink { [weak self] coins in
                self?.allCoins = coins
                self?.portfolioCoins = coins
            }
            .store(in: &cancellables)
    }
    
    private func filterCoins(text: String, coins: [CoinModel]) -> [CoinModel] {
        guard !text.isEmpty else {
            return coins
        }
        
        let lowercasedText = text.lowercased()
        return coins.filter { (coin) -> Bool in
            guard
                let name = coin.name,
                let symbol = coin.symbol,
                let id = coin.id
            else {
                return false
            }
            
            return name.lowercased().contains(lowercasedText) ||
                   symbol.lowercased().contains(lowercasedText) ||
                   id.lowercased().contains(lowercasedText)
        }
    }
}
