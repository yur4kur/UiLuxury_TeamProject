//
//  DataSource.swift
//  UiLuxury_TeamProject
//
//  Created by Юрий Куринной on 27.07.2023.
//

final class DataSource {
    static let shared = DataSource()
    
    let user = User(name: "Akira", wallet: 300, items: [])
    
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
        3,
        7,
        2
    ]
    
    private init () {}
}

// TODO: Удалить при первом релизе
/*
let gameItems = [
    Item(
        title: "Homeless hat",
        price: 15,
        description: "Plus one point to any tap",
        modifier: 1,
        actionOperator: .add),
    
    Item(
        title: "Lost talent",
        price: 40,
        description: "Multiplies the number of points per touch by 2",
        modifier: 2,
        actionOperator: .multiply),
    
    Item(
        title: "Back to ex-girlfriend",
        price: 80,
        description: "Plus random point per one tap. There is a chance to lose 50 points at once",
        modifier: Int.random(in: 1...50),
        actionOperator: .add),
    
    Item(
        title: "New haircut",
        price: 80,
        description: "Plus three points to any tap",
        modifier: 3,
        actionOperator: .add),
    
    Item(title: "Red-Bull",
         price: 140,
         description: "Multiply point from one tap by 3",
         modifier: 3,
         actionOperator: .multiply),
    
    Item(title: "Lotery ticket",
         price: 140,
         description: "Delete all your items and take random item from shop",
         modifier: 1,
         actionOperator: .assets),
    
    Item(title: "Illegal business",
         price: 140,
         description: "Take 500 points, but locked one item slot",
         modifier: 1,
         actionOperator: .assets),
    
    Item(title: "Mortgage",
         price: 200,
         description: "Multiply your score wallet and lock one item slot",
         modifier: 1,
         actionOperator: .assets),
    
    Item(title: "Good job",
         price: 200,
         description: "Plus 7 point per one tap",
         modifier: 7,
         actionOperator: .add),
    
    Item(title: "Psychologist",
         price: 250,
         description: "Multiplies the number of points per touch by 4",
         modifier: 4,
         actionOperator: .multiply),
    
    Item(title: "New Love",
         price: 250,
         description: "Random points per one tap. There is a chance lost 100 points per tap",
         modifier: 100,
         actionOperator: .add),
    
    Item(title: "Release a rock album",
         price: 500,
         description: "Take a random huge point, or lose all. If you sell, get -200 points",
         modifier: 200,
         actionOperator: .add),
    
    Item(title: "Defeat Mom's Friend's Son",
         price: 1000,
         description: "Take a god state and plus 20 points to any tap.",
         modifier: 20,
         actionOperator: .add),
    
    Item(title: "Win this game and take credits",
         price: 6000,
         description: "Good Job",
         modifier: 1,
         actionOperator: .assets)
]
*/
