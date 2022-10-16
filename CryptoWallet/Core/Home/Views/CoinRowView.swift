//
//  CoinRowView.swift
//  CryptoWallet
//
//  Created by Aleksandr on 16.10.2022.
//

import SwiftUI

struct CoinRowView: View {
    private let coin: CoinModel
    private let showHoldings: Bool
    
    init(coin: CoinModel, showHoldings: Bool) {
        self.coin = coin
        self.showHoldings = showHoldings
    }
    
    var body: some View {
        HStack(spacing: 0) {
            Text("\(coin.rank)")
                .font(.caption)
                .foregroundColor(Color.theme.secondaryText)
                .frame(minWidth: 30)
            
            Circle()
                .frame(width: 30, height: 30)
            Text(coin.symbol.uppercased())
                .font(.headline)
                .padding(6)
                .foregroundColor(Color.theme.accent)
            Spacer()
            if showHoldings {
                VStack {
                    Text(coin.currentHoldingValue.asCurrencyWithFormatterOf6MaximumDigits())
                    Text((coin.currentHoldings ?? 0).asNumberString())
                }
            }
            
            VStack(alignment: .trailing) {
                Text(coin.currentPrice.asCurrencyWithFormatterOf6MaximumDigits())
                    .bold()
                    .foregroundColor(Color.theme.accent)
                Text(coin.priceChangePercentage24H.asPercentString())
                    .foregroundColor(coin.priceChangePercentage24H >= 0 ? Color.theme.green : Color.theme.red)
            }
        }
    }
}

struct CoinRowView_Previews: PreviewProvider {
    static var previews: some View {
        CoinRowView(coin: dev.coin, showHoldings: true)
    }
}
