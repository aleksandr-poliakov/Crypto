//
//  StatisticView.swift
//  CryptoWallet
//
//  Created by Aleksandr on 21.10.2022.
//

import SwiftUI

struct StatisticView: View {
    
    private let statistic: StatisticModel
    
    init(statistic: StatisticModel) {
        self.statistic = statistic
    }
    
    var body: some View {
        VStack(alignment: .leading, spacing: 4) {
            Text(statistic.title)
                .font(.caption)
                .foregroundColor(Color.theme.secondaryText)
            Text(statistic.value)
                .font(.headline)
                .foregroundColor(Color.theme.accent)
            
            HStack(spacing: 4) {
                Image(systemName: "triangle.fill")
                    .font(.caption2)
                    .rotationEffect(
                        .degrees((statistic.percentageChange ?? 0) >= 0 ? 0 : 180))
                
                Text(statistic.percentageChange?.asPercentString() ?? "")
                    .font(.caption)
                    .bold()
            }
            .foregroundColor((statistic.percentageChange ?? 0) >= 0 ? Color.theme.green : Color.theme.red)
            .opacity(statistic.percentageChange == nil ? 0.0 : 1.0)
        }
    }
}

struct StatisticView_Previews: PreviewProvider {
    static var previews: some View {
        StatisticView(statistic: dev.statistic)
            .previewLayout(.sizeThatFits)
    }
}
