//
//  DevelopersViewModel.swift
//  UiLuxury_TeamProject
//
//  Created by Акира on 27.03.2024.
//

import Foundation

class DevelopersViewModel {
    
    /// Получаем массив имен
    func getNames(closure: @escaping ([String]) -> Void) {
        let names = Developer.DevelopersInfo.names
        
        closure(names)
    }
    
    /// Получаем масив юрлов телеграма
    func getTelegramURL(closure: @escaping ([String]) -> Void) {
        let url = Developer.DevelopersInfo.contacts
        
        closure(url)
    }
    
    ///Получаем изображение телеграма
    func getTelegramImage(closure: @escaping (String) -> Void) {
        let imageName = Developer.telegramLogo
        
        closure(imageName)
    }
}
