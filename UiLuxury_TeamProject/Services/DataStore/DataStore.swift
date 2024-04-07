//
//  DataStore.swift
//  UiLuxury_TeamProject
//
//  Created by Юрий Куринной on 27.07.2023.
//

final class DataStore {
    static let shared = DataStore()
    
    let user = User(name: "Akira", wallet: 1800, items: [])
    
    let titles = [
        "Потерянный навык",
        "Новый талант",
        "Red-Bull",
        "Лотерейный билет",
    ]
    
    let prise = [
        250,
        500,
        1000,
        6000
    ]
    
    let description = [
        "Дополнительное очко за каждое нажатие кнопки",
        "3 дополнительных очка при каждом нажатии кнопки",
        "7 дополнительных очков при каждом нажатии кнопки",
        "При каждом нажатии кнопки умножает дополнительные очки на 2"
    ]
    
    let modifier = [
        1,
        2,
        6,
        2
    ]
    
    private init () {}
}

