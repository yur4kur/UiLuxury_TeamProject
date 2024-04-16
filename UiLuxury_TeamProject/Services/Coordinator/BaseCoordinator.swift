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
    func moveToGame(dataManager: DataManagerProtocol)
}

// MARK: - BaseCoordinator

/// Основной координатор, через который происходит запуск приложения
final class BaseCoordinator: CoordinatorProtocol {
    
    // MARK: Public properties
    var childCoordinators: [CoordinatorProtocol]? = []
    var navigationController: UINavigationController
    var dataManager = DataManager()

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
    func moveToGame(dataManager: DataManagerProtocol) {
        let child = MainCoordinator(navigationController: navigationController, dataManager: dataManager)
        childCoordinators?.append(child)
        child.parentCoodinator = self
        child.start()
    }
}
