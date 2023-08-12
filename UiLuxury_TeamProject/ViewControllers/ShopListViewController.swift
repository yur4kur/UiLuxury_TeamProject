//
//  ShopListViewController.swift
//  UiLuxury_TeamProject
//
//  Created by Бийбол Зулпукаров on 28/7/23.
//

import UIKit

final class ShopListViewController: UITableViewController {
    
    //MARK: - Private propertys
    
    private let shoppings = Item.getItem()
    private var selectedCells: [Item] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    // MARK: - Table view data source
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        shoppings.count
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        1
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cellMarket", for: indexPath)
        let content = shoppings[indexPath.section]
        cell.textLabel?.text = content.description
        cell.detailTextLabel?.text = "$\(content.price.formatted())"
        return cell
    }
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        shoppings[section].title
    }
    
    override func tableView(_ tableView: UITableView, willDisplayHeaderView view: UIView, forSection section: Int) {
        view.tintColor = .systemGray6
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let selectedCell = shoppings[indexPath.section]
        
        if selectedCells.count < 3 {
            selectedCells.append(selectedCell)
        } else {
            let alert = UIAlertController(
                title: "Упс",
                message: "В корзину можно добавить только ТРИ апгрейда",
                preferredStyle: .alert)
            let okAktion = UIAlertAction(title: "Ок", style: .default)
            alert.addAction(okAktion)
            present(alert, animated: true)
        }
        
    }
    
    // MARK: - Navigation
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let basketListVS = segue.destination as? BasketListViewController else { return }
        basketListVS.selectedCells = selectedCells
        basketListVS.delegate = self
    }
}

//MARK: - Update Data Delegate

extension ShopListViewController: IUpdateDataDelegate {
    func updateData(updatedArray: [Item]) {
        self.selectedCells = updatedArray
    }
}
