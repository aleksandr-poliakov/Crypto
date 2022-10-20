//
//  HomeViewModel.swift
//  CryptoWallet
//
//  Created by Aleksandr on 16.10.2022.
//

import Foundation
import Combine

final class HomeViewModel: ObservableObject {
    
    private let service: CoinDataServiceProtocol
    private var cancellables: Set<AnyCancellable> = []
    @Published var allCoins: [CoinModel] = []
    @Published var portfolioCoins: [CoinModel] = []
    @Published var searchText: String = ""
    
    init(service: CoinDataServiceProtocol) {
        self.service = service
        addSubscribers()
    }
    
    func loadCoins() {
        service.getCoins()
    }
    
    private func addSubscribers() {
        $searchText
            .combineLatest(service.allCoins)
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
