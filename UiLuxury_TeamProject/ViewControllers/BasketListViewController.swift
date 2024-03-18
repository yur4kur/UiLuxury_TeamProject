//
//  BasketListViewController.swift
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

final class BasketListViewController: UIViewController {
    
    ///Массив с выбранными элементами из магазина
    var selectCells = [Item]()
    private let tableView = UITableView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
    }
    
    ///Настройка View
    private func setupViews() {
        view.backgroundColor = .white
        setupTableView()
        setConstraints()
    }
    
    ///Настройка Таблицы
    func setupTableView() {
        view.addSubview(tableView)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        
        tableView.dataSource = self
        tableView.delegate = self
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


//MARK: - TableView DataSorce, Deligate

extension BasketListViewController: UITableViewDataSource, UITableViewDelegate {
    
    ///Колличество ячеек в секции
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        selectCells.count
    }
    
    ///Настрорйка вида ячеки
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        var content = cell.defaultContentConfiguration()
        content.text = selectCells[indexPath.row].title
        content.secondaryText = "$\(selectCells[indexPath.row].price.formatted())"
        cell.contentConfiguration = content
        return cell
    }
    
    ///Удаление ячейки
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            selectCells.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
        }
    }
}


