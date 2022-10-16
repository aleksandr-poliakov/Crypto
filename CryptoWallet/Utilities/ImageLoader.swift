//
//  ImageLoader.swift
//  CryptoWallet
//
//  Created by Aleksandr on 16.10.2022.
//

import UIKit
import Combine

protocol ImageLoader: AnyObject {
    func downloadImage(urlString: String) -> AnyPublisher<UIImage, Error>
}
