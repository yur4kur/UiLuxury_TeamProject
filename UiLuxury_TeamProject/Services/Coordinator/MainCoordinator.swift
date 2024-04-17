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
    
    /// Экземпляр родительского координатора
    var parentCoodinator: CoordinatorProtocol? { get }
    
    /// Контроллеры таббара
    var tabControllers: [String: UIViewController] { get set }
}

// MARK: - MainCoordinator

/// Координатор таббара, объединяещего основные сцены
final class MainCoordinator: MainCoordinatorProtocol {
    
    // MARK: Public properties
    var dataManager: DataManagerProtocol
    var childCoordinators: [CoordinatorProtocol]? = []
    var tabControllers: [String: UIViewController] = [:]
    var navigationController: UINavigationController
    var parentCoodinator: CoordinatorProtocol?
    
    
    // MARK: Initializers
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
        self.dataManager = DataManager()
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
        
        let gameChild = GameCoordinator(dataManager: dataManager,
                                        parentCoodinator: self,
                                        navigationController: navigationController)
        childCoordinators?.append(gameChild)
        gameChild.parentCoodinator = self
        gameChild.start()
        
        let shopChild = ShopCoordinator(dataManager: dataManager,
                                        parentCoodinator: self,
                                        navigationController: navigationController)
        childCoordinators?.append(shopChild)
        shopChild.parentCoodinator = self
        shopChild.start()
        
        let userChild = UserCoordinator(dataManager: dataManager,
                                        parentCoodinator: self,
                                        navigationController: navigationController)
        childCoordinators?.append(userChild)
        userChild.parentCoodinator = self
        userChild.start()
        
        let devsChild = DevelopersCoordinator(dataManager: dataManager,
                                              parentCoodinator: self,
                                              navigationController: navigationController)
        childCoordinators?.append(devsChild)
        devsChild.parentCoodinator = self
        devsChild.start()
    }
}

// MARK: - GameDataTransferProtocol

extension MainCoordinator: GameDataTransferProtocol {}
