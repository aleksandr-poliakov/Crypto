//
//  CoinImageView.swift
//  CryptoWallet
//
//  Created by Aleksandr on 16.10.2022.
//

import SwiftUI

struct CoinImageView: View {
    
    @StateObject private var viewModel: CoinImageViewModel
    
    init(service: ImageLoader, store: LocalStore, coin: CoinModel) {
        self._viewModel = StateObject(wrappedValue: CoinImageViewModel(service: service, store: store, coin: coin))
    }
    
    var body: some View {
        ZStack {
            if let image = viewModel.image {
                Image(uiImage: image)
                    .resizable()
                    .scaledToFit()
            } else if viewModel.isLoading {
                
            } else {
                Image(systemName: "questionmark")
                    .foregroundColor(Color.theme.secondaryText)
            }
        }.onAppear(perform: viewModel.loadImage)
    }
}

struct CoinImageView_Previews: PreviewProvider {
    static var previews: some View {
        CoinImageView(service: CoinImageService(manager: ImageManager()), store: LocalFileManager(), coin: dev.coin)
            .padding()
            .previewLayout(.sizeThatFits)
    }
}
