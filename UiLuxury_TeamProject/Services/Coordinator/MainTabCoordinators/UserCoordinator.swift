//
//  UserCoordinator.swift
//  UiLuxury_TeamProject
//
//  Created by Юрий Куринной on 04.04.2024.
//

import UIKit

// MARK: - UserCoordinator

/// Координаторов игровой сцены
final class UserCoordinator: TabCoordinatorProtocol {
    
    // MARK: Public properties
    var dataManager : DataManagerProtocol
    weak var parentCoodinator: MainCoordinatorProtocol?
    var childCoordinators: [CoordinatorProtocol]?
    var navigationController: UINavigationController
    
    // MARK: Initializers
    init(
        dataManager : DataManagerProtocol,
        parentCoodinator: MainCoordinatorProtocol,
        navigationController: UINavigationController
    ) {
        self.dataManager = dataManager
        self.parentCoodinator = parentCoodinator
        self.navigationController = navigationController
    }
    
    // MARK: Public methods
    func start()  {
        let userVC = UserViewController(coordinator: self)
        parentCoodinator?.tabControllers[GlobalConstants.userKey] = userVC
    }
}
// MARK: - GameDataTransferProtocol

extension UserCoordinator: GameDataTransferProtocol {}
