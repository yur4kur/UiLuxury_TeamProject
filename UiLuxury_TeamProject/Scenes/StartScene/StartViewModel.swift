//
//  StartViewModel.swift
//  UiLuxury_TeamProject
//
//  Created by Юрий Куринной on 26.03.2024.
//

// MARK: - StartViewModelProtocol

/// Протокол основной модели, в которой загружается пользователь
protocol StartViewModelProtocol: UserDataTransferProtocol {}

// MARK: - StartViewModel

/// Базовая вью-модель с данными о пользователе
final class StartViewModel: StartViewModelProtocol {
    
    // MARK: Private properties
    /// Инициализация пользователя (из БД или с бэка), пока через моковые данные
    private var uploadedUser = DataStore.shared.user
    
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


