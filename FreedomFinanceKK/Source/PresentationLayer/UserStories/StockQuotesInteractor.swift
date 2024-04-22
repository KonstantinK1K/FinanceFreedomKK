//
//  StockQuotesInteractor.swift
//  FreedomFinance
//
//  Created by Кожевников Константин on 20.04.2024.
//

import Foundation

protocol StockQuotesInteractorDelegate: AnyObject {
    func didReceiveQuotes(_ quotes: QuoteDTO)
    func didReceiveError(_ error: Error)
    func didDisconnect()
}

protocol StockQuotesInteractorProtocol: AnyObject {
    var delegate: StockQuotesInteractorDelegate? { get set }
    func fetchQuotes()
}

final class StockQuotesInteractor: StockQuotesInteractorProtocol {
    weak var delegate: StockQuotesInteractorDelegate?
    private let webSocketService: WebSocketServiceProtocol

    init(webSocketService: WebSocketServiceProtocol) {
        self.webSocketService = webSocketService
        self.webSocketService.delegate = self
    }

    func fetchQuotes() {
        webSocketService.connect()
    }
}

// MARK: - WebSocketServiceDelegate

extension StockQuotesInteractor: WebSocketServiceDelegate {
    func didReceiveRealtimeQuotes(_ receivedQuotes: QuoteDTO) {
        delegate?.didReceiveQuotes(receivedQuotes)
    }

    func didReceiveError(_ error: Error) {
        delegate?.didReceiveError(error)
    }

    func didDisconnect() {
        delegate?.didDisconnect()
    }
}
