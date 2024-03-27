//
//  UserViewModel.swift
//  UiLuxury_TeamProject
//
//  Created by Юрий Куринной on 27.03.2024.
//

import Foundation

// MARK: - UserViewModelProtocol

protocol UserViewModelProtocol {
    
    /// Инициализация данных пользователя из стартовой вью-модели
    init(userData: StartViewModelProtocol)
}

// MARK: - UserViewModel

final class UserViewModel: UserViewModelProtocol {
    
    // MARK: Private properties
    
    private var userData: StartViewModelProtocol
    
    // MARK: Initializers
    
    init(userData: StartViewModelProtocol) {
        self.userData = userData
    }
}
