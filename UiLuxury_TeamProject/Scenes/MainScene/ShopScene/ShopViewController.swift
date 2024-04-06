//
//  ShopViewController.swift
//  UiLuxury_TeamProject
//
//  Created by Kirill Tokarev on 28/7/23.

import UIKit

// MARK: - ShopViewController

final class ShopViewController: UIViewController {
    
    //MARK: - Private properties
    
    /// Таблица с товарами
    private let tableView = UITableView()

    /// Лейбл с текущим счетом игрока
    private let walletLabel = UILabel()
    
    /// Координатор контроллера
    private let coordinator: TabCoordinatorProtocol!
    
    /// Экземпляр вью модели
    private var viewModel: ShopViewModelProtocol!
    
    // MARK: - Initializers
    
    init(coordinator: TabCoordinatorProtocol) {
        self.coordinator = coordinator
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError(GlobalConstants.fatalError)
    }
    
    // MARK: - Lifecycle methods
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupBinding()
        setupUI()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        walletLabel.text = viewModel.walletCount.description
    }
}

// MARK: - TableView DataSource

extension ShopViewController: UITableViewDataSource {
    
    ///Количество секций
    func numberOfSections(in tableView: UITableView) -> Int {
        viewModel.numberOfSection
    }
    
    ///Количество ячеек в секции
    func tableView(_ tableView: UITableView,numberOfRowsInSection section: Int) -> Int {
        viewModel.numberOfRowsInSection
    }
    
    ///Настройка вида ячеки
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: Constants.cell, for: indexPath)
        cell.backgroundColor = .clear
        cell.tintColor = .white
        cell.layer.cornerRadius = 8
        cell.layer.maskedCorners = [.layerMaxXMaxYCorner, .layerMinXMaxYCorner]
        cell.layer.borderWidth = 2
        cell.layer.borderColor = CGColor(red: 1, green: 1, blue: 1, alpha: 1)
        viewModel.cellConfig(cell: cell, indexPath: indexPath, text: Constants.buy)
        return cell
    }
}

// MARK: - TableView Delegate

extension ShopViewController: UITableViewDelegate {
    
    //MARK: Setup Footers
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let itemNameLabel = UILabel(frame: CGRect(x: 17, y: 3, width: tableView.frame.width, height: 20))
        itemNameLabel.text = viewModel.getTitleHeader(section: section)
        itemNameLabel.font = UIFont.boldSystemFont(ofSize: 17)
        itemNameLabel.textColor = .darkGray
        
        let contentView = UIView()
        contentView.layer.cornerRadius = 8
        contentView.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        contentView.addSubview(itemNameLabel)
        
        return contentView
    }
    
    func tableView(_ tableView: UITableView, willDisplayHeaderView view: UIView, forSection section: Int) {
        view.backgroundColor = .tertiarySystemGroupedBackground
    }
    
    // MARK: Setup selected cell
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        guard let cell = tableView.cellForRow(at: indexPath) else { return }
        
        if cell.accessoryType == .checkmark {
            cell.accessoryType = .none
            viewModel.sell(indexPath: indexPath)
        } else {
            viewModel.buy(indexPath: indexPath) {
                cell.accessoryType = .checkmark
            } alertCompletion: {
                showAlerAction()
            }
        }
    }
}

// MARK: - Setup Binding

private extension ShopViewController {
    func setupBinding() {
        viewModel = ShopViewModel(userData: coordinator.userData)
    }
}

//MARK: - Configure UI

private extension ShopViewController {
    
    /// Метод собирает в себе настройки вьюх и устанавливает констрейнты вьюх
    func setupUI() {
        setupViews()
        setConstraints()
    }
}

// MARK: - Setup UI

private extension ShopViewController {
    
    // MARK: Setup Views
    
    ///Метод настраивает основное вью и запускает методы настройки сабвьюх
    func setupViews() {
        view.addQuadroGradientLayer()
        view.addSubview(tableView) // При вынесении в отдельный метод - не срабатывает
        view.addSubview(walletLabel)
        view.disableAutoresizingMask(
            tableView,
            walletLabel
        )
        setupTableView()
        setupWalletLabel()
    }
    
    // MARK: TableView
    
    ///Метод настройки таблицы
    func setupTableView() {
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: Constants.cell)
        tableView.backgroundColor = .clear
        
        tableView.dataSource = self
        tableView.delegate = self
        setConstraints()
    }
    
    // MARK: Wallet label
    
    /// Метод настраивает лейбл
    func setupWalletLabel() {
        walletLabel.text = viewModel.walletCount.description
        walletLabel.textColor = .black
        walletLabel.font = .preferredFont(forTextStyle: .body)
        walletLabel.textAlignment = .natural
    }
}

// MARK: - Constraints

private extension ShopViewController {
    
    ///Настройка констрейнтов таблицы
    func setConstraints() {
        NSLayoutConstraint.activate(
            [
                tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
                tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
                tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
                tableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
                
                walletLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: -20),
                walletLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16)
            ]
        )
    }
}

// MARK: - Alert

private extension ShopViewController {
    
    /// Метод запускает алерт, если юзер пытается добавить в корзину больше 3 товаров
    func showAlerAction() {
        let alert = UIAlertController(
            title: Constants.ups,
            message: Constants.message,
            preferredStyle: .alert)
        let okAktion = UIAlertAction(title: Constants.ok, style: .default)
        alert.addAction(okAktion)
        present(alert, animated: true)
    }
}

// MARK: - Constants

private extension ShopViewController {
    
    /// Текстовые элементы, используемые в коде
    enum Constants {
        static let cell = "cell"
        static let basket = "basket"
        static let buy = "Купить: $"
        static let ok = "Ok"
        static let ups = "Не хватает денег"
        static let message = "Твой счет ниже стоимости покупки"
    }
}
