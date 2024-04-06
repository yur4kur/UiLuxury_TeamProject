//
//  DevelopersViewModel.swift
//  UiLuxury_TeamProject
//
//  Created by Акира on 27.03.2024.
//

import Foundation

class DevelopersViewModel {
    
    /// Получаем массив имен
    func getNames() -> [String] {
        let names = Developer.DevelopersInfo.names
        
        return names
    }
    
    /// Получаем количество имен
    func getNamesCount() -> Int {
        let count = Developer.DevelopersInfo.names.count
        
        return count
    }
    
    /// Получаем масив юрлов телеграма
    func getTelegramURL() -> [String] {
        let url = Developer.DevelopersInfo.contacts
        
        return url
    }
    
    ///Получаем изображение телеграма
    func getTelegramImage() -> String {
        let imageName = Developer.telegramLogo
        
        return imageName
    }
}
