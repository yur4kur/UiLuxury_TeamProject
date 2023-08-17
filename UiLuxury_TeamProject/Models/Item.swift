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
    
    static func getItem() -> [Item] {
        var items: [Item] = []
        let dataSourse = DataSource.shared
        
        for index in 0..<dataSourse.titles.count {
            let item = Item(
                title: dataSourse.titles[index],
                price: dataSourse.prise[index],
                description: dataSourse.description[index],
                modifier: dataSourse.modifier[index],
                actionOperator: .add
            )
            items.append(item)
        }
        return items
    }
}

enum Operator {
    case add, multiply, assets
}
