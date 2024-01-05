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
    private var selectCells: [Item] = []
    private var selectIndexCells: [IndexPath] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    var delegate: ISendInfoAboutCharacterDelegate!
    
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
        
        let selectIndexCell = tableView.cellForRow(at: indexPath)
        let selectCell = shoppings[indexPath.section]
        
        if selectIndexCells.contains(indexPath) {
            selectIndexCell?.backgroundColor = .clear
            if let index = selectIndexCells.firstIndex(of: indexPath) {
                selectIndexCells.remove(at: index)
                selectCells.remove(at: index)
            }
        } else {
            if selectCells.count < 3 {
                selectIndexCell?.backgroundColor = .purple
                selectIndexCells.append(indexPath)
                selectCells.append(selectCell)
            } else {
                showAlerAction()
            }
        }
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    // MARK: - Navigation
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let basketListVS = segue.destination as? BasketListViewController else { return }
        basketListVS.selectCells = selectCells
        basketListVS.delegate = self
        
    }
}

//MARK: - Update Data Delegate

extension ShopListViewController: IUpdateDataDelegate {
    func updateData(updateSelectCells: [Item]) {
        self.selectCells = updateSelectCells
    }
}

private extension ShopListViewController {
    func showAlerAction() {
        let alert = UIAlertController(
            title: "Упс",
            message: "В корзину можно добавить только ТРИ апгрейда",
            preferredStyle: .alert)
        let okAktion = UIAlertAction(title: "Ок", style: .default)
        alert.addAction(okAktion)
        present(alert, animated: true)
    }
}
