//
//  Protocols.swift
//  UiLuxury_TeamProject
//
//  Created by Юрий Куринной on 02.04.2024.
//

import UIKit

// MARK: - CoordinatorProtocol

/// Протокол координаторов
protocol CoordinatorProtocol: AnyObject {
    
    /// Дочерние координаторы, которые вызывает родительский координатор
    var childCoordinators: [CoordinatorProtocol]? { get set }
    
    /// Навигационный контроллер для перехода на другие контроллеры
    var navigationController: UINavigationController { get set }

    /// Инициализация и запуск обслуживаемого контроллера
    func start()
}

// MARK: - TabCoordinatorProtocol

/// Протокол координаторов контроллеров таббара
protocol TabCoordinatorProtocol: CoordinatorProtocol {
    
    /// Данные пользователя из стартовой вью-модели
    var userData: UserDataTransferProtocol { get set }
    
    /// Экземпляр родительского координатора
    var parentCoodinator: MainCoordinatorProtocol? { get }
    
}



