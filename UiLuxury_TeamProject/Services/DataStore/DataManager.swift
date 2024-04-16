//
//  DataManager.swift
//  UiLuxury_TeamProject
//
//  Created by Юрий Куринной on 16.04.2024.
//

// MARK: - DataManagerProtocol

/// Протокол менеджера данных
protocol DataManagerProtocol {
    
    /// Модель пользователя
    var user: User { get set }
    
    /// Модель товаров в магазине
    var items: [Item] { get }
    
    /// Модель команды разработчиков
    var team: [Developer] { get }
}

// MARK: - DataManager

/// Менеджер данных, отвечающий за передачу данных между контроллерами
final class DataManager: DataManagerProtocol {
    
    // MARK: - Private properties
    
    /// Инициализация пользователя (из БД или с бэка), пока через моковые данные
    private var uploadedUser = DataStore.shared.user
    
    // MARK: - Public properties
    
    var user: User {
        get {
            uploadedUser
        }
        set(update) {
            uploadedUser = update
        }
    }
    
    var items: [Item] {
        DataStore.shared.items
    }
    
    var team: [Developer] {
        DataStore.shared.developers
    }
}
