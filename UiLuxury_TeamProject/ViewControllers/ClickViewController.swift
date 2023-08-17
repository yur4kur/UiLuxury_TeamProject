//
//  ClickViewController.swift
//  UiLuxury_TeamProject
//
//  Created by Бийбол Зулпукаров on 28/7/23.
//

import UIKit

class ClickViewController: UIViewController {
    
    @IBOutlet var walletLabel: UILabel!
    
    // MARK: - Override methods
    override func viewDidLoad() {
        super.viewDidLoad()
//        modifySetup()
    }
    
    
    let items: [Item] = DataSource.shared.gameItems
    let itemsSegueTest: [Item] = []
    
    var userWallet = 0
    private var clickModify = 1
    var delegate: ISendInfoAboutCharacterDelegate?
    
    
    // MARK: - Navigation
    
    func modifySetup() {
        items.forEach { item in
            switch item.actionOperator{
            case .add:
                clickModify += item.modifier
            case .multiply:
                clickModify *= item.modifier
            case .assets:
                return
            }
        }
        print(userWallet)
    }
    
    @IBAction func tapOnFarmButton() {
        userWallet += clickModify
        updateCharacterWallet(with: userWallet)
        delegate?.updateCharacterWallet(with: userWallet)
    }
 
    
}

extension ClickViewController: ISendInfoAboutCharacterDelegate {
    
    func updateCharacterWallet(with newValue: Int) {
        userWallet = newValue
        walletLabel.text = userWallet.description
    }
    
    
    
}

