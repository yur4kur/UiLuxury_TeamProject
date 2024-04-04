//
//  MainCoordinator.swift
//  UiLuxury_TeamProject
//
//  Created by Юрий Куринной on 03.04.2024.
//

import UIKit

// MARK: - MainCoordinator

/// Координатор таббара, объединяещего основные сцены
final class MainCoordinator: TabBarCoordinatorProtocol {
    
    // MARK: Public properties
    var userData: UserDataTransferProtocol
    var childCoordinators: [CoordinatorProtocol]? = []
    var tabControllers: [UIViewController] = []
    var navigationController: UINavigationController
    var parentCoodinator: CoordinatorProtocol?
    
    
    // MARK: Initializers
    init(navigationController: UINavigationController, userData: UserDataTransferProtocol) {
        self.navigationController = navigationController
        self.userData = userData
    }
    
    // MARK: Public methods
    func start() {
        setupTabControllers()
        let gameTabBarVC = MainTabBarController(userData: userData, coordinator: self)
        navigationController.pushViewController(gameTabBarVC, animated: true)
    }
    
    func setupTabControllers() {
        let gameChild = GameCoordinator(
            userData: userData,
            parentCoodinator: self,
            navigationController: navigationController
        )
        childCoordinators?.append(gameChild)
        gameChild.parentCoodinator = self
        gameChild.start()
    }
}
