//
//  GameTabBarCoordinator.swift
//  UiLuxury_TeamProject
//
//  Created by Юрий Куринной on 03.04.2024.
//

import UIKit

/// Основной координатор, через который происходит запуск приложения
final class GameTabBarCoordinator: CoordinatorProtocol {
    var childCoordinators = [CoordinatorProtocol]()
    var navigationController: UINavigationController
    
    weak var parent: MainCoordinator?
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func start() {
        let gameTabBarVC = GameTabBarController(userData: StartViewModel())
        navigationController.pushViewController(gameTabBarVC, animated: true)
    }
}
