//
//  ClickViewController.swift
//  UiLuxury_TeamProject
//
//  Created by Бийбол Зулпукаров on 28/7/23.
//

import UIKit

class ClickViewController: UIViewController {

    // MARK: - Override methods
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    

    let items: [Item] = DataSource.shared.gameItems
    
    var score = 0
   
    
    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    
    @IBAction func clickerTapped() {
        score += 1
        items.forEach { item in
            switch item.itemOperator {
            case .add:
                score += item.itemModifier
            case .multiply:
                score *= item.itemModifier
            case .assets:
                return
            }
        }
        print(score)
    }
    
}
