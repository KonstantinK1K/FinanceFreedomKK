//
//  AppCoordinator.swift
//  FreedomFinance
//
//  Created by Кожевников Константин on 20.04.2024.
//

import UIKit

protocol AppCoordinatorProtocol: AnyObject {
    func start() -> UIViewController
}

final class AppCoordinator: AppCoordinatorProtocol {

    // MARK: - Property

    private weak var window: UIWindow?

    // MARK: - Init

    init(window: UIWindow?) {
        self.window = window
    }

    func start() -> UIViewController {
        return createStockModule()
    }
}

private extension AppCoordinator {
    func createStockModule() -> UIViewController {
        let assembly = StockQuotesBuilder()
        let module = assembly.build()
        return module
    }
}
