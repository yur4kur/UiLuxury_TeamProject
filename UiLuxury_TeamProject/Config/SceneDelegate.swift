//
//  SceneDelegate.swift
//  UiLuxury_TeamProject
//
//  Created by Юрий Куринной on 27.07.2023.
//

import UIKit

// MARK: - SceneDelegate

final class SceneDelegate: UIResponder, UIWindowSceneDelegate {
    
    // MARK: - Public properties
    
    var window: UIWindow?
    
    // MARK: - Public methods
    
    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let windowScene = (scene as? UIWindowScene) else { return }
        window = UIWindow(frame: windowScene.coordinateSpace.bounds)
        window?.windowScene = windowScene
        window?.rootViewController = StartViewController()
        window?.makeKeyAndVisible()
    }
}

