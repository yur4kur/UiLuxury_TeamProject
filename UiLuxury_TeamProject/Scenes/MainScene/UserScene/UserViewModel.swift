//
//  UserViewModel.swift
//  UiLuxury_TeamProject
//
//  Created by Eldar Abdullin on 27.03.2024.
//

import Foundation
import AVFoundation

// MARK: - User ViewModelProtocol

protocol UserViewModelProtocol {

    /// Имя изображения пользователя
    var userStageImageName: String { get }

    /// Количество кредитов пользователя
    var userCreditsLabelText: String { get }

    /// Количество купленных предметов пользователя
    var userItems: [Item] { get }

    /// Инициализация данными пользователя из UserViewController
    init(userData: UserDataTransferProtocol)

    /// Метод продажи предметов
    func sellItem(at index: Int)

    /// Метод воспроизведения звука
    func playSound()
}

// MARK: - User ViewModel

final class UserViewModel: UserViewModelProtocol {

    // MARK: Public properties

    var userStageImageName: String {
        let imageIndex = calculateUserStage(from: userData.user.wallet)
        return StageImages.images[imageIndex]
    }

    var userCreditsLabelText: String {
        "\(Text.creditsLabelText): \(userData.user.wallet)"
    }

    var userItems: [Item] {
        userData.user.items
    }

    // MARK: Private properties

    /// Точка доступа к SoundManager
    private let soundManager = SoundManager.shared

    /// Уровень пользователя
    private var userStage = 0

    /// Данные пользователя из стартовой вью-модели
    private var userData: UserDataTransferProtocol

    // MARK: Initializers

    init(userData: UserDataTransferProtocol) {
        self.userData = userData
    }

    // MARK: Public methods

    func sellItem(at index: Int) {
        guard index >= 0 && index < userData.user.items.count else { return }
        let itemPrice = userData.user.items[index].price
        userData.user.wallet += itemPrice
        userData.user.items.remove(at: index)
    }

    func playSound() {
        let previousUserStage = userStage
        userStage = calculateUserStage(from: userData.user.wallet)

        soundManager.setupAudioPlayer(fromSound: Sounds.levelUp)

        if userStage > previousUserStage {
            DispatchQueue.main.async {
                self.soundManager.audioPlayer?.play()
            }
        }
    }

    // MARK: Private Methods

    /// Метод определения уровня пользователя
    private func calculateUserStage(from credits: Int) -> Int {
        switch credits {
        case 0...1499:
            return 0
        case 1500...2999:
            return 1
        case 3000...4499:
            return 2
        default:
            return 3
        }
    }
}

// MARK: - Constants

private extension UserViewModel {

    /// Текстовые константы
    enum Text {
        static let creditsLabelText = "СЧЕТ"
    }

    /// Имена изображений
    enum StageImages {
        static let images = [
            "stage01",
            "stage02",
            "stage03",
            "stage04"
        ]
    }

    /// Имена звуков
    enum Sounds {
        static let levelUp = "levelUp"
    }
}
