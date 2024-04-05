//
//  ShopViewModel.swift
//  UiLuxury_TeamProject
//
//  Created by Юрий Куринной on 27.03.2024.
//

import UIKit

// MARK: - ShopViewModelProtocol

///Shop View Model Protocol
protocol ShopViewModelProtocol {
    
    var shopItems: [Item] { get }
    var walletCount: String { get }
    var numberOfSection: Int { get }
    var numberOfRowsInSection: Int { get }
    
    func cellConfig(cell: UITableViewCell, indexPath: IndexPath, text: String)
    func getTitleHeader(section: Int) -> String
    func buy(indexPath: IndexPath, complition: () -> Void, alertComplition: () -> Void)
    func sell(indexPath: IndexPath)
    /// Инициализация данных пользователя из стартовой вью-модели
    init(userData: StartViewModelProtocol)
}

// MARK: - UserViewModel

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
    
    func buy(indexPath: IndexPath, complition: () -> Void, alertComplition: () -> Void) {
        if userData.user.wallet >= shopItems[indexPath.section].price {
            complition()
            userData.user.items.append(shopItems[indexPath.section])
            // Вычитаем деньги из кошелька
            userData.user.wallet -= shopItems[indexPath.section].price
        } else {
            alertComplition()
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
