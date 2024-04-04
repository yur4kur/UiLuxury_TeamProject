//
//  Item.swift
//  UiLuxury_TeamProject
//
//  Created by Юрий Куринной on 02.08.2023.
//

// MARK: - Item

/// Модель товара
struct Item {
    
    // MARK: Properties
    /// Название товара
    let title: String
    
    /// Цена товара
    let price:  Int
    
    /// Описание товара
    let description: String
    
    /// Модификатор, указывающие величину изменения очков при применении товара
    let modifier: Int
    
    /// Оператор, применямый к модификатору
    let actionOperator: Operator
    
    /// Свойство, показывающее, добавлен ли данный товар в корзину для покупки
    var isOn: Bool
    
    // MARK: - Staic methods
    /// Метод формирования товаров для магазина
    static func getItems() -> [Item] {
        var items: [Item] = []
        let dataSourse = DataSource.shared
        
        for index in 0..<dataSourse.titles.count {
            let item = Item(
                title: dataSourse.titles[index],
                price: dataSourse.prise[index],
                description: dataSourse.description[index],
                modifier: dataSourse.modifier[index],
                actionOperator: .add,
                isOn: false
            )
            items.append(item)
        }
        return items
    }
}

/// Тип оператора
enum Operator {
    case add, multiply, assets
}
