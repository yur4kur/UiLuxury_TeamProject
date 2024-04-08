//
//  DevelopersViewModel.swift
//  UiLuxury_TeamProject
//
//  Created by Юрий Куринной on 08.04.2024.
//

import Foundation

// MARK: - DevelopersViewModelProtocol

/// Протокол, описывающий свойства и методы экрана разработчиков
protocol DevelopersViewModelProtocol {
    
    /// Метод возвращает массив имен разработчиков
    func getNames() -> [String]
    
    /// Метод возвращает массив контактных ссылок разработчиков
    func getContacts() -> [String]
    
    /// Метод возвращает массив ролей разработчиков
    func getRoles() -> [String]
}

// MARK: - DevelopersViewModel

final class DevelopersViewModel: DevelopersViewModelProtocol {
    
    func getNames() -> [String] {
        var names: [String] = []
        DataStore.shared.developers.forEach { developer in
            let name = developer.name
            names.append(name)
        }
        
        return names
    }
    
    func getContacts() -> [String] {
        var contacts: [String] = []
        DataStore.shared.developers.forEach { developer in
            let contact = developer.contact
            contacts.append(contact)
        }
        
        return contacts
    }
    
    func getRoles() -> [String] {
        var roles: [String] = []
        DataStore.shared.developers.forEach { developer in
            let role = developer.role
            roles.append(role)
        }
        
        return roles
    }
}
