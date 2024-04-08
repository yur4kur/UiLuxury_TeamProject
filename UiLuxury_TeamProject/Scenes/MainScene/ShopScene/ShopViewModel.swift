//
//  ShopViewModel.swift
//  UiLuxury_TeamProject
//
//  Created by Юрий Куринной on 27.03.2024.
//

import Foundation

// MARK: - ShopViewModelProtocol

///Притокол, описывающий отображение магазина и взаимодействия юзера с ним
protocol ShopViewModelProtocol {
    
    /// Количество монет на счету пользователя
    var walletCount: String { get }
    
    ///Количество секций в таблице
    var numberOfSections: Int { get }
    
    ///Количество ячеек в секции
    var numberOfRowsInSection: Int { get }
    
    /// Свойство оповещения об изменении количества монет на счету при покупке
    var walletDidChange: ((ShopViewModelProtocol) -> Void)? { get set }
    
    /// Инициализация данных пользователя из стартовой вью-модели
    init(userData: UserDataTransferProtocol)
    
    ///Метод отображения названия секции
    func getTitleHeader(section: Int) -> String
    
    /// Метод возвращает основной текст стандартной ячейки
    func getText(indexPath: IndexPath) -> String

    /// Метод возвращает второстепенный текст стандартной ячейки
    func getSecondaryText(indexPath: IndexPath) -> String
    
    /// Метод проверяет возможность покупки товара
    func checkWallet(indexPath: IndexPath, ableCompletion: () -> Void, unableCompletion: () -> Void)
    
    ///Метод покупки товара
    func buy(indexPath: IndexPath)
    
    /// Метод воспроизведения звука при покупке товара пользователем
    func playSoundBuy()
    
    /// Метод возвращает заголовок алерта
    func getAlertTitle() -> String
    
    /// Метод возвращает сообщение алерта
    func getAlertMessage() -> String
    
    /// Метод возвращает название кнопки алерта
    func getAlertActionTitle() -> String
}

// MARK: - UserViewModel

///Класс  ВьюМодели для магазина
final class ShopViewModel: ShopViewModelProtocol {
    
    // MARK: - Private properties
    
    /// Точка доступа к SoundManager
    private let soundManager = SoundManager.shared
    
    /// Набор товаров из хранилища (пока моковый DataStore)
    private var shopItems: [Item] { DataStore.shared.items }
    
    /// Отображаемые в магазине товары
    private var displayedItems: [Item] {
        get {
            sortItems()
        }
        set {}
    }
    
    // MARK: - Public properties
    
    var walletCount: String {
        "\(Constants.walletTag + userData.user.wallet.formatted())"
    }
    var numberOfSections: Int {
        displayedItems.count
    }
    var numberOfRowsInSection = 1
    var walletDidChange: ((ShopViewModelProtocol) -> Void)?
    
    // MARK: - Private properties
    
    private var userData: UserDataTransferProtocol
    
    // MARK: - Initializers
    
    init(userData: UserDataTransferProtocol) {
        self.userData = userData
    }
    
    // MARK: - Private methods
    
    /// Метод, убирающий купленные товары из отображаемых в магазине
    private func sortItems() -> [Item] {
        var storeItems: [Item] = []
        shopItems.forEach { Item in
            if !userData.user.items.contains(Item) {
                storeItems.append(Item)
            }
        }
        return storeItems.sorted { $0.price < $1.price }
    }
    
    // MARK: - Public methods
    
    func checkWallet(indexPath: IndexPath, ableCompletion: () -> Void, unableCompletion: () -> Void) {
        if userData.user.wallet >= displayedItems[indexPath.section].price {
            ableCompletion()
        } else {
            unableCompletion()
        }
    }
    
    func buy(indexPath: IndexPath) {
            userData.user.wallet -= displayedItems[indexPath.section].price
            displayedItems.remove(at: indexPath.section)
            userData.user.items.append(displayedItems[indexPath.section])
            walletDidChange?(self)
    }
    
    func playSoundBuy() {
        DispatchQueue.main.async {
            self.soundManager.setupAudioPlayer(fromSound: Sounds.cash)
            self.soundManager.audioPlayer?.play()
        }
    }
          
    func getTitleHeader(section: Int) -> String {
        "\(displayedItems[section].title)"
    }
    
    func getText(indexPath: IndexPath) -> String {
        displayedItems[indexPath.section].description
    }

    func getSecondaryText(indexPath: IndexPath) -> String {
        Constants.priceTag + " \(displayedItems[indexPath.section].price.formatted())"
    }
    
    func getAlertTitle() -> String {
        Constants.alertTitle
    }
    
    func getAlertMessage() -> String {
        Constants.alertMessage
    }
    
    func getAlertActionTitle() -> String {
        Constants.alertButtonTitle
    }
}

// MARK: - Sounds

private extension ShopViewModel {
    /// Названия звуков
    enum Sounds {
        static let cash = "cash"
    }
}

// MARK: - Texts

private extension ShopViewModel {
    
    /// Текстовые элементы, используемые в коде
    enum Constants {
        static let walletTag = "На счёте: \(GlobalConstants.coin)"
        static let priceTag = "Купить: \(GlobalConstants.coin)"
        static let alertTitle = "Не хватает монет!"
        static let alertMessage = "На твоем счет недостаточно монет для покупки"
        static let alertButtonTitle = "Ok"
    }
}
