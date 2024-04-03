//
//  Coordinator.swift
//  UiLuxury_TeamProject
//
//  Created by Юрий Куринной on 02.04.2024.
//

import UIKit

/// Основной координатор, через который происходит запуск приложения
final class MainCoordinator: CoordinatorProtocol {
    var childCoordinators = [CoordinatorProtocol]()
    var navigationController: UINavigationController
    
    

    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }

    func start() {
        let startVC = StartViewController(coordinator: self)
        navigationController.pushViewController(startVC, animated: false)
    }
    
    func moveToGame() {
        let child = GameTabBarCoordinator(navigationController: navigationController)
        childCoordinators.append(child)
        child.parent = self
        child.start()
    }
}
