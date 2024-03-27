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
    
    /// Свойство для обновления данных пользователя
    var userPropertiesDidChange: ((StartViewModelProtocol) -> Void)? { get set }
}

// MARK: - StartViewModel

/// Базовая вью-модель с данными о пользователе
class StartViewModel: StartViewModelProtocol {
    var user: NewUser {
        get {
            NewUser(name: "Akira", wallet: 300, items: [])
        }
        set {
            userPropertiesDidChange?(self)
        }
    }
    
    var userPropertiesDidChange: ((StartViewModelProtocol) -> Void)?

}