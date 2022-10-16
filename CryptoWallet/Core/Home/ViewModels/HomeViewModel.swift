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
    
    init(service: CoinDataServiceProtocol) {
        self.service = service
    }
    
    func loadCoins() {
        service.getCoins().sink(
            receiveCompletion: { completion in
            switch completion {
                case .finished: print("Finished")
                case .failure(let error): print(error)
                }
            }, receiveValue: { [weak self] coins in
                self?.allCoins = coins
                self?.portfolioCoins = coins
            }
        )
        .store(in: &cancellables)
    }
}
