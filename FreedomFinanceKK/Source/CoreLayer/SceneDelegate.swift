//
//  SceneDelegate.swift
//  FreedomFinance
//
//  Created by Кожевников Константин on 20.04.2024.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?

    func scene(
        _ scene: UIScene,
        willConnectTo session: UISceneSession,
        options connectionOptions: UIScene.ConnectionOptions
    ) {
        guard let windowScene = (scene as? UIWindowScene) else { return }
        let window = UIWindow(windowScene: windowScene)
        let mainModule = createMainModule()
        window.rootViewController = mainModule
        window.makeKeyAndVisible()
        self.window = window
    }
}

// MARK: - Create Main Module

private extension SceneDelegate {
    func createMainModule() -> UIViewController {
        let appCoordinator = AppCoordinator(window: window)
        let mainController = appCoordinator.start()
        return mainController
    }
}

