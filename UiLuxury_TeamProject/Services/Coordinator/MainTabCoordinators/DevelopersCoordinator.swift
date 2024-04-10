//
//  DevelopersCoordinator.swift
//  UiLuxury_TeamProject
//
//  Created by Юрий Куринной on 04.04.2024.
//

import UIKit

// MARK: - DevelopersCoordinator

/// Координаторов игровой сцены
final class DevelopersCoordinator: TabCoordinatorProtocol {
    
    // MARK: Public properties
    var userData: UserDataTransferProtocol
    weak var parentCoodinator: MainCoordinatorProtocol?
    var childCoordinators: [CoordinatorProtocol]?
    var navigationController: UINavigationController
    
    // MARK: Initializers
    init(
        userData: UserDataTransferProtocol,
        parentCoodinator: MainCoordinatorProtocol,
        navigationController: UINavigationController
    ) {
        self.userData = userData
        self.parentCoodinator = parentCoodinator
        self.navigationController = navigationController
    }
    
    // MARK: Public methods
    func start()  {
        let teamVC = DevelopersViewController(coordinator: self)
        parentCoodinator?.tabControllers[GlobalConstants.teamKey] = teamVC
    }
}
