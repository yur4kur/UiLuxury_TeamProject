//
//  GameViewModel.swift
//  UiLuxury_TeamProject
//
//  Created by Юрий Куринной on 17.03.2024.
//

import Foundation
import AVFoundation

// MARK: - GameViewModelProtocol

/// Протокол, описывающий методы игрового экрана и изменение счета кошелька пользователя
protocol GameViewModelProtocol {

    /// Свойство для подсчета очков за нажатие на кнопку
    var score: Int { get set }
    
    /// Свойство оповещения об изменении количества заработанных очков
    var scoreDidChange: ((GameViewModelProtocol) -> Void)? { get set }
    
    /// Метод подсчета очков за нажатие на кнопку
    func updateScore()
    
    /// Метод пополнения кошелька пользователя
    func updateUserWallet()

    /// Метод настройки плеера
    func setupAudioPlayer()

    /// Метод воспроизведения звука
    func playSound()

    /// Метод активации тактильной отдачи
    func enableFeedback()
}

// MARK: - GameViewModel

/// Класс, описывающий игровую механику и связывающий ее со свойствами пользователя
final class GameViewModel: GameViewModelProtocol {
    
    // MARK: Public properties
    var dataManager: DataManagerProtocol
    var score = 0
    var scoreDidChange: ((GameViewModelProtocol) -> Void)?
    
    // MARK: - Private properties
    /// Точка доступа к SoundManager
    private let soundManager = SoundManager.shared

    /// Точка доступа к HapticFeedbackManager
    private let hapticFeedbackManager = HapticFeedbackManager.shared

    // MARK: - Initializers
    init(dataManager: DataManagerProtocol) {
        self.dataManager = dataManager
    }
    
    // MARK: - Public methods
    // TODO: доработать метод для применения модификатора айтемов
    func updateScore() {
        let modifier = applyModifier(from: dataManager.user.items)
        score += modifier
        scoreDidChange?(self)
    }
    
    func updateUserWallet() {
        dataManager.user.wallet += score
        score = 0
        scoreDidChange?(self)
    }
    
    func setupAudioPlayer() {
        DispatchQueue.global().async {
            self.soundManager.setupAudioPlayer(fromSound: Sounds.buttonPressed)
        }
    }
    
    func playSound() {
        DispatchQueue.global(qos: .default).async {
            self.soundManager.audioPlayer?.stop()
            self.soundManager.audioPlayer?.currentTime = 0
            self.soundManager.audioPlayer?.play()
        }
    }

    func enableFeedback() {
        hapticFeedbackManager.enableFeedback()
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

// MARK: - Constants

private extension GameViewModel {

    /// Имена звуков
    enum Sounds {
        static let buttonPressed = "coin"
    }
}
