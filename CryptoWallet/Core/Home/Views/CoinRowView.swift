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
            leftColumn
            Spacer()
            if showHoldings {
                centerColumn
            }
            
            rightColumn
        }
        .font(.subheadline)
    }
}

struct CoinRowView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            CoinRowView(coin: dev.coin, showHoldings: true)
                .previewLayout(.sizeThatFits)
            
            CoinRowView(coin: dev.coin, showHoldings: true)
                .previewLayout(.sizeThatFits)
                .preferredColorScheme(.dark)
        }
    }
}

extension CoinRowView {
    /// left column
    private var leftColumn: some View {
        HStack {
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
        }
    }
    
    /// center column
    private var centerColumn: some View {
        VStack(alignment: .trailing) {
            Text(coin.currentHoldingValue.asCurrencyWithFormatterOf6MaximumDigits())
                .bold()
            Text((coin.currentHoldings ?? 0).asNumberString())
        }
        .foregroundColor(Color.theme.accent)
    }
    
    /// right column
    private var rightColumn: some View {
        VStack(alignment: .trailing) {
            Text(coin.currentPrice.asCurrencyWithFormatterOf6MaximumDigits())
                .bold()
                .foregroundColor(Color.theme.accent)
            Text(coin.priceChangePercentage24H.asPercentString())
                .foregroundColor(coin.priceChangePercentage24H >= 0 ? Color.theme.green : Color.theme.red)
        }
        .frame(width: UIScreen.main.bounds.width / 3.5, alignment: .trailing)
    }
}
