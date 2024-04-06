//
//  ShopViewModel.swift
//  UiLuxury_TeamProject
//
//  Created by Юрий Куринной on 27.03.2024.
//

import UIKit

// MARK: - ShopViewModelProtocol

///Притокол описывающий отображение магазина и взаимодействия юзера с ним
protocol ShopViewModelProtocol {
    
    ///Массив айтемов для магазина
    var shopItems: [Item] { get }
    
    ///Счет очков(денег)
    var walletCount: String { get }
    
    ///Колличество секций в таблице
    var numberOfSection: Int { get }
    
    ///Колличество ячеек в секции
    var numberOfRowsInSection: Int { get }
    
    /// Свойство оповещения об изменении количества монет на счету при покупке
    var walletDidChange: ((ShopViewModelProtocol) -> Void)? { get set }
    
    /// Инициализация данных пользователя из стартовой вью-модели
    init(userData: UserDataTransferProtocol)
    
    ///Метод настройки ячейки
    func cellConfig(cell: UITableViewCell, indexPath: IndexPath, text: String)
    
    ///Метод отображения названия секции
    func getTitleHeader(section: Int) -> String
    
    ///Метод покупки айтема
    func buy(indexPath: IndexPath, completion: () -> Void)
    
//    ///Метод продажи айтема
//    func sell(indexPath: IndexPath)
}

// MARK: - UserViewModel

///Класс  ВьюМодели для магазина
final class ShopViewModel: ShopViewModelProtocol {
    
    // MARK: Public properties
    
    var shopItems: [Item] { Item.getItems() }
    var walletCount: String { "$\(userData.user.wallet.formatted())" }
    var numberOfSection: Int { shopItems.count }
    var numberOfRowsInSection = 1
    var walletDidChange: ((ShopViewModelProtocol) -> Void)?
    
    // MARK: Private properties
    
    private var userData: UserDataTransferProtocol
    
    // MARK: Initializers
    
    init(userData: UserDataTransferProtocol) {
        self.userData = userData
    }
    
    func cellConfig(cell: UITableViewCell, indexPath: IndexPath, text: String) {
        var content = cell.defaultContentConfiguration()
        content.text = shopItems[indexPath.section].description
        content.textProperties.lineBreakMode = .byTruncatingHead
        content.secondaryText = "\(text)\(shopItems[indexPath.section].price.formatted())"
        content.secondaryTextProperties.font = .boldSystemFont(ofSize: 17)
        cell.contentConfiguration = content
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
        
//    func sell(indexPath: IndexPath) {
//        if let index = userData.user.items.firstIndex(of: shopItems[indexPath.section]) {
//            userData.user.items.remove(at: index)
//            userData.user.wallet += shopItems[indexPath.section].price // Возвращаем деньги в кошелек
//            walletDidChange?(self)
//        }
//    }
//    
    func getTitleHeader(section: Int) -> String {
        "\(shopItems[section].title)"
    }
}
