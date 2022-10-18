//
//  ImageManager.swift
//  CryptoWallet
//
//  Created by Aleksandr on 16.10.2022.
//

import UIKit
import Combine

protocol ImageNetworkManager {
    func download(url: URL) -> AnyPublisher<UIImage, Error>
}

final class ImageManager: ImageNetworkManager {
    
    func download(url: URL) -> AnyPublisher<UIImage, Error> {
        return URLSession.shared.dataTaskPublisher(for: url)
            .tryMap {
                return UIImage(data: $0.data) ?? UIImage()
            }
            .receive(on: DispatchQueue.main)
            .eraseToAnyPublisher()
    }
}
