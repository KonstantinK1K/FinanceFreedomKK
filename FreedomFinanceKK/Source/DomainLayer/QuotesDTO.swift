import Foundation

struct QuoteDTO: Codable {
    let ticker: String?  // Ticker
    let exchange: String?  // Exchange of the latest trade
    let securityName: String?  // Name of security
    let latinSecurityName: String?  // Security name in Latin
    let bestBidPrice: Double?  // Best bid
    let bestBidChange: String?  // Designations of the best bid changes ('' – no changes, 'D' - down, 'U' - up)
    let bestBidSize: Double?  // Best bid size
    let bestBidVolume: Double?  // Best bid volume
    let bestOfferPrice: Double?  // Best offer
    let bestOfferChange: String?  // Best offer change mark ('' unchanged, 'D' down, 'U' up)
    let bestOfferSize: Double?  // Value (size) of the best offer
    let bestOfferVolume: Double?  // Volume of the best offer
    let previousClose: Double?  // Previous closing
    let openingPrice: Double?  // Opening price of the current trading session
    let lastTradePrice: Double?  // Last trade price
    let lastTradeSize: Double?  // Last trade size
    let lastTradeTime: String?  // Time of last trade
    let priceChange: Double?  // Change in the price of the last trade in points, relative to the closing price of the previous trading session
    let percentChange: Double?  // Percentage change relative to the closing price of the previous trading session
    let priceChangeDesignation: String?  // Designations of price change ('' – no changes, 'D' - down, 'U' - up)
    let minTradePrice: Double?  // Minimum trade price per day
    let maxTradePrice: Double?  // Maximum trade price per day
    let tradeVolume: Double?  // Trade volume per day, in pcs
    let tradingVolume: Double?  // Trading volume per day in currency
    let yieldToMaturity: Double?  // Yield to maturity (for bonds)
    let accumulatedCouponInterest: Double?  // Accumulated coupon interest (ACI)
    let faceValue: Double?  // Face value
    let paymentDate: String?  // Payment Date
    let coupon: Double?  // Coupon, in the currency
    let couponPeriod: Double?  // Coupon period (in days)
    let nextCouponDate: String?  // Next coupon date
    let latestCouponDate: Double?  // Latest coupon date
    let purchaseMargin: Double?  // Purchase margin
    let shortSaleMargin: Double?  // Short sale margin
    let numberOfTrades: Int?  // Number of trades
    let minPriceIncrement: Double?  // Minimum price increment
    let priceIncrement: Double?  // Price increment

    enum CodingKeys: String, CodingKey {
        case ticker = "c"
        case exchange = "ltr"
        case securityName = "name"
        case latinSecurityName = "name2"
        case bestBidPrice = "bbp"
        case bestBidChange = "bbc"
        case bestBidSize = "bbs"
        case bestBidVolume = "bbf"
        case bestOfferPrice = "bap"
        case bestOfferChange = "bac"
        case bestOfferSize = "bas"
        case bestOfferVolume = "baf"
        case previousClose = "pp"
        case openingPrice = "op"
        case lastTradePrice = "ltp"
        case lastTradeSize = "lts"
        case lastTradeTime = "ltt"
        case priceChange = "chg"
        case percentChange = "pcp"
        case priceChangeDesignation = "ltc"
        case minTradePrice = "mintp"
        case maxTradePrice = "maxtp"
        case tradeVolume = "vol"
        case tradingVolume = "vlt"
        case yieldToMaturity = "yld"
        case accumulatedCouponInterest = "acd"
        case faceValue = "fv"
        case paymentDate = "mtd"
        case coupon = "cpn"
        case couponPeriod = "cpp"
        case nextCouponDate = "ncd"
        case latestCouponDate = "ncp"
        case purchaseMargin = "dpd"
        case shortSaleMargin = "dps"
        case numberOfTrades = "trades"
        case minPriceIncrement = "min_step"
        case priceIncrement = "step_price"
    }
}
