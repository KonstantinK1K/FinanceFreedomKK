//
//  StockQuotesPresenter.swift
//  FreedomFinance
//
//  Created by Кожевников Константин on 20.04.2024.
//

import Foundation

protocol StockQuotesPresenterProtocol: AnyObject {
    func viewDidLoad(view: StockQuotesViewProtocol)
}

final class StockQuotesPresenter {
    private var view: StockQuotesViewProtocol?
    private var interactor: StockQuotesInteractorProtocol?

    init(interactor: StockQuotesInteractorProtocol) {
        self.interactor = interactor
        self.interactor?.delegate = self
    }
}

// MARK: - StockQuotesPresenterProtocol

extension StockQuotesPresenter: StockQuotesPresenterProtocol {
    func viewDidLoad(view: StockQuotesViewProtocol) {
        self.view = view
        interactor?.fetchQuotes()
    }
}

// MARK: - StockQuotesInteractorDelegate

extension StockQuotesPresenter: StockQuotesInteractorDelegate {
    func didReceiveQuotes(_ quotes: QuoteDTO) {
        view?.receivedQuotes(quotes)
    }

    func didReceiveError(_ error: Error) {
        view?.receivedError(error)
    }

    func didDisconnect() {
        view?.didDisconnected()
    }
}
