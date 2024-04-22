//
//  StockQuotesController.swift
//  FreedomFinance
//
//  Created by Кожевников Константин on 20.04.2024.
//

import UIKit

protocol StockQuotesViewProtocol: AnyObject {
    func receivedQuotes(_ receivedQuote: QuoteDTO)
    func receivedError(_ error: Error)
    func didDisconnected()
}

final class StockQuotesController: UIViewController {

    // MARK: - Property

    private let presenter: StockQuotesPresenterProtocol

    private var quotesCollection: [QuoteDTO] = []

    // MARK: - UI

    private lazy var contentView: StockQuotesView = {
        let view = StockQuotesView()
        view.tableView.dataSource = self
        view.tableView.register(QuotesListCell.self, forCellReuseIdentifier: QuotesListCell.identifier)
        view.tableView.estimatedRowHeight = Constants.rowHeight
        return view
    }()

    // MARK: - Init

    init(presenter: StockQuotesPresenterProtocol) {
        self.presenter = presenter
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Lifecycle

    override func loadView() {
        self.view = contentView
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        presenter.viewDidLoad(view: self)
    }
}

// MARK: - StockQuotesViewProtocol

extension StockQuotesController: StockQuotesViewProtocol {
    func receivedQuotes(_ receivedQuote: QuoteDTO) {
        DispatchQueue.main.async {
            // Make a copy of the collection before using it in the closure
            var quotesCopy = self.quotesCollection

            if let index = quotesCopy.firstIndex(where: { $0.ticker == receivedQuote.ticker }) {
                // If a quote with the same ticker exists, update it with receivedQuote
                let indexPath = IndexPath(row: index, section: 0)
                if let cell = self.contentView.tableView.cellForRow(at: indexPath) as? QuotesListCell {
                    cell.tradesViewModel = .init(data: receivedQuote)
                }
            } else {
                // If no quote with the same ticker exists, append receivedQuote to quotesCollection
                quotesCopy.append(receivedQuote)
                self.quotesCollection = quotesCopy // Обновляем основную коллекцию
                let indexPath = IndexPath(row: self.quotesCollection.count - 1, section: 0)
                self.contentView.tableView.insertRows(at: [indexPath], with: .automatic)
            }
        }
    }

    func receivedError(_ error: Error) {
        showAlert(message: error.localizedDescription)
    }

    func didDisconnected() {
        showAlert(title: Constants.disconnectedTitle, message: Constants.disconnectedMessage)
    }
}

// MARK: - UITableViewDataSource

extension StockQuotesController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        quotesCollection.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard
            let viewModel = quotesCollection[safe: indexPath.row],
            let cell = tableView.dequeueReusableCell(
                withIdentifier: QuotesListCell.identifier,
                for: indexPath
            ) as? QuotesListCell
        else {
            return .init()
        }
        
        cell.viewModel = .init(from: viewModel)
        return cell
    }
}

// MARK: - Constants

private extension StockQuotesController {
    enum Constants {
        static let rowHeight: CGFloat = 44
        static let disconnectedTitle: String = "Сеанс веб-сокета завершен"
        static let disconnectedMessage: String = "Сеанс веб-сокета был закрыт"
    }
}
