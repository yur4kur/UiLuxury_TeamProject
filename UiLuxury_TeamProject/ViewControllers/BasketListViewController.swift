//
//  BasketListViewController.swift
//  UiLuxury_TeamProject
//
//  Created by Бийбол Зулпукаров on 28/7/23.
//

import UIKit

protocol IUpdateDataDelegate {
    func updateData(updateSelectCells: [Item])
}

final class BasketListViewController: UITableViewController {
    
    var selectCells: [Item] = []
    var delegate: IUpdateDataDelegate!
    
    override func viewDidLoad() {
        super.viewDidLoad()
}
    
    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        selectCells.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cellBasket", for: indexPath)
        cell.textLabel?.text = selectCells[indexPath.row].title
        cell.detailTextLabel?.text = "$\(selectCells[indexPath.row].price.formatted())"
        return cell
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            selectCells.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
        }
        delegate.updateData(updateSelectCells: selectCells)
    }
}
