//
//  UserDataViewModel.swift
//  UiLuxury_TeamProject
//
//  Created by Юрий Куринной on 26.03.2024.
//

// MARK: - StartViewModelProtocol

/// Протокол основной модели, в которой загружается пользователь
protocol UserDataTransferProtocol {
    
    /// Экземпляр модели пользователя
    var user: User { get set }
}

// MARK: - StartViewModel

/// Базовая вью-модель с данными о пользователе
final class StartViewModel: UserDataTransferProtocol {
    
    /// Инициализация пользователя (из БД или с бэка), пока через моковые данные
    private var uploadedUser = DataSource.shared.user
    
    // MARK: Public properties
    var user: User {
        get {
            uploadedUser
        }
        set(update) {
            uploadedUser = update
        }
    }
}


