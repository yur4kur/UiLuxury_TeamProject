//
//  StartViewController.swift
//  UiLuxury_TeamProject
//
//  Created by Бийбол Зулпукаров on 2/8/23.
//

import UIKit

class StartViewController: UIViewController{
    
    @IBOutlet var greetingsLabel: UILabel!
    @IBOutlet var nameTextField: UITextField!
    
    var user = User.shared
    
    
    // MARK: - Navigation
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let tabBarVC = segue.destination as? UITabBarController else {return}
        guard let viewControllers = tabBarVC.viewControllers else { return }


        viewControllers.forEach { ViewController in
            if let clickerVC = ViewController as? ClickViewController {
                clickerVC.delegate = self
            } else if let navigationVC = ViewController as? UINavigationController {
                let navigationViewControllers = navigationVC.viewControllers
                navigationViewControllers.forEach { NavigationController in
                    if let infoVC = NavigationController as? InfoCharacterViewController {
                        infoVC.delegate = self
                    } else if let shopListVC = NavigationController as? ShopListViewController {
                        shopListVC.delegate = self
                    }
                }
            }
        }


    }
    
    @IBAction func startButton() {
        user.name = nameTextField.text ?? "NewUser"
    }
    
}

extension StartViewController: ISendInfoAboutCharacterDelegate {
   
    func updateCharacterWallet(with newValue: Int) {
        
    }
}
