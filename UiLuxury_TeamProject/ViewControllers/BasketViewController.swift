//
//  BasketViewController.swift
//  UiLuxury_TeamProject
//
//  Created by Kirill Tokarev on 28/7/23.
//

import UIKit

/* //TODO: Подумать над обновлением данных через протокол
 ///Протокол обновления данных массива выбранных товаров
 protocol UpdateDataDelegate {
 func updateData(updateSelectCells: [Item])
 } */

//MARK: - BasketListViewController

final class BasketViewController: UIViewController {
    
    // MARK: - Public properties
    
    /// Массив с выбранными элементами из магазина
    var selectCells = [Item]()
    
    // MARK: - Private properties
    
    /// Таблица с купленными товарами
    private let tableView = UITableView()
    
    // MARK: - Lifecycle methods
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
}

//MARK: - TableView DataSorce

extension BasketViewController: UITableViewDataSource {
    
    ///Колличество ячеек в секции
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        selectCells.count
    }
    
    ///Настройка вида ячеки
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: Constants.cell, for: indexPath)
        var content = cell.defaultContentConfiguration()
        content.text = selectCells[indexPath.row].title
        content.secondaryText = "$\(selectCells[indexPath.row].price.formatted())"
        cell.contentConfiguration = content
        cell.backgroundColor = .clear
        return cell
    }
    
    
}

// MARK: - TableView Delegate

extension BasketViewController: UITableViewDelegate {
    
    ///Удаление ячейки
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            selectCells.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
        }
    }
}

//MARK: - Configure UI

private extension BasketViewController {
    
    /// Метод собирает в себе настройки вьюх и устанавливает констрейнты вьюх
    func setupUI() {
        setupViews()
        setConstraints()
    }
}
    // MARK: - Setup UI
  
private extension BasketViewController {
    
    ///Настройка View
    private func setupViews() {
        view.addQuadroGradientLayer()
        view.addSubview(tableView)  // При вынесении в отдельный метод - не срабатывает
        view.disableAutoresizingMask(
        tableView
        )
        
        setupNavBar()
        setupTableView()
        setConstraints()
    }
    
    // MARK: Setup NavigationBar
    
    ///Настройка NavigationView
    func setupNavBar() {
        navigationItem.title = Constants.basket
    }
    
    ///Настройка Таблицы
    func setupTableView() {
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: Constants.cell)
        tableView.backgroundColor = .clear
        
        tableView.dataSource = self
        tableView.delegate = self
    }
}

// MARK: - Constraints

private extension BasketViewController {
    
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
// MARK: - Constants

private extension BasketViewController {
    
    /// Текстовые элементы, используемые в коде
    enum Constants {
        static let cell = "cell"
        static let basket = "Корзина"
    }
}
