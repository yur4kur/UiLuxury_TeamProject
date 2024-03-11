//
//  BasketListViewController.swift
//  UiLuxury_TeamProject
//
//  Created by Kirill Tokarev on 28/7/23.
//

import UIKit

///Протокол обновления данных массива выбранных товаров
protocol UpdateDataDelegate {
    func updateData(updateSelectCells: [Item])
}

final class BasketListViewController: UIViewController {
    ///Массив с выбранными элементами из магазина
    var selectCells: [Item] = []
    var delegate: UpdateDataDelegate!
    
    let tableView: UITableView = {
        let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        return tableView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
    }
    
    private func setupViews() {
        view.backgroundColor = .white
        view.addSubview(tableView)
        setupTableView()
    }
}

private extension BasketListViewController {
    ///Настройка Таблицы
    func setupTableView() {
        tableView.dataSource = self
        tableView.delegate = self
        
        registerCell()
        setConstraints()
    }
    /// Регистрация ячейки
    func registerCell() {
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
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
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        selectCells.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        var content = cell.defaultContentConfiguration()
        content.text = selectCells[indexPath.row].title
        content.secondaryText = "$\(selectCells[indexPath.row].price.formatted())"
        cell.contentConfiguration = content
        return cell
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            selectCells.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
        }
        delegate.updateData(updateSelectCells: selectCells)
    }
}
