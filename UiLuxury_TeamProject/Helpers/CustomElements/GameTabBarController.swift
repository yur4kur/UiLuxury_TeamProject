//
//  GameTabBarController.swift
//  UiLuxury_TeamProject
//
//  Created by Юрий Куринной on 09.03.2024.
//

import UIKit

// MARK: - GameTabBarController

/// Кастомный контроллер, в котором TabBar объединен с NavigationController
final class GameTabBarController: UITabBarController {
    
    // MARK: - Private properties
    
    /// Вью-модель, содержащая единый объект пользователя
    private var userData: StartViewModelProtocol
    
    // MARK: - Initializers
    
    init(userData: StartViewModelProtocol) {
        self.userData = userData
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError(GlobalConstants.fatalError)
    }
    
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
        navigationController.navigationBar.tintColor = .black
        
        let navigationBarAppearance = UINavigationBarAppearance()
        navigationBarAppearance.configureWithTransparentBackground()
        navigationController.navigationBar.standardAppearance = navigationBarAppearance
        navigationController.navigationBar.compactAppearance = navigationBarAppearance
        navigationController.navigationBar.scrollEdgeAppearance = navigationBarAppearance
    }
    
    /// Метода настраивает иконки и названия элементов ТабБара с привязкой к контроллерам
    private func setUpTabs() {
        let clickVC = createNavigationController(
            title: Constants.gameTabName,
            image: UIImage(systemName: Constants.gameTabIcon),
            rootViewController: GameViewController(userData: userData)
        )
        
        let shopVC = createNavigationController(
            title: Constants.shopTabName,
            image: UIImage(systemName: Constants.shopTabIcon),
            rootViewController: ShopViewController(userData: userData)
        )
        
        let userVC = createNavigationController(
            title: Constants.userTabName,
            image: UIImage(systemName: Constants.userTabIcon),
            rootViewController: UserViewController(userData: userData)
        )
        
        let teamVC = createNavigationController(
            title: Constants.teamTabName,
            image: UIImage(systemName: Constants.teamTabIcon),
            rootViewController: DevelopersViewController()
        )
        
        setViewControllers([clickVC, shopVC, userVC, teamVC], animated: true)
    }
    
    /// Метод настраивает цвет иконок и делает таббар прозрачным
    private func setupTabBar() {
        let tabBarAppearance = UITabBarAppearance()
        tabBarAppearance.configureWithTransparentBackground()
        tabBarAppearance.backgroundColor = .clear
        
        let tabBarItemAppearance = UITabBarItemAppearance()
        
        tabBarItemAppearance.normal.iconColor = .darkGray
        tabBar.tintColor = .white
        
        tabBarItemAppearance.normal.titleTextAttributes = [
            NSAttributedString.Key.foregroundColor: UIColor.darkGray,
            NSAttributedString.Key.font: UIFont.systemFont(ofSize: 12)
        ]
        
        tabBarItemAppearance.selected.titleTextAttributes = [
            NSAttributedString.Key.foregroundColor: UIColor.white,
            NSAttributedString.Key.font: UIFont.systemFont(ofSize: 12)
        ]
        
        tabBarAppearance.stackedLayoutAppearance = tabBarItemAppearance
        tabBar.standardAppearance = tabBarAppearance
        tabBar.scrollEdgeAppearance = tabBarAppearance
//        tabBar.barTintColor = .systemMint
//        tabBar.backgroundColor = .systemMint
//        tabBar.tintColor = .white
//        tabBar.unselectedItemTintColor = .darkGray
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
