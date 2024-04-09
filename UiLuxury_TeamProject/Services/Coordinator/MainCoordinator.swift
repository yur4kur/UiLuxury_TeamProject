//
//  MainCoordinator.swift
//  UiLuxury_TeamProject
//
//  Created by Юрий Куринной on 03.04.2024.
//

import UIKit

// MARK: - MainCoordinatorProtocol

/// Протокол координатора таббара основной сцены
protocol MainCoordinatorProtocol: CoordinatorProtocol {
    
    /// Данные пользователя из стартовой вью-модели
    var userData: UserDataTransferProtocol { get set }
    
    /// Экземпляр родительского координатора
    var parentCoodinator: CoordinatorProtocol? { get }
    
    /// Контроллеры таббара
    var tabControllers: [String: UIViewController] { get set }
}

// MARK: - MainCoordinator

/// Координатор таббара, объединяещего основные сцены
final class MainCoordinator: MainCoordinatorProtocol {
    
    // MARK: Public properties
    var userData: UserDataTransferProtocol
    var childCoordinators: [CoordinatorProtocol]? = []
    var tabControllers: [String: UIViewController] = [:]
    var navigationController: UINavigationController
    var parentCoodinator: CoordinatorProtocol?
    
    
    // MARK: Initializers
    init(navigationController: UINavigationController, userData: UserDataTransferProtocol) {
        self.navigationController = navigationController
        self.userData = userData
    }
    
    // MARK: Public methods
    func start() {
        startTabControllers()
        let gameTabBarVC = MainTabBarController(coordinator: self)
        navigationController.pushViewController(gameTabBarVC, animated: true)
    }
    
    /// Метод создает дочерние координаторы, которые стартуют контроллеры таббара. 
    /// Так происходите заполнение таббара дочерними контроллерами.
    private func startTabControllers() {
        
        let gameChild = GameCoordinator(userData: userData,
                                        parentCoodinator: self,
                                        navigationController: navigationController)
        childCoordinators?.append(gameChild)
        gameChild.parentCoodinator = self
        gameChild.start()
        
        let shopChild = ShopCoordinator(userData: userData,
                                        parentCoodinator: self,
                                        navigationController: navigationController)
        childCoordinators?.append(shopChild)
        shopChild.parentCoodinator = self
        shopChild.start()
        
        let userChild = UserCoordinator(userData: userData,
                                        parentCoodinator: self,
                                        navigationController: navigationController)
        childCoordinators?.append(userChild)
        userChild.parentCoodinator = self
        userChild.start()
        
        let devsChild = DevelopersCoordinator(userData: userData,
                                        parentCoodinator: self,
                                        navigationController: navigationController)
        childCoordinators?.append(devsChild)
        devsChild.parentCoodinator = self
        devsChild.start()
    }
}
