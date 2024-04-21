//
//  UIViewController+Extension.swift
//  FreedomFinanceKK
//
//  Created by Кожевников Константин on 21.04.2024.
//

import UIKit

extension UIViewController {
    func showAlert(
        title: String? = nil,
        message: String,
        completion: (() -> Void)? = nil
    ) {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "OK", style: .default) { _ in
            completion?()
        }

        alertController.addAction(okAction)
        DispatchQueue.main.async {
            UIApplication.shared.windows.first?.rootViewController?.present(
                alertController,
                animated: true,
                completion: nil
            )
        }
    }
}
