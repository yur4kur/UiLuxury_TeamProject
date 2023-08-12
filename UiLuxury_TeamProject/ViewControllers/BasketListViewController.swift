//
//  BasketListViewController.swift
//  UiLuxury_TeamProject
//
//  Created by Бийбол Зулпукаров on 28/7/23.
//

import UIKit

protocol IUpdateDataDelegate {
    func updateData(updatedArray: [Item])
}

final class BasketListViewController: UITableViewController {
    
    var selectedCells: [Item] = []
    var delegate: IUpdateDataDelegate!
    
    override func viewDidLoad() {
        super.viewDidLoad()
}
    
    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        min(3, selectedCells.count)
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cellBasket", for: indexPath)
        cell.textLabel?.text = selectedCells[indexPath.row].title
        cell.detailTextLabel?.text = "$\(selectedCells[indexPath.row].price.formatted())"
        return cell
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            selectedCells.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
        }
        delegate.updateData(updatedArray: selectedCells)
    }
}
