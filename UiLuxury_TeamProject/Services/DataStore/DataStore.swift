//
//  DataStore.swift
//  UiLuxury_TeamProject
//
//  Created by Юрий Куринной on 27.07.2023.
//

final class DataStore {
    static let shared = DataStore()
    
    let user = User(name: GlobalConstants.emptyString, wallet: 20, items: [])
    
    let items = [
        Item(
            title: "Потерянный навык",
             price: 1000,
            description: "Дополнительное очко за каждое нажатие кнопки",
            modifier: 1,
            actionOperator: .add
        ),
        
        Item(
            title: "Новый талант",
            price: 3000,
            description: "3 дополнительных очка при каждом нажатии кнопки",
            modifier: 2,
            actionOperator: .add
        ),
        
        Item(
            title: "Red-Bull",
            price: 6000,
            description: "7 дополнительных очков при каждом нажатии кнопки",
            modifier: 6,
            actionOperator: .add
        ),
        
        Item(
            title: "Лотерейный билет",
            price: 15000,
            description: "При каждом нажатии кнопки умножает дополнительные очки на 2",
            modifier: 2,
            actionOperator: .multiply
        )
    ]
    
    let developers = [
        Developer(
            name: "Михаил",
            contact: "https://t.me/AkiraReiTyan",
            role: "Идейный вдохновитель"
        ),
        
        Developer(
            name: "Кирилл",
            contact: "https://t.me/kizi_mcfly",
            role: "Основатель команды и спец по магазину"
        ),
        
        Developer(
            name: "Юрий",
            contact: "https://t.me/Radiator074",
            role: "Архитектор и спец по анимации"
        ),
        
        Developer(
            name: "Эльдар",
            contact: "https://t.me/eldarovsky",
            role: "Главный ревьюер и спец по озвучке"
        ),
        
        Developer(
            name: "Бийбол",
            contact: "https://t.me/zubi312",
            role: "Легендарный верстальщик сторибордов"
        )
    ]
    
    private init () {}
}

