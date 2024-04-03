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
    var childCoordinators: [CoordinatorProtocol] = []
    
    // MARK: Initializers
    init(userData: UserDataTransferProtocol) {
        self.userData = userData
    }
    
    // MARK: Public methods
    func start() -> UIViewController {
        let gameVM = GameViewModel(userData: userData)
        let gameVC = GameViewController(viewModel: gameVM)
        return gameVC
    }
    
    
}
