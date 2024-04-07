//
//  UserViewModel.swift
//  UiLuxury_TeamProject
//
//  Created by Eldar Abdullin on 27.03.2024.
//

import Foundation
import AVFoundation

// MARK: - User ViewModelProtocol

/// Протокол, описывающий свойства и методы экрана пользователя
protocol UserViewModelProtocol {

    /// Название уровня пользователя
    var userStageName: String { get }

    /// Имя изображения пользователя
    var userStageImageName: String { get }

    /// Количество кредитов пользователя
    var userCreditsLabelText: String { get }

    /// Количество секций таблицы
    var numberOfSections: Int { get }

    /// Количество строк в секции таблицы
    var numberOfRowsInSection: Int { get }

    /// Инициализация данными пользователя из UserViewController
    init(userData: UserDataTransferProtocol)

    /// Метод возвращает название секции таблицы
    func getTitleHeader(section: Int) -> String

    /// Метод возвращает основной текст стандартной ячейки таблицы
    func getText(indexPath: IndexPath) -> String

    /// Метод возвращает второстепенный текст стандартной ячейки таблицы
    func getSecondaryText(indexPath: IndexPath) -> String

    /// Метод продажи купленных предметов
    func sellItem(indexPath: IndexPath)

    /// Метод воспроизведения звука при увеличении уровня пользователя
    func playSoundLevelUp()

    /// Метод воспроизведения звука при продаже товара пользователя
    func playSoundSell()
}

// MARK: - User ViewModel

/// Класс, описывающий свойства и методы экрана пользователя
final class UserViewModel: UserViewModelProtocol {

    // MARK: - Public properties

    var userStageName: String {
        let stageNameIndex = calculateStage(fromScore: wallet, andItems: items)

        return StageNames.names[stageNameIndex]
    }

    var userStageImageName: String {
        let imageIndex = calculateStage(fromScore: wallet, andItems: items)
        return StageImages.images[imageIndex]
    }

    var userCreditsLabelText: String {
        "\(Text.creditsLabelText): \(wallet)"
    }

    var numberOfSections: Int {
        items.count
    }

    let numberOfRowsInSection = 1

    // MARK: - Private properties

    /// Точка доступа к SoundManager
    private let soundManager = SoundManager.shared

    /// Уровень пользователя
    private var userStage = 0

    /// Граница очков первого уровня
    private var firstStageMaxScore = 1999

    /// Данные пользователя из стартовой вью-модели
    private var userData: UserDataTransferProtocol
    
    /// Отображаемые товары
    private var displayedItems: [Item] {
        get {
            userData.user.items.sorted { $0.price < $1.price }
        }
        set (update) {
            userData.user.items = update
        }
    }

    /// Сумма очков в кошельке пользователя
    private var wallet: Int {
        get {
            userData.user.wallet
        }
        set {
            userData.user.wallet += newValue
        }
    }

    /// Массив купленных пользователем товаров
    private var items: [Item] {
        get {
            userData.user.items
        }
        set {
            userData.user.items = newValue
        }
    }

    // MARK: Initializers

    init(userData: UserDataTransferProtocol) {
        self.userData = userData
    }

    // MARK: Public methods

    func getTitleHeader(section: Int) -> String {

        displayedItems[section].title
    }

    func getText(indexPath: IndexPath) -> String {
        displayedItems[indexPath.section].description
    }

    func getSecondaryText(indexPath: IndexPath) -> String {
        "\(displayedItems[indexPath.section].price)"
    }

    func sellItem(indexPath: IndexPath) {
        guard indexPath.section >= 0 && indexPath.section < userData.user.items.count else { return }
        let itemPrice = displayedItems[indexPath.section].price
        userData.user.wallet += itemPrice
        displayedItems.remove(at: indexPath.section)
    }

    func playSoundLevelUp() {
        let previousUserStage = userStage
        userStage = calculateStage(fromScore: wallet, andItems: items)
        soundManager.setupAudioPlayer(fromSound: Sounds.levelUp)

        if userStage > previousUserStage {
            DispatchQueue.main.async {
                self.soundManager.audioPlayer?.play()
            }
        }
    }

    func playSoundSell() {
        DispatchQueue.main.async {
            self.soundManager.setupAudioPlayer(fromSound: Sounds.cash)
            self.soundManager.audioPlayer?.play()
        }
    }

    // MARK: Private Methods

    /// Метод определения уровня пользователя
    private func calculateStage(fromScore score: Int, andItems items: [Item]) -> Int {
        let itemsPrice = items.reduce(0) { sum, item in
            sum + item.price
        }

        let totalScore = score + itemsPrice

        switch totalScore {
        case 0...firstStageMaxScore:
            return 0
        case firstStageMaxScore + 1...2 * firstStageMaxScore:
            return 1
        case 2 * firstStageMaxScore + 1...6 * firstStageMaxScore:
            return 2
        default:
            return 3
        }
    }
}

// MARK: - Constants

/// Расширение со всеми текстовыми константами
private extension UserViewModel {

    /// Текстовые константы
    enum Text {
        static let creditsLabelText = "СЧЕТ"
    }

    /// Названия уровней
    enum StageNames {
        static let names = [
            "МЕДИТАЦИЯ",
            "СОЗНАНИЕ",
            "МУДРОСТЬ",
            "НИРВАНА"
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
        static let cash = "cash"
    }
}
