//
//  BaseCoordinatorProtocol.swift
//  UiLuxury_TeamProject
//
//  Created by Юрий Куринной on 02.04.2024.
//

import UIKit

// MARK: - BaseCoordinatorProtocol

/// Протокол главного координатора
protocol BaseCoordinatorProtocol {
    
    /// Переход на игровые сцены
    func moveToGame()
}

// MARK: - BaseCoordinator

/// Основной координатор, через который происходит запуск приложения
final class BaseCoordinator: CoordinatorProtocol {
    
    // MARK: Public properties
    var childCoordinators: [CoordinatorProtocol]? = []
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
}

extension BaseCoordinator: BaseCoordinatorProtocol {
    
    /// Переход на основную сцену
    func moveToGame() {
        let child = MainCoordinator(navigationController: navigationController)
        childCoordinators?.append(child)
        child.parentCoodinator = self
        child.start()
    }
}
