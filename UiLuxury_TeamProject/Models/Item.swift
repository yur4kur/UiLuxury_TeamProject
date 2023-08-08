//
//  Item.swift
//  UiLuxury_TeamProject
//
//  Created by Юрий Куринной on 02.08.2023.
//

struct Item {
    let title: String
    let price:  Int
    let description: String
    let modifier: Int
    let actionOperator: Operator
}

enum Operator {
    case add, multiply, assets
}
