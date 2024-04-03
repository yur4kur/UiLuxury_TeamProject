//
//  MainCoordinator.swift
//  UiLuxury_TeamProject
//
//  Created by Юрий Куринной on 03.04.2024.
//

import UIKit

// MARK: - MainCoordinator

/// Координатор таббара, объединяещего основные сцены
final class MainCoordinator: MainCoordinatorProtocol {
    
    // MARK: Public properties
    var userData: UserDataTransferProtocol
    var childCoordinators = [CoordinatorProtocol]()
    var navigationController: UINavigationController
    weak var parentCoordinator: BaseCoordinator?
    
    // MARK: Initializers
    init(navigationController: UINavigationController, userData: UserDataTransferProtocol) {
        self.navigationController = navigationController
        self.userData = userData
    }
    
    // MARK: Public methods
    func start() {
        let gameTabBarVC = MainTabBarController(userData: userData)
        navigationController.pushViewController(gameTabBarVC, animated: true)
    }
}
