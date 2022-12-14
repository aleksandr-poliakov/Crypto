//
//  HomeView.swift
//  CryptoWallet
//
//  Created by Aleksandr on 16.10.2022.
//

import SwiftUI

struct HomeView: View {
    
    @StateObject private var viewModel: HomeViewModel
    @State private var showPortfolio: Bool = false
    
    init(coinService: CoinDataServiceProtocol, marketService: MarketDataServiceProtocol, showPortfolio: Bool) {
        self.showPortfolio = showPortfolio
        self._viewModel = StateObject(wrappedValue: HomeViewModel(coinService: coinService, marketService: marketService))
    }
    
    var body: some View {
        ZStack {
            Color.theme.background
                .ignoresSafeArea()
            
            VStack {
                header
                
                HomeStatsView(viewModel: StateObject(wrappedValue: viewModel),
                              showPortfolio: $showPortfolio)
                SearchBarView(text: $viewModel.searchText)
                
                columnTitles
                
                if !showPortfolio {
                    allCoins
                        .transition(.move(edge: .leading))
                } else {
                    portfolioCoins
                        .transition(.move(edge: .trailing))
                }
                
                Spacer()
            }
        }.onAppear(perform: viewModel.loadCoins)
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            HomeView(coinService: CoinDataService(manager: CoinManager()),
                     marketService: MarketDataService(manager: MarketManager()),
                     showPortfolio: false)
                .navigationBarHidden(true)
        }
    }
}

// MARK: - Header

extension HomeView {
    private var header: some View {
        HStack {
            CircleButtonView(iconString: showPortfolio ? "plus" : "info")
                .animation(.none, value: 0)
                .background(
                    CircleButtonAnimationView(animate: $showPortfolio)
                )
            Spacer()
            Text(showPortfolio ? "Portfolio" : "Crypto")
                .font(.headline)
                .fontWeight(.heavy)
                .foregroundColor(Color.theme.accent)
                .animation(.none)
            Spacer()
            CircleButtonView(iconString: "chevron.right")
                .rotationEffect(Angle(degrees: showPortfolio ? 180 : 0))
                .onTapGesture {
                    withAnimation(.spring()) {
                        showPortfolio.toggle()
                    }
                }
        }
        .padding(.horizontal)
    }
    
    private var allCoins: some View {
        List(viewModel.allCoins) { coin in
            CoinRowView(coin: coin, showHoldings: false)
                .listRowInsets(EdgeInsets(top: 10, leading: .zero, bottom: 10, trailing: 10))
        }
        .listStyle(.plain)
    }
    
    private var portfolioCoins: some View {
        List(viewModel.portfolioCoins) { coin in
            CoinRowView(coin: coin, showHoldings: true)
                .listRowInsets(EdgeInsets(top: 10, leading: .zero, bottom: 10, trailing: 10))
        }
        .listStyle(.plain)
    }
    
    private var columnTitles: some View {
        HStack {
            Text("Coin")
            Spacer()
            if showPortfolio {
                Text("Holdings")
            }
            Text("Price")
                .frame(width: UIScreen.main.bounds.width / 3.5, alignment: .trailing)
        }
        .font(.caption)
        .foregroundColor(Color.theme.secondaryText)
        .padding(.horizontal)
    }
}
