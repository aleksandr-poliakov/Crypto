//
//  PreviewProvider+Extensions.swift
//  CryptoWallet
//
//  Created by Aleksandr on 16.10.2022.
//

import SwiftUI

extension PreviewProvider {
    static var dev: DeveloperPreview {
        return DeveloperPreview.instance
    }
}

class DeveloperPreview {
    static let instance = DeveloperPreview()
    private init() {}

    let homeViewModel = HomeViewModel(service: CoinDataService(manager: NetworkManager()))
    
    let coin = CoinModel(id: "bitcoin", symbol: "btc", name: "Bitcoin", image: "https://assets.coingecko.com/coins/images/1/large/bitcoin.png?1547033579", currentPrice: 19141.25, marketCap: 367111585133, marketCapRank: 1, fullyDilutedValuation: 401929702596, high24H: 12387988153, low24H: 19194.78, priceChange24H: 19030.3, priceChangePercentage24H: -13.256947643159947, totalVolume: -0.06921, marketCapChange24H: -202542808.40411377, marketCapChangePercentage24H: -0.05514, circulatingSupply: 19180825, totalSupply: 21000000, maxSupply: 21000000, ath: 69045, athChangePercentage: -72.28442, athDate: "2021-11-10T14:24:11.849Z", atl: 67.81, atlChangePercentage: 28120.67813, atlDate: "2013-07-06T00:00:00.000Z", lastUpdated: "2022-10-16T11:55:03.246Z", sparklineIn7D: SparklineIn7D(price: [
        19409.815660718283,
        19432.52357570095,
        19417.812043576265,
        19392.857079033794,
        19419.3110013487,
        19448.573369317768,
        19476.83715483821,
        19493.5919103997,
        19492.97481496653,
        19526.95683762805,
        19538.645102325067,
        19508.47986809752,
        19507.74732132686,
        19503.271603147754,
        19465.042466311086,
        19480.583197426084,
        19460.935211750042,
        19431.764534258986,
        19435.52286156838,
        19446.74373818419,
        19505.90837096838,
        19471.866733153704,
        19443.480391776277,
        19474.756431916227,
        19406.73317945203,
        19390.384608648572,
        19426.356493454867,
        19235.368641319732,
        19345.037751257107,
        19304.647722802234,
        19338.367620235498,
        19395.47751336837,
        19325.749994852926,
        19252.7182488222,
        19280.690474449875,
        19202.755865444997,
        19350.334501131296,
        19225.483589606276,
        19223.734035640016,
        19234.29096816081,
        19248.997333072206,
        19139.30435088603,
        19142.694767392895,
        19034.26720085647,
        19034.30601534245,
        19053.599421973064,
        19051.31473685178,
        19037.57059279476,
        19034.4383690935,
        19091.6269348179,
        19085.27144244422,
        19108.810541210387,
        19054.283774289655,
        19092.77876574269,
        19171.655564781715,
        19201.583301663635,
        19037.407234421848,
        19061.206895058636,
        19174.818522482725,
        19173.263132235006,
        19135.67041479007,
        18987.39456328482,
        19015.014240340613,
        19045.06906500067,
        19007.62151304678,
        19046.649855944896,
        19060.702787263657,
        19105.29072311209,
        19046.22520788986,
        19050.729526015628,
        19052.305216194192,
        19104.047086682574,
        19120.268936075263,
        19154.96528273976,
        19104.156406139027,
        19124.597561205414,
        19184.24246653704,
        19159.73617610957,
        19140.389317494613,
        19079.946722159904,
        19133.682874183673,
        19100.722388641716,
        19126.127168673745,
        19105.136176725508,
        19076.105092736812,
        19125.671773240694,
        19144.654323896044,
        19147.91831047318,
        19187.53482170786,
        19169.4668694631,
        19152.894115946925,
        19142.083282468786,
        19104.06923230991,
        19069.122556127437,
        19091.685527894424,
        19088.43394166963,
        19102.07282164791,
        19052.79146011756,
        19000.771852818132,
        19013.98771232447,
        18971.82673690142,
        18668.43800740156,
        18738.263946389867,
        18372.467618415467,
        18446.249615209843,
        18549.44265006655,
        18956.623314261615,
        19134.293272681512,
        19162.663441529963,
        19345.901532300853,
        19375.0203223811,
        19397.389414660393,
        19417.047285905723,
        19416.431533390813,
        19387.465655359778,
        19427.734142614256,
        19872.748771742114,
        19805.44241393039,
        19823.376419821096,
        19813.481685955197,
        19821.016580012627,
        19806.69659633123,
        19647.43647008476,
        19608.08701544435,
        19636.059682552885,
        19673.63445597292,
        19626.356692909318,
        19781.891386388746,
        19637.695106066705,
        19458.010823013457,
        19371.36102851284,
        19312.78233347125,
        19353.72195104118,
        19198.915511839783,
        19223.57423056235,
        19185.19560060955,
        19117.960836598,
        19154.821364062154,
        19194.643188187696,
        19191.380029580385,
        19185.36217018641,
        19191.564672626537,
        19204.30682173264,
        19189.26628490064,
        19174.704931240896,
        19169.195344893793,
        19161.585767515764,
        19106.192369174474,
        19107.401071335673,
        19148.979193562485,
        19155.117811593547,
        19182.69153042117,
        19126.116118137073,
        19147.511212753012,
        19133.660229066776,
        19130.72198492508,
        19109.447580075503,
        19128.201866565036,
        19101.504982458206,
        19095.300858664385,
        19074.771421880847,
        19072.122652041628,
        19072.780513358884,
        19126.552320075007,
        19149.61908538506,
        19119.86185208045,
        19123.185811934487,
        19142.80280327335
    ]), priceChangePercentage24HInCurrency: 3952.64, currentHoldings: 1.5)
}
