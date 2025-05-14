//
//  CoinModel.swift
//  CryptoApp
//
//  Created by Jan on 14/05/2025.
//

import Foundation

/*
 {
   "id": "bitcoin",
   "symbol": "btc",
   "name": "Bitcoin",
   "image": "https://coin-images.coingecko.com/coins/images/1/large/bitcoin.png?1696501400",
   "current_price": 103743,
   "market_cap": 2060729257190,
   "market_cap_rank": 1,
   "fully_diluted_valuation": 2060734132938,
   "total_volume": 33042362698,
   "high_24h": 104836,
   "low_24h": 103108,
   "price_change_24h": 216.78,
   "price_change_percentage_24h": 0.2094,
   "market_cap_change_24h": 4581511657,
   "market_cap_change_percentage_24h": 0.22282,
   "circulating_supply": 19864496,
   "total_supply": 19864543,
   "max_supply": 21000000,
   "ath": 108786,
   "ath_change_percentage": -4.65183,
   "ath_date": "2025-01-20T09:11:54.494Z",
   "atl": 67.81,
   "atl_change_percentage": 152866.43325,
   "atl_date": "2013-07-06T00:00:00.000Z",
   "roi": null,
   "last_updated": "2025-05-14T11:01:18.016Z",
   "sparkline_in_7d": {
     "price": [
       96538.03334234984,
       96925.96210528578,
       97003.63646893593,
       96986.15290872475,
       96986.48455649219,
       97017.36703189345,
       96968.99773463995,
       97041.28165831216,
       96946.47681288401,
       96941.07608759051,
       96863.98868038424,
       96212.81842184125,
       96306.502609734,
       96148.7571218679,
       96623.98416478802,
       97096.195573126,
       97277.49264928911,
       97035.80181467332,
       97921.8716635437,
       97950.20260938423,
       98712.46826631304,
       99037.21087966081,
       99095.08778875701,
       98684.10898485525,
       98990.04978777783,
       99109.17249310363,
       99645.29105191333,
       99763.50394686138,
       99810.2089598869,
       99572.56913879959,
       99380.82080975642,
       99445.01176371268,
       99883.30449934515,
       101783.94854609821,
       101397.34207827682,
       101112.06155180026,
       101327.33984258387,
       101156.28787384083,
       102715.70496819356,
       102898.7842378539,
       102946.60364931433,
       103155.55403424997,
       102755.01416938983,
       102981.92071790314,
       102602.6120856411,
       102431.38593811914,
       102735.23542016957,
       102936.7074812753,
       103654.43206932151,
       103775.85199443038,
       102941.5958896605,
       102847.4715321015,
       102942.94358657954,
       102928.84977016224,
       103635.59449072609,
       103081.79586234059,
       102895.00436299198,
       102560.61383641983,
       103192.42776451155,
       103241.92605940854,
       103117.03623118934,
       103209.3836430422,
       102977.49681924479,
       102827.52654028965,
       102974.90755054186,
       102888.53800348293,
       102993.94386197541,
       103150.34151496418,
       103193.12967175669,
       103175.63967376802,
       103323.707007908,
       103720.78075770468,
       103706.99371868216,
       103647.04618455893,
       103783.45760307356,
       103642.37117207838,
       103429.18395096257,
       103695.96296897363,
       103662.34239531834,
       103553.53694440117,
       103271.5104798415,
       103416.84977404175,
       103297.10860505837,
       103282.46567689025,
       103258.47973237954,
       103226.68575713312,
       103662.83631460686,
       103660.87510929449,
       104710.18767116882,
       104407.56428821298,
       104032.49982304672,
       103754.34752451746,
       104056.37170558948,
       104155.90999828055,
       103870.8841579018,
       103829.80918775442,
       103593.91838549759,
       103851.88885800124,
       104334.48684183184,
       104548.72450789883,
       104596.7005862239,
       104642.10789268535,
       104172.25933546464,
       104190.60953809322,
       104154.20587019669,
       103961.02518029482,
       104038.3347814099,
       104565.14537131102,
       104461.60521897068,
       104294.14065447195,
       104332.65737615807,
       103785.595389775,
       104083.02280094857,
       104632.60236125204,
       104010.92730451525,
       103878.99122372338,
       104025.9851010989,
       104015.37994237608,
       103922.92947191757,
       104385.93976669859,
       104345.64506752802,
       104580.96675487966,
       104442.91913640256,
       104427.94756195355,
       103839.45870520416,
       103996.90080969327,
       104265.08276082827,
       102956.96335456427,
       102540.50604756521,
       102896.58742159072,
       102638.94133473857,
       101758.10895980781,
       101821.24819695739,
       102722.17829371417,
       102535.07438971548,
       102853.64407073468,
       102822.91679502407,
       102341.3693907083,
       102438.5006522079,
       102023.67064825837,
       101749.06016032975,
       102691.31422765224,
       102374.73819318778,
       102502.1318967532,
       102663.9087874314,
       102737.32382836587,
       103476.25686228045,
       103528.56498547425,
       103711.10493023827,
       103723.99690271963,
       103707.01836525789,
       103122.1652700943,
       103635.82838474064,
       103860.8913290485,
       104193.24996458978,
       104303.9664067448,
       104778.26218485396,
       104595.44088503523,
       104328.02983968919,
       104235.96595683586,
       104184.49039270742,
       103917.7359966492,
       103858.60396107004,
       103700.05269875677,
       103556.45885636128,
       103700.90096775675
     ]
   },
   "price_change_percentage_24h_in_currency": 0.20939547349966472
 }
 */

/*
 https://apl.coingecko.com/api/v3/coins/markets?vs_currency=usd&order-market_cap_desc&per_page=2506page=16spErkLine=truesprice_change_percentage=24h
 */

struct CoinModel: Identifiable, Codable {
    let id, symbol, name: String
    let image: String
    let currentPrice : Double
    let marketCap, marketCapRank, fullyDilutedValuation: Double?
    let totalVolume, high24H, low24H: Double?
    let priceChange24H, priceChangePercentage24H: Double?
    let marketCapChange24H: Double?
    let marketCapChangePercentage24H: Double?
    let circulatingSupply, totalSupply, maxSupply, ath: Double?
    let athChangePercentage: Double?
    let athDate: String?
    let atl, atlChangePercentage: Double?
    let atlDate: String?
//    let roi: NSNull?
    let lastUpdated: String?
    let sparklineIn7D: SparklineIn7D?
    let priceChangePercentage24HInCurrency: Double?
    let currentHoldings: Double?
    
    enum CodingKeys: String, CodingKey{
        case id, symbol, name, image
        case currentPrice = "current_price"
        case marketCap = "market_cap"
        case marketCapRank = "market_cap_rank"
        case fullyDilutedValuation = "fully_diluted_valuation"
        case totalVolume = "total_volume"
        case high24H = "high_24h"
        case low24H = "low_24h"
        case priceChange24H = "price_change_24h"
        case priceChangePercentage24H = "price_change_percentage_24h"
        case marketCapChange24H = "market_cap_change_24h"
        case marketCapChangePercentage24H = "market_cap_change_percentage_24h"
        case circulatingSupply = "circulating_supply"
        case totalSupply = "total_supply"
        case maxSupply = "max_supply"
        case ath = "ath"
        case athChangePercentage = "ath_change_percentage"
        case athDate = "ath_date"
        case atl = "atl"
        case atlChangePercentage = "atl_change_percentage"
        case atlDate = "atl_date"
//        case roi
        case lastUpdated = "last_updated"
        case sparklineIn7D = "sparkline_in_7d"
        case priceChangePercentage24HInCurrency = "price_change_percentage_24h_in_currency"
        case currentHoldings
        
    }
    
    func updateHoldings(amount: Double) -> CoinModel{
        return CoinModel(id: id, symbol: symbol, name: name, image: image, currentPrice: currentPrice, marketCap: marketCap, marketCapRank: marketCapRank, fullyDilutedValuation: fullyDilutedValuation, totalVolume: totalVolume, high24H: high24H, low24H: low24H, priceChange24H: priceChange24H, priceChangePercentage24H: priceChangePercentage24H, marketCapChange24H: marketCapChange24H, marketCapChangePercentage24H: marketCapChangePercentage24H, circulatingSupply: circulatingSupply, totalSupply: totalSupply, maxSupply: maxSupply, ath: ath, athChangePercentage: athChangePercentage, athDate: athDate, atl: atl, atlChangePercentage: atlChangePercentage, atlDate: athDate, lastUpdated: lastUpdated, sparklineIn7D: sparklineIn7D, priceChangePercentage24HInCurrency: priceChangePercentage24HInCurrency, currentHoldings: amount)
    }
    
    var currentHoldingsValue: Double{
        return (currentHoldings ?? 0) * currentPrice
    }
    
    var rank: Int{
        return Int(marketCapRank ?? 0)
    }
}

struct SparklineIn7D: Codable {
    let price: [Double]?
}
