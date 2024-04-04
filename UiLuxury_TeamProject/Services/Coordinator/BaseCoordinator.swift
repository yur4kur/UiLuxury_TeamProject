//
//  Coordinator.swift
//  UiLuxury_TeamProject
//
//  Created by Юрий Куринной on 02.04.2024.
//

import UIKit

// MARK: - BaseCoordinatorProtocol

/// Протокол главного координатора
protocol BaseCoordinatorProtocol: CoordinatorProtocol {
    
    /// Переход на игровые сцены
    func moveToGame(receivedData: UserDataTransferProtocol)
}

// MARK: - BaseCoordinator

/// Основной координатор, через который происходит запуск приложения
final class BaseCoordinator: BaseCoordinatorProtocol {
    
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
    
    /// Переход на основную сцену
    func moveToGame(receivedData: UserDataTransferProtocol) {
        let child = MainCoordinator(navigationController: navigationController, userData: receivedData)
        childCoordinators?.append(child)
        child.parentCoodinator = self
        child.start()
    }
}
