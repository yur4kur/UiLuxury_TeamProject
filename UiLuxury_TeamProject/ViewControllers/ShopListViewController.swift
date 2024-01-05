//
//  ShopListViewController.swift
//  UiLuxury_TeamProject
//
//  Created by Бийбол Зулпукаров on 28/7/23.
//

import UIKit

// MARK: - ShopListViewController

final class ShopListViewController: UITableViewController {
    
    //MARK: - Private properties
    
    private let shoppings = Item.getItem()
    private var selectCells: [Item] = []
    private var selectIndexCells: [IndexPath] = []
    
    // MARK: - Public properties
    
    var delegate: ISendInfoAboutCharacterDelegate!
    
    // MARK: - Override methods
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    // MARK: - Navigation
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let basketListVS = segue.destination as? BasketListViewController else { return }
        basketListVS.selectCells = selectCells
        basketListVS.delegate = self
        
    }
}

// MARK: - TableView DataSource

extension ShopListViewController {
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        shoppings.count
    }
    
    override func tableView(_ tableView: UITableView, 
                            numberOfRowsInSection section: Int) -> Int {
        1
    }
    
    
    override func tableView(_ tableView: UITableView, 
                            cellForRowAt indexPath: IndexPath) -> UITableViewCell {
       
        let cell = tableView.dequeueReusableCell(
            withIdentifier: Constants.cellID,
            for: indexPath
        )
        let content = shoppings[indexPath.section]
        cell.textLabel?.text = content.description
        cell.detailTextLabel?.text = "$\(content.price.formatted())"
        
        return cell
    }
}

// MARK: - TableView Delegate

extension ShopListViewController {
    
    override func tableView(_ tableView: UITableView, 
                            titleForHeaderInSection section: Int) -> String? {
        shoppings[section].title
    }
    
    override func tableView(_ tableView: UITableView, 
                            willDisplayHeaderView view: UIView,
                            forSection section: Int) {
        view.tintColor = .systemGray6
    }
    
    override func tableView(_ tableView: UITableView, 
                            didSelectRowAt indexPath: IndexPath) {
        
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
}

// MARK: - Setting View

private extension ShopListViewController {
    
    func setupUI() {
        setupTableView()
    }
    
}

// MARK: - Setting Elements

private extension ShopListViewController {
    
    // MARK: Configure TableView
    
    func setupTableView() {
        tableView.register(UITableViewCell.self,
                           forCellReuseIdentifier: Constants.cellID)
    }
}

//MARK: - Update Data Delegate

extension ShopListViewController: IUpdateDataDelegate {
    func updateData(updateSelectCells: [Item]) {
        self.selectCells = updateSelectCells
    }
}

// MARK: - Alert

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

// MARK: - Constants

private extension ShopListViewController {
    enum Constants {
        static let cellID = "cellMarket"
    }
}
