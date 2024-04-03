//
//  StartViewModel.swift
//  UiLuxury_TeamProject
//
//  Created by Юрий Куринной on 26.03.2024.
//

import Foundation

// MARK: - StartViewModelProtocol

///// Протокол передачи данных пользователя между вью-моделями
//protocol UserDataTransferProtocol {
//    
//   
//
//}

/// Протокол основной модели, в которой загружается пользователь
protocol StartViewModelProtocol: AnyObject {
    
    /// Экземпляр модели пользователя
    var user: User { get set }

}

// MARK: - StartViewModel

/// Базовая вью-модель с данными о пользователе
class StartViewModel: StartViewModelProtocol {
    
    /// Инициализация пользователя (из БД или с бэка)
    private var uploadedUser = User(name: "Akira", wallet: 300, items: [])
    
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
