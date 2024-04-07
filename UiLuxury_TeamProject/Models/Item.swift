//
//  Item.swift
//  UiLuxury_TeamProject
//
//  Created by Юрий Куринной on 02.08.2023.
//

// MARK: - Item

/// Модель товара
struct Item: Equatable {
    
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
}

/// Тип оператора
enum Operator: Comparable {
    case add, multiply
}
