//
//  User.swift
//  UiLuxury_TeamProject
//
//  Created by Юрий Куринной on 19.08.2023.
//

/// Протокол основной модели, в которой загружается пользователь
protocol UserDataTransferProtocol {
    
    /// Экземпляр модели пользователя
    var user: User { get set }
}

/// Модель пользователя
struct User {
    
    /// Имя пользователя
    var name: String
    
    /// Количество заработанных монет
    var wallet: Int
    
    /// Купленные в магазине товары
    var items: [Item]
}

