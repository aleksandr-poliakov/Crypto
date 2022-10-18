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
    private let store: LocalStore
    private let coin: CoinModel
    private var cancellables: [AnyCancellable] = []
    private let folderName = "images"
    private let imageName: String
    
    init(service: ImageLoader, store: LocalStore, coin: CoinModel) {
        self.service = service
        self.store = store
        self.coin = coin
        self.imageName = coin.id ?? ""
    }
    
    func loadImage() {
        guard let imageString = coin.image else { return }
        
        if let fileImage = store.getImage(imageName: imageName, folderName: folderName) {
            image = fileImage
        } else {
            service.downloadImage(urlString: imageString).sink { [weak self] _ in
                self?.isLoading = false
            } receiveValue: { [weak self] image in
                guard let self = self else { return }
                
                self.image = image
                self.store.saveImage(image: image, imageName: self.imageName, folderName: self.folderName)
            }
            .store(in: &cancellables)
        }
    }
}
