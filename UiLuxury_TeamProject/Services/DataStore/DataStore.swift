//
//  DataStore.swift
//  UiLuxury_TeamProject
//
//  Created by Юрий Куринной on 27.07.2023.
//

final class DataStore {
    static let shared = DataStore()
    
    let user = User(name: "Akira", wallet: 6800, items: [])
    
    let items = [
        Item(
            title: "Потерянный навык",
             price: 250, 
            description: "Дополнительное очко за каждое нажатие кнопки",
            modifier: 1,
            actionOperator: .add
        ),
        
        Item(
            title: "Новый талант", 
            price: 500,
            description: "3 дополнительных очка при каждом нажатии кнопки",
            modifier: 2,
            actionOperator: .add
        ),
        
        Item(
            title: "Red-Bull",
            price: 1000,
            description: "7 дополнительных очков при каждом нажатии кнопки",
            modifier: 6,
            actionOperator: .add
        ),
        
        Item(
            title: "Лотерейный билет",
            price: 6000,
            description: "При каждом нажатии кнопки умножает дополнительные очки на 2",
            modifier: 2,
            actionOperator: .multiply
        )
    ]
 
    private init () {}
}

