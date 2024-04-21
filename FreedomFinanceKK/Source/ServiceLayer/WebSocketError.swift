//
//  WebSocketError.swift
//  FreedomFinanceKK
//
//  Created by Кожевников Константин on 20.04.2024.
//

import Foundation

enum WebSocketError: Error {
    case invalidURL
    case invalidMessage
    case unableToDecodeQuote

    var localizedDescription: String {
        switch self {
        case .invalidURL:
            return "Не удалось подключиться к веб-сокет сервису из-за некорректного URL"
        case .invalidMessage:
            return "Не удалось отправить сообщение на сервер"
        case .unableToDecodeQuote:
            return "Не удалось обработать полученные данные о котировке"
        }
    }
}
