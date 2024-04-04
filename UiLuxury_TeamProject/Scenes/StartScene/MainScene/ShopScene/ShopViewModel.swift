//
//  ShopViewModel.swift
//  UiLuxury_TeamProject
//
//  Created by Юрий Куринной on 27.03.2024.
//

import Foundation

// MARK: - ShopViewModelProtocol

protocol ShopViewModelProtocol {
    
    /// Инициализация данных пользователя из стартовой вью-модели
    init(userData: UserDataTransferProtocol)
}

// MARK: - UserViewModel

final class ShopViewModel: ShopViewModelProtocol {
    
    // MARK: Private properties
    
    private var userData: UserDataTransferProtocol
    
    // MARK: Initializers
    
    init(userData: UserDataTransferProtocol) {
        self.userData = userData
    }
}
