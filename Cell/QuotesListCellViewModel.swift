//
//  QuotesListCellViewModel.swift
//  FreedomFinanceKK
//
//  Created by Кожевников Константин on 21.04.2024.
//

import Foundation

// MARK: - Cell ViewModel

struct QuotesListCellViewModel: Decodable {
    let ticker: String
    let percentChange: Double
    let exchange: String
    let securityName: String
    let lastTradePrice: Double
    let priceChange: Double?
    var imageURL: URL?
}

extension QuotesListCellViewModel {
    init(from data: QuoteDTO) {
        self.ticker = data.ticker ?? ""
        self.percentChange = data.percentChange ?? .zero
        self.exchange = data.exchange ?? ""
        self.securityName = data.securityName ?? ""
        self.priceChange = data.priceChange ?? .zero
        self.imageURL = URL(string: Constants.quotesImagesURL.rawValue + (data.ticker?.lowercased() ?? ""))

        if let minPriceIncrement = data.minPriceIncrement,
           let lastTradePrice = data.lastTradePrice {
            self.lastTradePrice = minPriceIncrement * (lastTradePrice / minPriceIncrement).rounded()
        } else {
            self.lastTradePrice = data.lastTradePrice ?? .zero
        }
    }

    static let initial = QuotesListCellViewModel(
        ticker: "",
        percentChange: 0,
        exchange: "",
        securityName: "",
        lastTradePrice: 0,
        priceChange: 0
    )
}

// MARK: - Equatable

extension QuotesListCellViewModel: Equatable {
    static func ==(lhs: QuotesListCellViewModel, rhs: QuotesListCellViewModel) -> Bool {
        return lhs.ticker == rhs.ticker &&
        lhs.percentChange == rhs.percentChange &&
        lhs.exchange == rhs.exchange &&
        lhs.securityName == rhs.securityName &&
        lhs.lastTradePrice == rhs.lastTradePrice &&
        lhs.priceChange == rhs.priceChange &&
        lhs.imageURL == rhs.imageURL
    }
}

// MARK: - Trades Info Model

struct TradesViewModel {
    let percentChange: Double?
    let lastTradePrice: Double?
    let priceChange: Double?

    init(data: QuoteDTO) {
        self.percentChange = data.percentChange
        self.lastTradePrice = data.lastTradePrice
        self.priceChange = data.priceChange
    }

    init(
        percentChange: Double,
        lastTradePrice: Double,
        priceChange: Double
    ) {
        self.percentChange = percentChange
        self.lastTradePrice = lastTradePrice
        self.priceChange = priceChange
    }

    static let initial = TradesViewModel(percentChange: 0, lastTradePrice: 0, priceChange: 0)
}

// MARK: - Equatable

extension TradesViewModel: Equatable {
    static func == (lhs: TradesViewModel, rhs: TradesViewModel) -> Bool {
        return lhs.percentChange == rhs.percentChange &&
        lhs.lastTradePrice == rhs.lastTradePrice &&
        lhs.priceChange == rhs.priceChange
    }
}

