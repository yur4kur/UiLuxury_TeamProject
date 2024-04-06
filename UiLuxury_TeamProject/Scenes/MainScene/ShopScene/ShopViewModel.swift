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
    
    ///Массив айтемов для магазина
    var shopItems: [Item] { get }
    
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
    
    // MARK: Public properties
    
    var shopItems: [Item] { Item.getItems() }
    var walletCount: String { "$\(userData.user.wallet.formatted())" }
    var numberOfSections: Int { shopItems.count }
    var numberOfRowsInSection = 1
    var walletDidChange: ((ShopViewModelProtocol) -> Void)?
    
    // MARK: Private properties
    
    private var userData: UserDataTransferProtocol
    
    // MARK: Initializers
    
    init(userData: UserDataTransferProtocol) {
        self.userData = userData
    }
    
    func buy(indexPath: IndexPath, completion: () -> Void) {
        if userData.user.wallet >= shopItems[indexPath.section].price {
            userData.user.items.append(shopItems[indexPath.section])
            userData.user.wallet -= shopItems[indexPath.section].price // Вычитаем деньги из кошелька
            walletDidChange?(self)
        } else {
            completion()
        }
    }
          
    func getTitleHeader(section: Int) -> String {
        "\(shopItems[section].title)"
    }
    
    func getText(indexPath: IndexPath) -> String {
        shopItems[indexPath.section].description
    }

    func getSecondaryText(indexPath: IndexPath) -> String {
        "\(shopItems[indexPath.section].price.formatted())"
    }
}
