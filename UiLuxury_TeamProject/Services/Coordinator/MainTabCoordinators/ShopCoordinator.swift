//
//  ShopCoordinator.swift
//  UiLuxury_TeamProject
//
//  Created by Юрий Куринной on 04.04.2024.
//

import UIKit

// MARK: - ShopCoordinator

/// Координаторов игровой сцены
final class ShopCoordinator: TabCoordinatorProtocol {
    
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
        let shopVC = ShopViewController(coordinator: self)
        parentCoodinator?.tabControllers[GlobalConstants.shopKey] = shopVC
    }
}
