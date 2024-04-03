//
//  Coordinator.swift
//  UiLuxury_TeamProject
//
//  Created by Юрий Куринной on 02.04.2024.
//

import UIKit

// MARK: - BaseCoordinator

/// Основной координатор, через который происходит запуск приложения
final class BaseCoordinator: CoordinatorProtocol {
    
    // MARK: Public properties
    var childCoordinators = [CoordinatorProtocol]()
    var navigationController: UINavigationController

    // MARK: Initializers
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }

    // MARK: Public properties
    func start() {
        let startVC = StartViewController(coordinator: self)
        navigationController.pushViewController(startVC, animated: false)
    }
    
    /// Переход на основную сцену
    func moveToGame(receivedData: UserDataTransferProtocol) {
        let child = MainCoordinator(navigationController: navigationController, userData: receivedData)
        childCoordinators.append(child)
        child.parentCoordinator = self
        child.start()
    }
}
