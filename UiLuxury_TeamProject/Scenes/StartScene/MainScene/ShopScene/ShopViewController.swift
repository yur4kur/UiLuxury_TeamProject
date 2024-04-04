//
//  ShopViewController.swift
//  UiLuxury_TeamProject
//
//  Created by Kirill Tokarev on 28/7/23.

import UIKit

// MARK: - ShopViewController

final class ShopViewController: UIViewController {
    
    //MARK: - Private properties
    
    // TODO: Проверить необходимость в полях после внедрения вью-модели
    /// Описание товара
    //private let descriptionLabel = UILabel()
    
    /// Цена товара
    //private let priceLabel = UILabel()
    
    /// Таблица с товарами
    private let tableView = UITableView()
    
    /// Покупки пользователя
    private var shoppings = Item.getItems()
    
    /// Выбранные ячейки, которые будут переданы в корзину
    private var selectCells: [Item] = []
    
    /// Координатор контроллера
    private let coordinator: TabCoordinatorProtocol!
    
    /// Экземпляр вью модели
    private var viewModel: ShopViewModelProtocol!
    
    // MARK: - Initializers
    
    init(coordinator: TabCoordinatorProtocol) {
        self.coordinator = coordinator
        super.init(nibName: nil, bundle: nil)
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError(GlobalConstants.fatalError)
    }
    // MARK: - Lifecycle methods
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupBinding()
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
    @objc private func goToBasket() {
        getPurchases()
        let basketVC = BasketViewController()
        basketVC.selectCells = selectCells
        navigationController?.pushViewController(basketVC, animated: true)
    }
}

// MARK: - TableView DataSource

extension ShopViewController: UITableViewDataSource {
    
    ///Количество секций
    func numberOfSections(in tableView: UITableView) -> Int {
        shoppings.count
    }
    
    ///Количество ячеек в секции
    func tableView(_ tableView: UITableView,numberOfRowsInSection section: Int) -> Int {
        1
    }
    
    ///Настройка вида ячеки
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: Constants.cell, for: indexPath)
        
        var content = cell.defaultContentConfiguration()
        content.text = shoppings[indexPath.section].description
        content.secondaryText = "\(Constants.buy)\(shoppings[indexPath.section].price.formatted())"
        
        cell.backgroundColor = .clear
        cell.layer.cornerRadius = 8
        cell.layer.maskedCorners = [.layerMaxXMaxYCorner, .layerMinXMaxYCorner]
        cell.layer.borderWidth = 2
        cell.layer.borderColor = CGColor(red: 1, green: 1, blue: 1, alpha: 1)
        cell.contentConfiguration = content
        
        return cell
    }
}

// MARK: - TableView Delegate

extension ShopViewController: UITableViewDelegate {
    
    //MARK: Setup Footers
    
    /// Настройка заголовка секции таблицы
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let itemNameLabel = UILabel(frame: CGRect(x: 17, y: 3, width: tableView.frame.width, height: 20))
        itemNameLabel.text = "\(shoppings[section].title)"
        itemNameLabel.font = UIFont.boldSystemFont(ofSize: 17)
        itemNameLabel.textColor = .darkGray

        let contentView = UIView()
        contentView.layer.cornerRadius = 8
        contentView.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        contentView.addSubview(itemNameLabel)

        return contentView
    }
        
    ///Цвет заголовка секции таблицы
    func tableView(_ tableView: UITableView, willDisplayHeaderView view: UIView, forSection section: Int) {
        view.backgroundColor = .tertiarySystemGroupedBackground
    }
   
    // MARK: Setup chosen cell
    
    //TODO: Добавить алерт
    ///Метод выбора ячейки и смены тогла
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        if let cell = tableView.cellForRow(at: indexPath) {
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

// MARK: - Setup Binding

private extension ShopViewController {
    
    /// Метод связывает контроллер с вьюмоделью
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
            view.disableAutoresizingMask(
            tableView
            )
            
            setupNavBar()
            setupTableView()
        }
        
        // MARK: Setup NavigationBar
        
        ///Настройка NavigationView
        func setupNavBar() {
            navigationItem.rightBarButtonItem = UIBarButtonItem(
                image: UIImage(systemName: Constants.basket),
                style: .plain,
                target: self,
                action: #selector(goToBasket)
            )
        }
        
        // MARK: Setup TableView
        
        ///Настройка таблицы
        func setupTableView() {
            tableView.register(UITableViewCell.self, forCellReuseIdentifier: Constants.cell)
            tableView.backgroundColor = .clear
            
            tableView.dataSource = self
            tableView.delegate = self
            setConstraints()
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
                    tableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
                ]
            )
        }
    }


// MARK: - Alert

private extension ShopViewController {
    
    // TODO: Изменить алерт, если будет отказ от корзины
    /// Метод запускает алерт, если юзер пытается добавить в корзину больше 3 товаров
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

// MARK: - Constants

private extension ShopViewController {
    
    /// Текстовые элементы, используемые в коде
    enum Constants {
        static let cell = "cell"
        static let basket = "basket"
        static let buy = "Купить: $"
        static let ok = "Ok"
        static let ups = "Упс"
        static let messege = "В корзину можно добавить только ТРИ апгрейда"
    }
}
