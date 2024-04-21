//
//  Constants.swift
//  FreedomFinance
//
//  Created by Кожевников Константин on 20.04.2024.
//

import Foundation

enum Constants: String {
    /// Global url for WebSocketService
    case webSocketURL = "wss://wss.tradernet.com"
    case quotesImagesURL = "https://tradernet.com/logos/get-logo-by-ticker?ticker="
    /// Global stockIndexes for WebSocketService
    static let stocksIndexes = [
        "SP500.IDX", "AAPL.US", "RSTI", "GAZP", "MRKZ", "RUAL", "HYDR",
        "MRKS", "SBER", "FEES", "TGKA", "VTBR", "ANH.US", "VICL.US", "BURG.US",
        "NBL.US", "YETI.US", "WSFS.US", "NIO.US", "DXC.US", "MIC.US", "HSBC.US",
        "EXPN.EU", "GSK.EU", "SHP.EU", "MAN.EU", "DB1.EU", "MUV2.EU", "TATE.EU",
        "KGF.EU", "MGGT.EU", "SGGD.EU"
    ]
    
}
