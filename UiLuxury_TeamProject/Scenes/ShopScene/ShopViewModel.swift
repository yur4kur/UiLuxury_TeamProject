//
//  ShopViewModel.swift
//  UiLuxury_TeamProject
//
//  Created by Юрий Куринной on 27.03.2024.
//

import Foundation

// MARK: - ShopViewModelProtocol

protocol ShopViewModelProtocol {
    var shopItems: [Item] { get }
    /// Инициализация данных пользователя из стартовой вью-модели
    init(userData: StartViewModelProtocol)
}

// MARK: - UserViewModel

final class ShopViewModel: ShopViewModelProtocol {
    
    var shopItems: [Item] { Item.getItem() }
        
    // MARK: Private properties
    
    private var userData: StartViewModelProtocol
    
    
    // MARK: Initializers
    
    init(userData: StartViewModelProtocol) {
        self.userData = userData
    }
}
