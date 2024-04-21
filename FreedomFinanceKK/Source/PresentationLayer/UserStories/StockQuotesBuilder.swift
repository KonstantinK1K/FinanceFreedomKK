//
//  StockQuotesBuilder.swift
//  FreedomFinance
//
//  Created by Кожевников Константин on 20.04.2024.
//

import Foundation
import UIKit

final class StockQuotesBuilder: ModuleBuilderProtocol {
    func build() -> UIViewController {
        let networkService: WebSocketServiceProtocol = WebSocketService(tickers: Constants.stocksIndexes)
        let interactor: StockQuotesInteractorProtocol = StockQuotesInteractor(webSocketService: networkService)
        let presenter: StockQuotesPresenterProtocol = StockQuotesPresenter(interactor: interactor)
        let viewController = StockQuotesController(presenter: presenter)
        return viewController
    }
}
