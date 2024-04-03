//
//  MainCoordinator.swift
//  UiLuxury_TeamProject
//
//  Created by Юрий Куринной on 03.04.2024.
//

import UIKit

/// Протокол координаторов основной сцены
protocol MainCoordinatorProtocol: CoordinatorProtocol {
    
    /// Данные пользователя из стартовой вью-модели
    var userData: StartViewModelProtocol { get set }
}

/// Координатор таббара, объединяещего основные сцены
final class MainCoordinator: MainCoordinatorProtocol {
    var childCoordinators = [CoordinatorProtocol]()
    var navigationController: UINavigationController
    var userData: StartViewModelProtocol
    
    weak var parentCoordinator: BaseCoordinator?
    
    init(navigationController: UINavigationController, userData: StartViewModelProtocol) {
        self.navigationController = navigationController
        self.userData = userData
    }
    
    func start() {
        let mainVM = MainViewModel(userData: userData)
        let gameTabBarVC = MainTabBarController()
        navigationController.pushViewController(gameTabBarVC, animated: true)
    }
}
