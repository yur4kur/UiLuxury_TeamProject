//
//  User.swift
//  UiLuxury_TeamProject
//
//  Created by Юрий Куринной on 19.08.2023.
//

/// Модель пользователя
struct User {
    
    /// Имя пользователя
    let name: String
    
    /// Количество заработанных монет
    var wallet: Int
    
    /// Купленные в магазине товары
    var items: [Item]
}

