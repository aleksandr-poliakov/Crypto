//
//  CoinImageViewModel.swift
//  CryptoWallet
//
//  Created by Aleksandr on 16.10.2022.
//

import UIKit
import Combine

class CoinImageViewModel: ObservableObject {
    @Published var image: UIImage? = nil
    @Published var isLoading: Bool = false
    private let service: ImageLoader
    private let coin: CoinModel
    private var cancellables: [AnyCancellable] = []
    
    init(service: ImageLoader, coin: CoinModel) {
        self.service = service
        self.coin = coin
    }
    
    func loadImage() {
        guard let imageString = coin.image else { return }
                
        service.downloadImage(urlString: imageString).sink { [weak self] _ in
            self?.isLoading = false
        } receiveValue: { [weak self] image in
            self?.image = image
        }
        .store(in: &cancellables)
    }
}
