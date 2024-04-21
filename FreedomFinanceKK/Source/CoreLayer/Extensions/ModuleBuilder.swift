//
//  ModuleBuilder.swift
//  FreedomFinance
//
//  Created by Кожевников Константин on 20.04.2024.
//

import UIKit

/// Main interface for building modules
protocol ModuleBuilderProtocol: AnyObject {
    func build() -> UIViewController
}
