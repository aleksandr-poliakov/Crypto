//
//  CoinImageService.swift
//  CryptoWallet
//
//  Created by Aleksandr on 16.10.2022.
//

import Combine
import UIKit

protocol ImageLoader {
    func downloadImage(urlString: String) -> AnyPublisher<UIImage, Error>
}

final class CoinImageService: ImageLoader {
    
    enum APIError: Error {
        case invalidRequestError(String)
    }
    
    private let manager: ImageNetworkManager
    
    init(manager: ImageNetworkManager) {
        self.manager = manager
    }
    
    func downloadImage(urlString: String) -> AnyPublisher<UIImage, Error> {
        guard let url = URL(string: urlString) else {
            return Fail(error: APIError.invalidRequestError("URL invalid"))
                .eraseToAnyPublisher()
        }
        
        return manager.download(url: url)
    }
}
