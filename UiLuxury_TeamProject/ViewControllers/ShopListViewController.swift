//
//  ShopListViewController.swift
//  UiLuxury_TeamProject
//
//  Created by Kirill Tokarev on 28/7/23.
//

import UIKit

// MARK: - ShopListViewController

final class ShopListViewController: UIViewController {
    
    //MARK: - Private properties
    
    private let shoppings = Item.getItem()
    private var selectCells: [Item] = []
    private var selectIndexCells: [IndexPath] = []
    private let descriptionLabel = UILabel()
    private let priceLabel = UILabel()
    
    let tableView: UITableView = {
        let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        return tableView
    }()
    
    // MARK: - Public properties
    
    var delegate: ISendInfoAboutCharacterDelegate!
    
    // MARK: - Public methods
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
    }
    ///Настройка View
    private func setupViews() {
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(
            image: UIImage(systemName: "basket"),
            style: .plain,
            target: self,
            action: #selector(goBasket)
        )
        
        view.backgroundColor = .white
        view.addSubview(tableView)
        setupTableView()
    }
    ///Метод перехода на экран корзины
    @objc private func goBasket() {
        let vc = BasketListViewController()
        vc.selectCells = selectCells
        vc.delegate = self
        //vc.modalPresentationStyle = .fullScreen
        present(vc, animated: true)
    }
}

// MARK: - TableView DataSource

extension ShopListViewController: UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        shoppings.count
    }
    
    func tableView(_ tableView: UITableView,numberOfRowsInSection section: Int) -> Int {
        1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        var content = cell.defaultContentConfiguration()
        content.text = shoppings[indexPath.section].description
        cell.contentConfiguration = content
        return cell
    }
}

// MARK: - TableView Delegate

extension ShopListViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        shoppings[section].title
    }
    
    func tableView(_ tableView: UITableView, willDisplayHeaderView view: UIView, forSection section: Int) {
        view.tintColor = .systemGray5
    }
    
    func tableView(_ tableView: UITableView, titleForFooterInSection section: Int) -> String? {
        "$\(shoppings[section].price.formatted())"
    }
    
    func tableView(_ tableView: UITableView, willDisplayFooterView view: UIView, forSection section: Int) {
        view.tintColor = .systemGray6
    }
    
    // Метод нужно исправить, не отрабатывает
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
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

//MARK: - Update Data Delegate

extension ShopListViewController: UpdateDataDelegate {
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
