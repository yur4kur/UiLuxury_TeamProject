//
//  GameTabController.swift
//  UiLuxury_TeamProject
//
//  Created by Юрий Куринной on 09.03.2024.
//

import UIKit

// MARK: - GameTabViewController

class GameTabBarController: UITabBarController {

    // MARK: - Lifecycle Methods
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setUpTabs()
    }
    
    // MARK: - Private methods
    
    /// Метод создает NavigationController с прозрачной полосой и черными шрифтами
    private func createNavigationController(title: String,
                                            imageName: String,
                                            rootViewController: UIViewController) -> UINavigationController {
        let navigationController = UINavigationController(rootViewController: rootViewController)
        navigationController.tabBarItem.title = title
        navigationController.tabBarItem.image = UIImage(named: imageName)
        
        setupNavigationBar(navigationController)
        
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
            title: "Игра",
            imageName: "cursorarrow.click.2",
            rootViewController: ClickViewController()
        )
        
        let shopVC = createNavigationController(
            title: "Магазин",
            imageName: "clipboard.fill",
            rootViewController: ShopListViewController()
        )
        
        let userVC = createNavigationController(
            title: "Покупки",
            imageName: "bag.fill",
            rootViewController: InfoCharacterViewController()
        )
        
        let devsVC = createNavigationController(
            title: "Команда",
            imageName: "person.2.badge.gearshape.fill",
            rootViewController: DevelopersInfoViewController()
        )
        
        setViewControllers([clickVC, shopVC, userVC, devsVC], animated: true)
    }
    
    private func setupTabBar() {
        tabBar.barTintColor = .clear
        tabBar.tintColor = .white
        tabBar.unselectedItemTintColor = .black
    }

}
