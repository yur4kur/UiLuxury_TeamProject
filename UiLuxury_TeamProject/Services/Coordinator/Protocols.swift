//
//  CoordinatorProtocol.swift
//  UiLuxury_TeamProject
//
//  Created by Юрий Куринной on 02.04.2024.
//

import UIKit

// MARK: - CoordinatorProtocol

/// Протокол координаторов
protocol CoordinatorProtocol {
    
    /// Дочерние координаторы, которые вызывает родительский координатор
    var childCoordinators: [CoordinatorProtocol] { get set }
    
    /// Навигационный контроллер для перехода на другие контроллеры
    var navigationController: UINavigationController { get set }

    /// Инициализация и запуск обслуживаемого контроллера
    func start()
}

// MARK: - MainCoordinatorProtocol

/// Протокол координатора основной сцены
protocol MainCoordinatorProtocol: CoordinatorProtocol {
    
    /// Данные пользователя из стартовой вью-модели
    var userData: UserDataTransferProtocol { get set }
}

// MARK: - TabCoordinatorProtocol

/// Протокол координаторов контроллеров таббара
protocol TabCoordinatorProtocol {
    
    /// Экземпляр пользователя для игровых контроллеров
    var userData: UserDataTransferProtocol { get set }
    
    /// Инициализация обслуживаемого контроллера
    func start() -> UIViewController
}
