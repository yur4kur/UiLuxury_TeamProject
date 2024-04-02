//
//  CoordinatorProtocol.swift
//  UiLuxury_TeamProject
//
//  Created by Юрий Куринной on 02.04.2024.
//

import UIKit

/// Протокол координаторов
protocol CoordinatorProtocol {
    
    /// Дочерние координаторы, которые вызывает главный координатор
    var childCoordinators: [CoordinatorProtocol] { get set }
    
    /// Навигационный контроллер для перехода на другие контроллеры
    var navigationController: UINavigationController { get set }

    func start()
}
