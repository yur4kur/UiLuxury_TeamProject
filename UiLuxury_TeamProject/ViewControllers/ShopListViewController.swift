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
    private let descriptionLabel = UILabel()
    private let priceLabel = UILabel()
    
    // MARK: - Public properties
    
    var delegate: ISendInfoAboutCharacterDelegate!
    
    // MARK: - Public methods
    
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
    
    // MARK: Section
    override func numberOfSections(in tableView: UITableView) -> Int {
        shoppings.count
    }
    
    // MARK: Row
    override func tableView(_ tableView: UITableView,
                            numberOfRowsInSection section: Int) -> Int {
        1
    }
    
    // MARK: Cell
    override func tableView(_ tableView: UITableView,
                            cellForRowAt indexPath: IndexPath) -> UITableViewCell {
       
        let cell = tableView.dequeueReusableCell(
            withIdentifier: Constants.cellID,
            for: indexPath
        )
        
//        let content = cell.contentConfiguration?.makeContentView()
       
//        cell.contentView.addSubview(descriptionLabel)
//        cell.contentView.addSubview(priceLabel)
        let textContent = shoppings[indexPath.section]
        cell.textLabel?.text = textContent.description
        cell.detailTextLabel?.text = "$\(textContent.price.formatted())"
//        descriptionLabel.text = textContent.description
//        priceLabel.text = "$\(textContent.price.formatted())"
//        cell.contentConfiguration = content as! any UIContentConfiguration
        
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

// MARK: - Configure UI

private extension ShopListViewController {
    
    func setupUI() {
        setupTableView()
        
    }
    
}

// MARK: - Setup UI

private extension ShopListViewController {
    
    func addCellSubviews() {
        
    }
    
    // MARK: Setup cell labels
    func setupCellLabels() {
        
        // MARK: Description Label
        descriptionLabel.isMultipleTouchEnabled = true
        descriptionLabel.contentMode = .left
        descriptionLabel.insetsLayoutMarginsFromSafeArea = false
//        descriptionLabel.text
        descriptionLabel.textAlignment = .natural
        descriptionLabel.lineBreakMode = .byTruncatingTail
        descriptionLabel.numberOfLines = 3
        descriptionLabel.baselineAdjustment = .alignBaselines
        descriptionLabel.adjustsFontSizeToFitWidth = false
        descriptionLabel.font = .systemFont(ofSize: 13)
        
        // MARK: Price label
        priceLabel.isMultipleTouchEnabled = true
        priceLabel.contentMode = .left
        priceLabel.insetsLayoutMarginsFromSafeArea = false
        //priceLabel.text = "Detail"
        priceLabel.textAlignment = .right
        priceLabel.lineBreakMode = .byTruncatingTail
        priceLabel.baselineAdjustment = .alignBaselines
        priceLabel.adjustsFontSizeToFitWidth = false
        priceLabel.font = .systemFont(ofSize: 20)
    }
    
    // MARK: Setup TableView
    func setupTableView() {
//        tableView.register(UITableViewCell.self,
//                           forCellReuseIdentifier: Constants.cellID)
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
