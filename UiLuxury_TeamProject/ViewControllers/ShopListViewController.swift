//
//  ShopListViewController.swift
//  UiLuxury_TeamProject
//
//  Created by Kirill Tokarev on 28/7/23.
// Delete

import UIKit

// MARK: - ShopListViewController

final class ShopListViewController: UIViewController {
    
    //MARK: - Private properties
    
    private var shoppings = Item.getItem()
    private var selectCells: [Item] = []
    
    private let descriptionLabel = UILabel()
    private let priceLabel = UILabel()
    private let tableView = UITableView(frame: .zero, style: .insetGrouped)
    
    // MARK: - Public methods
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    //MARK: - Private Metods
    
   ///Метод отбора выбранных товаров
    private func getPurchases() {
        for item in shoppings {
            if item.isOn {
                selectCells.append(item)
            }
        }
    }
    
    ///Метод перехода на экран корзины
    @objc private func goBasket() {
        getPurchases()
        let basketVC = BasketListViewController()
        basketVC.selectCells = selectCells
        navigationController?.pushViewController(basketVC, animated: true)
    }
}

//MARK: - Configure UI

extension ShopListViewController {
    
    ///Настройка View
    private func setupUI() {
        view.backgroundColor = .white
        
        setupNavView()
        setupTableView()
    }
    
    ///Настройка NavigationView
    private func setupNavView() {
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(
            image: UIImage(systemName: Constants.basket),
            style: .plain,
            target: self,
            action: #selector(goBasket)
        )
    }
    
    ///Настройка Таблицы
    func setupTableView() {
        view.addSubview(tableView)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: Constants.cell)
        
        tableView.dataSource = self
        tableView.delegate = self
        setConstraints()
    }
    
    ///Настройка констрейнтов таблицы
    func setConstraints() {
        NSLayoutConstraint.activate(
            [
                tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
                tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
                tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
                tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
            ]
        )
    }
    
    
}

// MARK: - TableView DataSource

extension ShopListViewController: UITableViewDataSource {
    
    ///Колличество секций
    func numberOfSections(in tableView: UITableView) -> Int {
        shoppings.count
    }
    
    ///Колличество ячеек в секции
    func tableView(_ tableView: UITableView,numberOfRowsInSection section: Int) -> Int {
        1
    }
    
    ///Настрорйка вида ячеки
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: Constants.cell, for: indexPath)
        var content = cell.defaultContentConfiguration()
        content.text = "$\(shoppings[indexPath.section].price.formatted())"
        content.secondaryText = shoppings[indexPath.section].title
        cell.contentConfiguration = content
        return cell
    }
}

// MARK: - TableView Delegate

extension ShopListViewController: UITableViewDelegate {
    
    //MARK: Setup Footers
    
    ///Текст футера
    func tableView(_ tableView: UITableView, titleForFooterInSection section: Int) -> String? {
        shoppings[section].description
    }
    
    ///Цвет футурв
    func tableView(_ tableView: UITableView, willDisplayFooterView view: UIView, forSection section: Int) {
        view.tintColor = .systemGray6
    }
    
    //TODO: Добавить алерт
    ///Метод выбора ячейки и смены тогла
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        if let cell = tableView.cellForRow(at: indexPath as IndexPath) {
            if cell.accessoryType == .checkmark {
                cell.accessoryType = .none
                shoppings[indexPath.section].isOn.toggle()
            } else {
                cell.accessoryType = .checkmark
                shoppings[indexPath.section].isOn.toggle()
            }
        }
    }
    
    //TODO: Метод нужно исправить, не отрабатывает.
    
    /* func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
     
     let selectIndexCell = tableView.cellForRow(at: indexPath)
     let selectCell = shoppings[indexPath.section]
     
     if selectIndexCells.contains(indexPath) {
     selectIndexCell?.accessoryType = .none
     if let index = selectIndexCells.firstIndex(of: indexPath) {
     selectIndexCells.remove(at: index)
     selectCells.remove(at: index)
     }
     } else {
     if selectCells.count < 3 {
     selectIndexCell?.accessoryType = .checkmark
     //selectIndexCells.append(indexPath)
     selectCells.append(selectCell)
     } else {
     showAlerAction()
     }
     }
     tableView.deselectRow(at: indexPath, animated: true)
     }*/
    
}

// MARK: - Alert

private extension ShopListViewController {
    func showAlerAction() {
        let alert = UIAlertController(
            title: Constants.ups,
            message: Constants.messege,
            preferredStyle: .alert)
        let okAktion = UIAlertAction(title: Constants.ok, style: .default)
        alert.addAction(okAktion)
        present(alert, animated: true)
    }
}

private extension ShopListViewController {
    enum Constants {
        static let cell = "cell"
        static let basket = "basket"
        static let ok = "Ok"
        static let ups = "Упс"
        static let messege = "В корзину можно добавить только ТРИ апгрейда"
    }
}
