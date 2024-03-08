//
//  InfoCharacterViewController.swift
//  UiLuxury_TeamProject
//
//  Created by Eldar Abdullin on 7/3/24
//

import UIKit

// MARK: - InfoCharacter ViewController
final class InfoCharacterViewController: UIViewController {

    // MARK: - Public properties
    var delegate: ISendInfoAboutCharacterDelegate?
    // var items: [Item] = DataSource.shared.gameItems
    // var userWallet = 0

    // MARK: - Private properties
    private let userImageView = UIImageView()
    private let walletLabel = UILabel()
    private let boughtItemsTableView = UITableView()

    private var user = User.shared

    // MARK: - Lifecycle methods
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        updateCreditsValue()
    }

    // MARK: - Private methods
    private func updateCreditsValue() {
        DispatchQueue.main.async {
            self.boughtItemsTableView.reloadData()
            self.walletLabel.text = "Credits: \(self.user.wallet)"
        }
    }

    @objc private func showDevelopersInfo() {
        let developersInfoVC = DevelopersInfoViewController()
        developersInfoVC.modalPresentationStyle = .fullScreen
        navigationController?.pushViewController(developersInfoVC, animated: true)
    }
}

// MARK: - Configure UI
private extension InfoCharacterViewController {
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
    func setupView() {
        view.backgroundColor = .white

        navigationItem.title = user.name

        navigationItem.rightBarButtonItem = UIBarButtonItem(
            image: UIImage(systemName: "gearshape.fill"),
            style: .plain,
            target: self,
            action: #selector(showDevelopersInfo)
        )
        navigationItem.rightBarButtonItem?.tintColor = .gray

        navigationItem.backBarButtonItem = UIBarButtonItem(
            title: "Back",
            style: .plain,
            target: nil,
            action: nil
        )
        navigationItem.backBarButtonItem?.tintColor = .gray
    }

    func setupUserImageView() {
        userImageView.image = UIImage(systemName: "figure.wave")
        userImageView.contentMode = .scaleAspectFill
        userImageView.tintColor = .systemBlue
    }

    func setupWalletLabel() {
        walletLabel.font = .systemFont(ofSize: 17)
        walletLabel.textColor = .black
        walletLabel.textAlignment = .center
    }

    func setupBoughtItemsTableView() {
        boughtItemsTableView.dataSource = self
        boughtItemsTableView.delegate = self
        boughtItemsTableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        boughtItemsTableView.showsVerticalScrollIndicator = false
        boughtItemsTableView.separatorStyle = .none
    }

    func addSubviews() {
        view.addSubviews(userImageView, walletLabel, boughtItemsTableView)
        view.disableAutoresizingMask(userImageView, walletLabel, boughtItemsTableView)
    }
}

// MARK: - Constraints
private extension InfoCharacterViewController {
    func setConstraints() {
        NSLayoutConstraint.activate([
            userImageView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20),
            userImageView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            userImageView.heightAnchor.constraint(equalTo: userImageView.widthAnchor, multiplier: 1, constant: 32),

            walletLabel.topAnchor.constraint(equalTo: userImageView.bottomAnchor, constant: 20),
            walletLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            walletLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            walletLabel.heightAnchor.constraint(equalToConstant: 22),

            boughtItemsTableView.topAnchor.constraint(equalTo: view.centerYAnchor),
            boughtItemsTableView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            boughtItemsTableView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            boughtItemsTableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
    }
}

// MARK: - TableView DataSource
extension InfoCharacterViewController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        user.items.count
    }

    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        user.items[section].title
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        1
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = boughtItemsTableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)

        var content = cell.defaultContentConfiguration()
        content.text = user.items[indexPath.section].description
        content.secondaryText = "Sell: \(user.items[indexPath.section].price)"

        cell.contentConfiguration = content

        return cell
    }
}

// MARK: - TableView Delegate
extension InfoCharacterViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let itemNameLabel = UILabel(frame: CGRect(x: 17, y: 3, width: tableView.frame.width, height: 20))
        itemNameLabel.text = "\(user.items[section].title)"
        itemNameLabel.font = UIFont.boldSystemFont(ofSize: 17)
        itemNameLabel.textColor = .gray

        let contentView = UIView()
        contentView.addSubview(itemNameLabel)

        return contentView
    }

    func tableView(_ tableView: UITableView, willDisplayHeaderView view: UIView, forSection section: Int) {
        view.backgroundColor = .tertiarySystemGroupedBackground
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        showAlert(withTitle: "Sell this item", andMessage: "Do you really want to sell it?") { [weak self] action in
            switch action {
            case .confirm:
                guard let itemPrice = self?.user.items[indexPath.section].price else { return }
                self?.user.wallet += itemPrice
                self?.user.items.remove(at: indexPath.section)
                self?.updateCreditsValue()
            case .refuse:
                tableView.deselectRow(at: indexPath, animated: true)
            }
        }
    }
}

// MARK: - Alert Controller
private extension InfoCharacterViewController {
    enum AlertAction {
        case confirm
        case refuse
    }

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
    func updateCharacterWallet(with newValue: Int) {
        //userNameLabel.text = newValue.description
    }
}
