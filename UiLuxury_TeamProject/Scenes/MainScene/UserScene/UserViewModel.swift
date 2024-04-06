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

    /// Имя уровня пользователя
    var userStageName: String { get }

    /// Имя изображения пользователя
    var userStageImageName: String { get }

    /// Количество кредитов пользователя
    var userCreditsLabelText: String { get }

    /// Количество секций
    var numberOfSections: Int { get }

    /// Количество строк в секции
    var numberOfRowsInSection: Int { get }

    /// Инициализация данными пользователя из UserViewController
    init(userData: UserDataTransferProtocol)

    /// Метод возвращает название секции
    func getTitleHeader(section: Int) -> String

    /// Метод возвращает основной текст стандартной ячейки
    func getText(indexPath: IndexPath) -> String

    /// Метод возвращает второстепенный текст стандартной ячейки
    func getSecondaryText(indexPath: IndexPath) -> String

    /// Метод продажи предметов
    func sellItem(indexPath: IndexPath)

    /// Метод воспроизведения звука
    func playSound()
}

// MARK: - User ViewModel

final class UserViewModel: UserViewModelProtocol {

    // MARK: Public properties

    var userStageName: String {
        let stageNameIndex = calculateUserStage(from: userData.user.wallet)
        return StageNames.names[stageNameIndex]
    }

    var userStageImageName: String {
        let imageIndex = calculateUserStage(from: userData.user.wallet)
        return StageImages.images[imageIndex]
    }

    var userCreditsLabelText: String {
        "\(Text.creditsLabelText): \(userData.user.wallet)"
    }

    var numberOfSections: Int {
        userData.user.items.count
    }

    var numberOfRowsInSection = 1

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

    func getTitleHeader(section: Int) -> String {
        userData.user.items[section].title
    }

    func getText(indexPath: IndexPath) -> String {
        userData.user.items[indexPath.section].description
    }

    func getSecondaryText(indexPath: IndexPath) -> String {
        "\(userData.user.items[indexPath.section].price)"
    }

    func sellItem(indexPath: IndexPath) {
        guard indexPath.section >= 0 && indexPath.section < userData.user.items.count else { return }
        let itemPrice = userData.user.items[indexPath.section].price
        userData.user.wallet += itemPrice

        // TODO: Удалить, если не будет использоваться
        //        userData.user.items[indexPath.section].isOn.toggle()

        userData.user.items.remove(at: indexPath.section)
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
        case 0...1751:
            return 0
        case 1752...2999:
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

    /// Названия уровней
    enum StageNames {
        static let names = [
            "НОВИЧОК",
            "ПРОДВИНУТЫЙ",
            "ЭЛИТА",
            "ЛЕГЕНДА"
        ]
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
