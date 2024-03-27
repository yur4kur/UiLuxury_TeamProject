//
//  GameViewModel.swift
//  UiLuxury_TeamProject
//
//  Created by Юрий Куринной on 17.03.2024.
//

import Foundation

// MARK: - GameViewModelProtocol

/// Протокол, описывающий методы игрового экрана и изменение счета кошелька пользователя
protocol GameViewModelProtocol {
    
    /// Свойство для подсчета очков за нажатие на кнопку
    var score: Int { get set }
    
    var scoreDidChange: ((GameViewModelProtocol) -> Void)? { get set }
    
    /// Метод подсчета очков за нажатие на кнопку
    func updateScore()
    
    /// Метод пополнения кошелька пользователя
    func updateUserWallet()
}

// MARK: - GameViewModel

/// Класс, описывающий игровую механику и связывающий ее со свойствами пользователя
final class GameViewModel: GameViewModelProtocol {
  
    private var userData: StartViewModelProtocol
  
    var score = 0
    
   
    var scoreDidChange: ((GameViewModelProtocol) -> Void)?
    
    init(userData: StartViewModelProtocol) {
        self.userData = userData
    }
    
    // TODO: доработать метод для применения модификатора айтемов
    func updateScore() {
        score += 1
        scoreDidChange?(self)
    }
    
    func updateUserWallet() {
        userData.user.wallet += score
        score = 0
        scoreDidChange?(self)
    }
    
//    // TODO: переработать блок для расчета модификатора айтемов
//    private func modifySetup() {
//        viewModel.user.items.forEach { item in
//            switch item.actionOperator{
//            case .add:
//                viewModel.clickModify += item.modifier
//            case .multiply:
//                viewModel.clickModify *= item.modifier
//            case .assets:
//                return
//            }
//        }
//    }
    
}
