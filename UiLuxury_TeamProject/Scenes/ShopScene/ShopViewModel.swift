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
    
    /// Инициализация данных пользователя из стартовой вью-модели
    init(userData: StartViewModelProtocol)
    
    ///Метод настройки ячейки
    func cellConfig(cell: UITableViewCell, indexPath: IndexPath, text: String)
    
    ///Метод отображения названия секции
    func getTitleHeader(section: Int) -> String
    
    ///Метод покупки айтема
    func buy(indexPath: IndexPath, completion: () -> Void, alertCompletion: () -> Void)
    
    ///Метод продажи айтема
    func sell(indexPath: IndexPath)
}

// MARK: - UserViewModel

///Класс  ВьюМодели для магазина
final class ShopViewModel: ShopViewModelProtocol {
    
    var shopItems: [Item] { Item.getItem() }
    var walletCount: String { "$\(userData.user.wallet.formatted())" }
    var numberOfSection: Int { shopItems.count }
    var numberOfRowsInSection = 1
    
    // MARK: Private properties
    
    private var userData: StartViewModelProtocol
    
    // MARK: Initializers
    
    init(userData: StartViewModelProtocol) {
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
    
    func buy(indexPath: IndexPath, completion: () -> Void, alertCompletion: () -> Void) {
        if userData.user.wallet >= shopItems[indexPath.section].price {
            completion()
            userData.user.items.append(shopItems[indexPath.section])
            // Вычитаем деньги из кошелька
            userData.user.wallet -= shopItems[indexPath.section].price
        } else {
            alertCompletion()
        }
    }
        
    func sell(indexPath: IndexPath) {
        if let index = userData.user.items.firstIndex(of: shopItems[indexPath.section]) {
            userData.user.items.remove(at: index)
            // Возвращаем деньги в кошелек
            userData.user.wallet += shopItems[indexPath.section].price
        }
    }
    
    func getTitleHeader(section: Int) -> String {
        "\(shopItems[section].title)"
    }
}
