//
//  GameCoordinator.swift
//  UiLuxury_TeamProject
//
//  Created by Юрий Куринной on 03.04.2024.
//

import UIKit

// MARK: - GameCoordinator

/// Координаторов игровой сцены
final class GameCoordinator: TabCoordinatorProtocol {
    
    // MARK: Public properties
    var dataManager : DataManagerProtocol
    weak var parentCoodinator: MainCoordinatorProtocol?
    var childCoordinators: [CoordinatorProtocol]?
    var navigationController: UINavigationController
    
    // MARK: Initializers
    init(
        dataManager: DataManagerProtocol,
        parentCoodinator: MainCoordinatorProtocol,
        navigationController: UINavigationController
    ) {
        self.dataManager = dataManager
        self.parentCoodinator = parentCoodinator
        self.navigationController = navigationController
    }
    
    // MARK: Public methods
    func start()  {
        let gameVC = GameViewController(coordinator: self)
        parentCoodinator?.tabControllers[GlobalConstants.gameKey] = gameVC
    }
}

// MARK: - GameDataTransferProtocol

extension GameCoordinator: GameServicesProtocol {}
