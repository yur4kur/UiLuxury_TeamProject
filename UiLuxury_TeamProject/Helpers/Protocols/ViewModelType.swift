//
//  ViewModelType.swift
//  UiLuxury_TeamProject
//
//  Created by Юрий Куринной on 29.04.2024.
//

/// Базовый протокол вью-моделей
protocol ViewModelType {
    
    /// Поток данных, приходящих из вью-контроллера
    associatedtype Input
    
    /// Поток данных, возвращаемых вью-моделью
    associatedtype Output

    /// Запрос на обработку данных вью-моделью
    func transform(input: Input) -> Output
}