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
    
    // MARK: - Public properties
    //let items: [Item] = DataSource.shared.gameItems
    let itemsSegueTest: [Item] = []
//    var userWallet = 0
    var delegate: ISendInfoAboutCharacterDelegate?
    
    // MARK: - Private properties
    private var user = User.shared
    private var score = 0
    private var clickModify = 1
    
    // MARK: - Override methods
    override func viewDidLoad() {
        super.viewDidLoad()
        walletLabel.text = String(user.wallet)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        modifySetup()
    }
    
    @IBAction func tapOnFarmButton() {
        score += clickModify
        updateCharacterWallet(with: score)
    }
    
    // MARK: - Private methods
    private func modifySetup() {
        user.items.forEach { item in
            switch item.actionOperator{
            case .add:
                clickModify += item.modifier
            case .multiply:
                clickModify *= item.modifier
            case .assets:
                return
            }
        }
    }
    
    private func updateCharacterWallet(with newValue: Int) {
        user.wallet += newValue
        walletLabel.text = user.wallet.description
    }
}

//extension ClickViewController: ISendInfoAboutCharacterDelegate {
//    func updateCharacterWallet(with newValue: Int) {
//        user.wallet += newValue
//        walletLabel.text = user.wallet.description
//    }
//}

