//
//  StatisticModel.swift
//  CryptoWallet
//
//  Created by Aleksandr on 21.10.2022.
//

import Foundation

struct StatisticModel: Identifiable {
    let id: String = UUID().uuidString
    let title: String
    let value: String
    let percentageChange: Double?
}
