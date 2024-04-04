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
}

// MARK: - GameViewModel

/// Класс, описывающий игровую механику и связывающий ее со свойствами пользователя
final class GameViewModel: GameViewModelProtocol {
    
    // MARK: Public properties
    var userData: UserDataTransferProtocol
    var score = 0
    var scoreDidChange: ((GameViewModelProtocol) -> Void)?
    
    // MARK: - Private properties
    /// Точка доступа к SoundManager
    private let soundManager = SoundManager.shared
    
    // MARK: - Initializers
    init(userData: UserDataTransferProtocol) {
        self.userData = userData
    }
    
    // MARK: - Public methods
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

// MARK: - Constants

private extension GameViewModel {

    /// Имена звуков
    enum Sounds {
        static let buttonPressed = "coin"
    }
}
