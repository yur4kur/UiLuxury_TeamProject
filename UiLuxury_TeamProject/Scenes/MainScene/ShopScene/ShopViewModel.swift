//
//  ShopViewModel.swift
//  UiLuxury_TeamProject
//
//  Created by Юрий Куринной on 27.03.2024.
//

import Foundation

// MARK: - ShopViewModelProtocol

///Притокол описывающий отображение магазина и взаимодействия юзера с ним
protocol ShopViewModelProtocol {
    
    ///Счет очков(денег)
    var walletCount: String { get }
    
    ///Колличество секций в таблице
    var numberOfSections: Int { get }
    
    ///Колличество ячеек в секции
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
    
    ///Метод покупки айтема
    func buy(indexPath: IndexPath, completion: () -> Void)
}

// MARK: - UserViewModel

///Класс  ВьюМодели для магазина
final class ShopViewModel: ShopViewModelProtocol {
    
    // MARK: - Private properties
    
    /// Набор товаров из хранилища (пока моковый DataStore)
    private var shopItems: [Item] { Item.getItems() }
    
    /// Отображаемые в магазине товары
    private var displayedItems: [Item] {
        get {
            sortItems()
        }
        set {}
    }
    
    // MARK: - Public properties
    
    var walletCount: String { "$\(userData.user.wallet.formatted())" }
    var numberOfSections: Int { displayedItems.count }
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
    
    func buy(indexPath: IndexPath, completion: () -> Void) {
        if userData.user.wallet >= displayedItems[indexPath.section].price {
            userData.user.wallet -= displayedItems[indexPath.section].price
            displayedItems.remove(at: indexPath.section)
            userData.user.items.append(displayedItems[indexPath.section])
            walletDidChange?(self)
        } else {
            completion()
        }
    }
          
    func getTitleHeader(section: Int) -> String {
        "\(displayedItems[section].title)"
    }
    
    func getText(indexPath: IndexPath) -> String {
        displayedItems[indexPath.section].description
    }

    func getSecondaryText(indexPath: IndexPath) -> String {
        "\(displayedItems[indexPath.section].price.formatted())"
    }
}
