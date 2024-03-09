//
//  GameTabBarController.swift
//  UiLuxury_TeamProject
//
//  Created by Юрий Куринной on 09.03.2024.
//

import UIKit

// MARK: - GameTabBarController

final class GameTabBarController: UITabBarController {

    // MARK: - Lifecycle Methods
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setUpTabs()
        setupTabBar()
    }
    
    // MARK: - Private methods
    
    /// Метод создает NavigationController с прозрачной полосой и черными шрифтами
    private func createNavigationController(title: String,
                                            image: UIImage?,
                                            rootViewController: UIViewController) -> UINavigationController {
        let navigationController = UINavigationController(rootViewController: rootViewController)
        navigationController.tabBarItem.title = title
        navigationController.tabBarItem.image = image
        
        setupNavigationBar(navigationController)
        navigationController.viewControllers.first?.navigationItem.title = title
        
        return navigationController
    }
    
    /// Метод устанавливает полоске навигации прозрачный цвет и черные шрифты
    private func setupNavigationBar(_ navigationController: UINavigationController) {
        navigationController.navigationBar.prefersLargeTitles = true
        navigationController.navigationBar.prefersLargeTitles = true
        navigationController.navigationBar.tintColor = .black
        navigationController.navigationBar.backgroundColor = .clear
    }
    
    /// Метода настраивает иконки и названия элементов ТабБара с привязкой к контроллерам
    private func setUpTabs() {
        let clickVC = createNavigationController(
            title: Constants.gameTabName,
            image: UIImage(systemName: Constants.gameTabIcon),
            rootViewController: ClickViewController()
        )
        
        let shopVC = createNavigationController(
            title: Constants.shopTabName,
            image: UIImage(systemName: Constants.shopTabIcon),
            rootViewController: ShopListViewController()
        )
        
        let userVC = createNavigationController(
            title: Constants.userTabName,
            image: UIImage(systemName: Constants.userTabIcon),
            rootViewController: InfoCharacterViewController()
        )
        
        let teamVC = createNavigationController(
            title: Constants.teamTabName,
            image: UIImage(systemName: Constants.teamTabIcon),
            rootViewController: DevelopersInfoViewController()
        )
        
        setViewControllers([clickVC, shopVC, userVC, teamVC], animated: true)
    }
    
    /// Метод настраивает цвет иконок и делает таббар прозрачным
    private func setupTabBar() {
        tabBar.barTintColor = .clear
        tabBar.tintColor = .white
        tabBar.unselectedItemTintColor = .darkGray
    }
}

// MARK: - Constants

private extension GameTabBarController {
    enum Constants {
        static let gameTabName = "Игра"
        static let gameTabIcon = "cursorarrow.click.2"
        static let shopTabName = "Магазин"
        static let shopTabIcon = "cart.fill"
        static let userTabName = "Покупки"
        static let userTabIcon = "bag.fill"
        static let teamTabName = "Команда"
        static let teamTabIcon = "person.2.badge.gearshape.fill"
    }
}
