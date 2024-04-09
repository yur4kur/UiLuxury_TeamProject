//
//  MainTabBarController.swift
//  UiLuxury_TeamProject
//
//  Created by Юрий Куринной on 09.03.2024.
//

import UIKit

// MARK: - GameTabBarController

/// Кастомный контроллер, в котором TabBar объединен с NavigationController
final class MainTabBarController: UITabBarController {
    
    // MARK: Private properties
    private let coordinator: MainCoordinatorProtocol
    
    // MARK: Initializers
    init(coordinator: MainCoordinatorProtocol) {
        self.coordinator = coordinator
        super.init(nibName: nil, bundle: nil)
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError(GlobalConstants.fatalError)
    }
    
    // MARK: Lifecycle Methods
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
        coordinator.navigationController.navigationBar.isHidden = true
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
    
    /// Метод настраивает иконки и названия элементов ТабБара с привязкой к контроллерам
    private func setUpTabs() {
        let gameVC = createNavigationController(
            title: Constants.gameTabName,
            image: UIImage(systemName: Constants.gameTabIcon),
            rootViewController: coordinator.tabControllers[Constants.gameKey] ?? UIViewController()
        )
        
        let shopVC = createNavigationController(
            title: Constants.shopTabName,
            image: UIImage(systemName: Constants.shopTabIcon),
            rootViewController: coordinator.tabControllers[Constants.shopKey] ?? UIViewController()
        )
        
        let userVC = createNavigationController(
            title: Constants.userTabName,
            image: UIImage(systemName: Constants.userTabIcon),
            rootViewController: coordinator.tabControllers[Constants.userKey] ?? UIViewController()
        )
        
        let teamVC = createNavigationController(
            title: Constants.teamTabName,
            image: UIImage(systemName: Constants.teamTabIcon),
            rootViewController: coordinator.tabControllers[Constants.teamKey] ?? UIViewController()
        )
        
        setViewControllers([gameVC, shopVC, userVC, teamVC], animated: true)
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
    }
}

// MARK: - Constants

private extension MainTabBarController {
    enum Constants {
        static let gameTabName = "Игра"
        static let gameTabIcon = "cursorarrow.click.2"
        static let gameKey = "gameVC"
        
        static let shopTabName = "Магазин"
        static let shopTabIcon = "cart.fill"
        static let shopKey = "shopVC"
        
        static let userTabName = "Игрок"
        static let userTabIcon = "person.circle.fill"
        static let userKey = "userVC"
        
        static let teamTabName = "Команда"
        static let teamTabIcon = "person.2.badge.gearshape.fill"
        static let teamKey = "teamVC"
    }
}
