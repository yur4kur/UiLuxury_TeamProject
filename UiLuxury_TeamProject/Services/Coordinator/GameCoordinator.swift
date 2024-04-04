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
    var userData: UserDataTransferProtocol
    weak var parentCoodinator: TabBarCoordinatorProtocol?
    var childCoordinators: [CoordinatorProtocol]?
    var navigationController: UINavigationController
    
    // MARK: Initializers
    init(
        userData: UserDataTransferProtocol,
        parentCoodinator: TabBarCoordinatorProtocol,
        navigationController: UINavigationController
    ) {
        self.userData = userData
        self.parentCoodinator = parentCoodinator
        self.navigationController = navigationController
    }
    
    // MARK: Public methods
    func start()  {
        let gameVM = GameViewModel(userData: userData)
        let gameVC = GameViewController(viewModel: gameVM)
        parentCoodinator?.tabControllers.append(gameVC)
    }
    
    
}
