//
//  InfoCharacterViewController.swift
//  UiLuxury_TeamProject
//
//  Created by Eldar Abdullin on 7/3/24
//

import UIKit

// MARK: - InfoCharacter ViewController

/// ViewController отображения информации о персонаже
final class InfoCharacterViewController: UIViewController {

    // MARK: - Public properties
    // var delegate: ISendInfoAboutCharacterDelegate?
    // var items: [Item] = DataSource.shared.gameItems
    // var userWallet = 0

    // MARK: - Private properties

    /// Изображение пользователя
    private var userImageView = UIImageView()

    /// Отображение количества кредитов
    private let walletLabel = UILabel()

    /// Таблица отображения купленных предметов
    private let itemsTableView = UITableView()

    /// Экземпляр модели User
    private var user = User.shared

    // MARK: - Lifecycle methods

    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        updateUserPic()
        updateCreditsValue()
    }

    // MARK: - Private methods

    /// Метод обновления изображения пользователя
    private func updateUserPic() {
        let credits = user.wallet

        switch credits {
        case 0...1499:
            guard let userPic = UIImage(named: "stage01") else { return }
            userImageView.image = userPic
        case 1500...2999:
            guard let userPic = UIImage(named: "stage02") else { return }
            userImageView.image = userPic
        case 3000...4499:
            guard let userPic = UIImage(named: "stage03") else { return }
            userImageView.image = userPic
        default:
            guard let userPic = UIImage(named: "stage04") else { return }
            userImageView.image = userPic
        }
    }

    /// Метод отображения обновленной информации о кредитах в таблице
    private func updateCreditsValue() {
        DispatchQueue.main.async {
            self.itemsTableView.reloadData()
            self.walletLabel.text = "Credits: \(self.user.wallet)"
        }
    }
}

// MARK: - Configure UI

private extension InfoCharacterViewController {

    /// Метод настройки пользовательского интерфейса
    func setupUI() {
        setupView()
        setupUserImageView()
        setupWalletLabel()
        setupBoughtItemsTableView()

        addSubviews()
        setConstraints()
    }
}

// MARK: - Setup UI

private extension InfoCharacterViewController {

    /// Метод настройки главного экрана
    func setupView() {
        view.addQuadroGradientLayer()
    }

    /// Метод настройки изображения пользователя
    func setupUserImageView() {
        userImageView.contentMode = .scaleAspectFit
    }

    /// Метод настройки отображения количества кредитов
    func setupWalletLabel() {
        walletLabel.font = .systemFont(ofSize: 17)
        walletLabel.textColor = .black
        walletLabel.textAlignment = .center
    }

    /// Метод настройки таблицы купленных предметов
    func setupBoughtItemsTableView() {
        itemsTableView.dataSource = self
        itemsTableView.delegate = self
        itemsTableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")

        itemsTableView.backgroundColor = .clear
        itemsTableView.separatorStyle = .none
        itemsTableView.layer.cornerRadius = 8
    }

    /// Метод добавления элементов интерфейса на главный экран и отключения масок AutoLayout
    func addSubviews() {
        view.addSubviews(
            userImageView,
            walletLabel,
            itemsTableView
        )

        view.disableAutoresizingMask(
            userImageView,
            walletLabel,
            itemsTableView
        )
    }
}

// MARK: - Constraints

private extension InfoCharacterViewController {

    /// Метод установки констреинтов элементов интерфейса
    func setConstraints() {
        NSLayoutConstraint.activate([
            userImageView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20),
            userImageView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            userImageView.heightAnchor.constraint(equalToConstant: 150),
            userImageView.widthAnchor.constraint(equalToConstant: 150),

            walletLabel.topAnchor.constraint(equalTo: userImageView.bottomAnchor, constant: 32),
            walletLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            walletLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            walletLabel.heightAnchor.constraint(equalToConstant: 22),

            itemsTableView.topAnchor.constraint(equalTo: view.centerYAnchor),
            itemsTableView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            itemsTableView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            itemsTableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -20)
        ])
    }
}

// MARK: - TableView DataSource

extension InfoCharacterViewController: UITableViewDataSource {

    /// Метод определения количества секций таблицы
    func numberOfSections(in tableView: UITableView) -> Int {
        user.items.count
    }

    /// Метод присвоения названий секциям таблицы
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        user.items[section].title
    }

    /// Метод определения количества ячеек внутри одной секции таблицы
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        1
    }

    /// Метод настройки ячейки таблицы
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = itemsTableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)

        var content = cell.defaultContentConfiguration()
        content.text = user.items[indexPath.section].description
        content.secondaryText = "Sell: \(user.items[indexPath.section].price)"

        cell.backgroundColor = .white
        cell.layer.cornerRadius = 8
        cell.layer.maskedCorners = [.layerMaxXMaxYCorner, .layerMinXMaxYCorner]

        cell.contentConfiguration = content

        return cell
    }
}

// MARK: - TableView Delegate

extension InfoCharacterViewController: UITableViewDelegate {

    /// Метод настройки отображения хедера секции
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let itemNameLabel = UILabel(frame: CGRect(x: 17, y: 3, width: tableView.frame.width, height: 20))
        itemNameLabel.text = "\(user.items[section].title)"
        itemNameLabel.font = UIFont.boldSystemFont(ofSize: 17)
        itemNameLabel.textColor = .gray

        let contentView = UIView()
        contentView.layer.cornerRadius = 8
        contentView.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        contentView.addSubview(itemNameLabel)

        return contentView
    }

    /// Метод настройки фона хедера секции
    func tableView(_ tableView: UITableView, willDisplayHeaderView view: UIView, forSection section: Int) {
        view.backgroundColor = .tertiarySystemGroupedBackground
    }

    /// Метод настройки поведения приложения при нажатии на ячейку таблицы
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let cell = tableView.cellForRow(at: indexPath) {
            cell.selectedBackgroundView?.layer.cornerRadius = 8
            cell.selectedBackgroundView?.layer.maskedCorners = [.layerMinXMaxYCorner, .layerMaxXMaxYCorner]
        }

        showAlert(withTitle: "Sell this item", andMessage: "Do you really want to sell it?") { [weak self] action in
            switch action {
            case .confirm:
                guard let itemPrice = self?.user.items[indexPath.section].price else { return }
                self?.user.wallet += itemPrice
                self?.user.items.remove(at: indexPath.section)
                self?.updateUserPic()
                self?.updateCreditsValue()
            case .refuse:
                tableView.deselectRow(at: indexPath, animated: true)
            }
        }
    }
}

// MARK: - Alert Controller

private extension InfoCharacterViewController {

    /// Действия алерт-контроллера
    enum AlertAction {
        case confirm
        case refuse
    }

    /// Метод настройки алерт-контроллера
    func showAlert(withTitle title: String, andMessage message: String, _ handler: @escaping (AlertAction) -> Void) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)

        let confirmAction = UIAlertAction(title: "Confirm", style: .default) { _ in
            handler(.confirm)
        }
        let refuseAction = UIAlertAction(title: "Refuse", style: .destructive) { _ in
            handler(.refuse)
        }

        alert.addAction(confirmAction)
        alert.addAction(refuseAction)

        present(alert, animated: true)
    }
}

// TODO: - InfoCharacter ViewController Protocol

extension InfoCharacterViewController: ISendInfoAboutCharacterDelegate {

    /// Метод обновления количества кредитов
    func updateCharacterWallet(with newValue: Int) {
        //userNameLabel.text = newValue.description
    }
}
