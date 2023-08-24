//
//  ClickViewController.swift
//  UiLuxury_TeamProject
//
//  Created by Бийбол Зулпукаров on 28/7/23.
//

import UIKit

class ClickViewController: UIViewController {
    
    // MARK: - IBOutlets
    @IBOutlet var walletLabel: UILabel!
    
    // MARK: - Override methods
    override func viewDidLoad() {
        super.viewDidLoad()
//        modifySetup()
    }
    
    // MARK: - Public properties
    let items: [Item] = DataSource.shared.gameItems
    let itemsSegueTest: [Item] = []
//    var userWallet = 0
    var delegate: ISendInfoAboutCharacterDelegate?
    
    // MARK: - Private properties
    private var user = User.shared
    private var score = 0 {
        didSet {
            user.wallet += score
        }
    }
    private var clickModify = 1
    
    
    
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
        //print(userWallet)
    }
    
    @IBAction func tapOnFarmButton() {
        score += clickModify
        updateCharacterWallet(with: score)
//        delegate?.updateCharacterWallet(with: userWallet)
    }
 
    
}

extension ClickViewController: ISendInfoAboutCharacterDelegate {
    
    func updateCharacterWallet(with newValue: Int) {
        user.wallet += newValue
        walletLabel.text = user.wallet.description
    }
    
    
    
}

