//
//  Array+Extension.swift
//  FreedomFinanceKK
//
//  Created by Кожевников Константин on 20.04.2024.
//

import Foundation

extension Array {
    /// Safe subscript for extracting an element from an array
    ///
    /// - Parameter index: The index of the element to extract
    subscript(safe index: Index) -> Element? {
        return indices.contains(index) ? self[index] : nil
    }
}
