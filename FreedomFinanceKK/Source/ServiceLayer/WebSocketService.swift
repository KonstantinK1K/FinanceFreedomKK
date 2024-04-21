//
//  NetworkService.swift
//  FreedomFinance
//
//  Created by Кожевников Константин on 20.04.2024.
//

import Foundation

protocol WebSocketServiceDelegate: AnyObject {
    func didReceiveRealtimeQuotes(_ receivedQuotes: QuoteDTO)
    func didReceiveError(_ error: Error)
    func didDisconnect()
}

protocol WebSocketServiceProtocol: AnyObject {
    var delegate: WebSocketServiceDelegate? { get set }
    var isConnected: Bool { get }

    func connect()
    func disconnect()
    func send(_ message: [Any])
}

final class WebSocketService: WebSocketServiceProtocol {

    weak var delegate: WebSocketServiceDelegate?

    // MARK: - Private property

    private var webSocketTask: URLSessionWebSocketTask?
    private let url: URL
    private let tickers: [String]
    private(set) var isConnected: Bool = false

    private lazy var jsonDecoder: JSONDecoder = {
        let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        return decoder
    }()

    // MARK: - Init

    init(tickers: [String]) {
        guard let url = URL(string: Constants.webSocketURL.rawValue) else { fatalError("Invalid WebSocket URL") }
        self.url = url
        self.tickers = tickers
        connect()
    }

    // MARK: - Public Methods

    func connect() {
        let request = URLRequest(url: url)
        webSocketTask = URLSession.shared.webSocketTask(with: request)
        webSocketTask?.resume()
        receiveMessage()
        subscribeToTickers()
    }

    func send(_ message: [Any]) {
        guard
            let jsonData = try? JSONSerialization.data(withJSONObject: message)
        else {
            delegate?.didReceiveError(WebSocketError.invalidMessage)
            return
        }

        let text = String(data: jsonData, encoding: .utf8)
        webSocketTask?.send(.string(text ?? "")) { [weak self] error in
            guard let error else { return }
            self?.delegate?.didReceiveError(error)
        }
    }

    func disconnect() {
        webSocketTask?.cancel(with: .goingAway, reason: nil)
    }
}

// MARK: - Private Methods

private extension WebSocketService {
    func subscribeToTickers() {
        let message: [Any] = ["realtimeQuotes", tickers]
        send(message)
    }

    func receiveMessage() {
        webSocketTask?.receive { [weak self] result in
            switch result {
            case let .success(message):
                guard case let .string(data) = message else { return }
                self?.handleMessage(data)
            case let .failure(error):
                self?.delegate?.didReceiveError(error)
            }
            self?.receiveMessage()
        }
    }

    func handleMessage(_ receivedData: String) {
        guard let jsonData = receivedData.data(using: .utf8), !receivedData.contains("isDemo") else { return }
        do {
            let decodedArray = try JSONSerialization.jsonObject(with: jsonData, options: []) as? [Any]

            guard
                let firstElement = decodedArray?.first as? String, firstElement == "q",
                let quoteData = decodedArray?[1] as? [String: Any] else {
                delegate?.didReceiveError(WebSocketError.unableToDecodeQuote)
                return
            }

            let quoteJsonData = try JSONSerialization.data(withJSONObject: quoteData, options: .prettyPrinted)
            let decodedQuote = try jsonDecoder.decode(QuoteDTO.self, from: quoteJsonData)
            delegate?.didReceiveRealtimeQuotes(decodedQuote)
        } catch {
            delegate?.didReceiveError(error)
        }
    }
}

