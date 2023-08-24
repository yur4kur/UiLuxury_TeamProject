//
//  User.swift
//  UiLuxury_TeamProject
//
//  Created by Юрий Куринной on 19.08.2023.
//

class User {
    var name = ""
    var wallet = 0
    var items: [Item] = [
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
        
        Item(title: "Win this game and take credits",
             price: 6000,
             description: "Good Job",
             modifier: 1,
             actionOperator: .assets)
    ]
    
    static let shared = User()
    
    private init() {}
}
