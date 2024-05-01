//
//  GameViewModel.swift
//  UiLuxury_TeamProject
//
//  Created by Юрий Куринной on 17.03.2024.
//

import Foundation

// MARK: - GameViewModelProtocol

/// Протокол вью-модели игрового экрана
protocol GameViewModelProtocol: ViewModelType where Input == ViewState, Output == String {}

// MARK: - GameViewModel

/// Вью-модель игровой механики
final class GameViewModel: GameViewModelProtocol {

    // MARK: - Private properties
    
    /// Менеджер данных
    private var dataManager: DataManagerProtocol
    
    /// Счет полученных монет
    private var score = 0 {
        didSet {
            output = score.description
        }
    }
   
    // MARK: - Public properties
    
    /// Входной поток данных
    var input: ViewState {
        get {
            .loaded
        }
        set {}
    }
  
    /// Выходной поток данных
    var output: String {
        get {
            score.description
        }
        set {}
    }
    
    // MARK: - Initializers
    init(dataManager: DataManagerProtocol) {
        self.dataManager = dataManager
    }
    
    func transform(input: Input) -> String {
        switch input {
        case .loaded:
            score = 0
        case .gaming:
            updateScore()
        case .background:
            updateUserWallet()
        }
        return output
    }
    // MARK: - Private methods
    
    private func updateScore() {
        let modifier = applyModifier(from: dataManager.user.items)
        score += modifier
    }
    
    private func updateUserWallet() {
        dataManager.user.wallet += score
        score = 0
    }

    /// Метод применяет модификаторы товаров купленные пользователем
    private func applyModifier(from items: [Item]) -> Int {
        var modifier = 1
        let sortedItems = items.sorted { $0.actionOperator < $1.actionOperator }
        sortedItems.forEach { item in
            switch item.actionOperator{
            case .add:
                modifier += item.modifier
            case .multiply:
                modifier *= item.modifier
            }
        }
        return modifier
    }
}
