//
//  User.swift
//  UiLuxury_TeamProject
//
//  Created by Юрий Куринной on 19.08.2023.
//

final class User {
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
        Item(
            title: "New haircut",
            price: 80,
            description: "Plus three points to any tap",
            modifier: 3,
            actionOperator: .add)
    ]

    static let shared = User()

    private init() {}
}
