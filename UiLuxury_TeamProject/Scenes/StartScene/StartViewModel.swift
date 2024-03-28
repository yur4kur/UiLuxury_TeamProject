//
//  StartViewModel.swift
//  UiLuxury_TeamProject
//
//  Created by Юрий Куринной on 26.03.2024.
//

import Foundation

// MARK: - StartViewModelProtocol

/// Протокол основной модели, в которой описывается пользователь
protocol StartViewModelProtocol {
    
    /// Экземпляр модели пользователя
    var user: NewUser { get set }

}

// MARK: - StartViewModel

/// Базовая вью-модель с данными о пользователе
class StartViewModel: StartViewModelProtocol {
    
    /// Инициализация пользователя (из БД или с бэка)
    private var uploadedUser = NewUser(name: "Akira", wallet: 300, items: [])
    
    // MARK: Public properties
    var user: NewUser {
        get {
            uploadedUser
        }
        set(update) {
            uploadedUser = update
        }
    }
}
