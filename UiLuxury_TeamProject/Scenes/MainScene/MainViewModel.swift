//
//  MainViewModel.swift
//  UiLuxury_TeamProject
//
//  Created by Юрий Куринной on 03.04.2024.
//

import Foundation

// MARK: - UserDataTransferProtocol

///// Протокол передачи данных пользователя между вью-моделями
protocol UserDataTransferProtocol {
    
    /// Класс с инициализированнй моделью пользователя
    var userData: StartViewModelProtocol { get set }
}

// MARK: - MainViewModel

final class MainViewModel: UserDataTransferProtocol {
    var userData: StartViewModelProtocol
    
    init(userData: StartViewModelProtocol) {
        self.userData = userData
    }
}
