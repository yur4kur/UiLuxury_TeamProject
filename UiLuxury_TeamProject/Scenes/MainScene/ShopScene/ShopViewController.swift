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
    private var viewModel: ShopViewModelProtocol! {
        didSet {
            viewModel.walletDidChange = { [unowned self] viewModel in
                walletLabel.text = viewModel.walletCount
                tableView.reloadData()
            }
        }
    }
    
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
        tableView.reloadData()
    }
}

// MARK: - TableView DataSource

extension ShopViewController: UITableViewDataSource {
    
    ///Количество секций
    func numberOfSections(in tableView: UITableView) -> Int {
        viewModel.numberOfSections
    }
    
    ///Количество ячеек в секции
    func tableView(_ tableView: UITableView,numberOfRowsInSection section: Int) -> Int {
        viewModel.numberOfRowsInSection
    }
    
    ///Настройка вида ячеки
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: Constants.cell, for: indexPath)
        
        var content = cell.defaultContentConfiguration()
        content.text = viewModel.getText(indexPath: indexPath)
        content.textProperties.lineBreakMode = .byTruncatingHead
        content.secondaryText = viewModel.getSecondaryText(indexPath: indexPath)
        content.secondaryTextProperties.font = .boldSystemFont(ofSize: 17)
        
        cell.contentConfiguration = content
        cell.backgroundColor = .clear
        cell.tintColor = .white
        cell.layer.cornerRadius = 8
        cell.layer.maskedCorners = [.layerMaxXMaxYCorner, .layerMinXMaxYCorner]
        cell.layer.borderWidth = 2
        cell.layer.borderColor = CGColor(red: 1, green: 1, blue: 1, alpha: 1)
        
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
        showBuyAlert(withTitle: Constants.buyMessage, andMessage: GlobalConstants.emptyString) { [weak self] action in
            switch action {
            case .confirm:
                self?.viewModel.buy(indexPath: indexPath) {
                    self?.showLowCoinsAlert()
                }
                self?.viewModel.playSoundBuy()
                //updateUI()
            case .refuse:
                tableView.deselectRow(at: indexPath, animated: true)
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
        walletLabel.text = viewModel.walletCount
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
                // MARK: TableView
                tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
                tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
                tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
                tableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
                
                // MARK: Wallet label
                walletLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: -20),
                walletLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16)
            ]
        )
    }
}

// MARK: - Alert

private extension ShopViewController {
    
    /// Метод запускает алерт, если юзер пытается добавить в корзину больше 3 товаров
    func showLowCoinsAlert() {
        let alert = UIAlertController(
            title: Constants.ups,
            message: Constants.message,
            preferredStyle: .alert)
        let okAktion = UIAlertAction(title: Constants.ok, style: .default)
        alert.addAction(okAktion)
        present(alert, animated: true)
    }
    
    
    /// Метод настройки алерт-контроллера
    func showBuyAlert(withTitle title: String, andMessage message: String, _ handler: @escaping (AlertAction) -> Void) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        
        let confirmAction = UIAlertAction(title: Constants.alertConfirmTitle, style: .default) { _ in
            handler(.confirm)
        }
        let refuseAction = UIAlertAction(title: Constants.alertRefuseTitle, style: .destructive) { _ in
            handler(.refuse)
        }
        
        alert.addAction(confirmAction)
        alert.addAction(refuseAction)
        
        present(alert, animated: true)
    }
    
    /// Действия алерт-контроллера покупки
    enum AlertAction {
        case confirm
        case refuse
    }
}

// MARK: - Constants

private extension ShopViewController {
    
    /// Текстовые элементы, используемые в коде
    enum Constants {
        static let cell = "cell"
        static let basket = "basket"
        static let ok = "Ok"
        static let ups = "Не хватает монет!"
        static let message = "На твоем счет недостаточно монет для покупки"
        static let buyMessage = "Купить?"
        static let alertConfirmTitle = "Да"
        static let alertRefuseTitle = "Нет"
        
    }
}
