//
//  InfoCharacterViewController.swift
//  UiLuxury_TeamProject
//
//  Created by Бийбол Зулпукаров on 28/7/23.
//

import UIKit

final class InfoCharacterViewController: UIViewController {
    
    // MARK: - IBOutlets
    
    private var userInfoStackView = UIStackView()
    private var userImageView = UIImageView()
    private var walletLabel = UILabel()
    @IBOutlet var boughtItemsTableView: UITableView!
    
    // MARK: - Public properties
    
    //var items: [Item] = DataSource.shared.gameItems
    var userWallet: Int!
    var delegate: ISendInfoAboutCharacterDelegate!
    
    // MARK: - Private properties
    
    private var user = User.shared

    // MARK: - Public methods
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = user.name
        setupUI()
        boughtItemsTableView.dataSource = self
        boughtItemsTableView.delegate = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        updateInfoChararcter()
    }
    
    // MARK: - Private properties
    
    private func updateInfoChararcter() {
        DispatchQueue.main.async {
            self.boughtItemsTableView.reloadData()
            self.walletLabel.text = "Credits: \(self.user.wallet)"
        }
    }
}


// MARK: - TableViewDataSource

extension InfoCharacterViewController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        user.items.count
    }
    
    func tableView(_ tableView: UITableView,
                   titleForHeaderInSection section: Int) -> String? {
        user.items[section].title
    }
    
    func tableView(_ tableView: UITableView,
                   numberOfRowsInSection section: Int) -> Int {
        1
    }
    
    func tableView(_ tableView: UITableView,
                   cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = boughtItemsTableView.dequeueReusableCell(
            withIdentifier: "cell", for: indexPath)
        
        var content = cell.defaultContentConfiguration()
        content.text = user.items[indexPath.section].description
        content.secondaryText = "Sell: \(user.items[indexPath.row].price)"
        
        cell.contentConfiguration = content
        
        return cell
    }
}

// MARK: - TableViewDelegate

extension InfoCharacterViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView,
                   viewForHeaderInSection section: Int) -> UIView? {
        let itemNameLabel = UILabel(
        frame: CGRect(
            x: 16,
            y: 3,
            width: tableView.frame.width,
            height: 20))
        itemNameLabel.text = "\(user.items[section].title)"
        itemNameLabel.font = UIFont.boldSystemFont(ofSize: 16)
        itemNameLabel.textColor = .white
        
        let contentView = UIView()
        contentView.addSubview(itemNameLabel)
        
        return contentView
    }

    func tableView(_ tableView: UITableView,
                            willDisplayHeaderView view: UIView,
                            forSection section: Int) {
        view.backgroundColor = .gray
    }
    
    func tableView(_ tableView: UITableView,
                   didSelectRowAt indexPath: IndexPath) {
        showAlert(withTitle: "Sell this item",
                  andMessage: "Do you really want to sell it?") { [weak self] action in
            switch action {
            case .confirm:
                guard let itemPrice = self?.user.items[indexPath.section].price else { return }
                self?.user.wallet += itemPrice
                self?.user.items.remove(at: indexPath.section)
                self?.updateInfoChararcter()
            case .refuse:
                tableView.deselectRow(at: indexPath, animated: true)
            }
        }
    }
}
   
// MARK: - Configure UI elements

private extension InfoCharacterViewController {
    func setupUI() {
        
        addSuviews()
        
        setupViews()
        
        setConstraints()

        print("test")


    }

    func test() {}
}

// MARK: - Setup UI

private extension InfoCharacterViewController {
    
    func addSuviews() {
        view.addSubview(userInfoStackView)
        view.addSubview(userImageView)
        
        userInfoStackView.addArrangedSubview(userImageView)
        userInfoStackView.addArrangedSubview(walletLabel)
    }
    
    func setupViews() {
        
        // MARK: UserInfoStackView
        userInfoStackView.contentMode = .scaleToFill
        userInfoStackView.axis = .vertical
        userInfoStackView.distribution = .equalSpacing
        userInfoStackView.spacing = 62
        userInfoStackView.translatesAutoresizingMaskIntoConstraints = false
        
        // MARK: UserImageView
        userImageView.contentMode = .scaleAspectFit
        userImageView.translatesAutoresizingMaskIntoConstraints = false
        userImageView.image = UIImage.init(systemName: "swift")
        
        // MARK: WalletLabel
        walletLabel.contentMode = .left
        //walletLabel.text = "Label"
        walletLabel.textAlignment = .center
        walletLabel.lineBreakMode = .byTruncatingTail
        walletLabel.baselineAdjustment = .alignBaselines
        walletLabel.adjustsFontSizeToFitWidth = false
        walletLabel.translatesAutoresizingMaskIntoConstraints = false
        walletLabel.font = .systemFont(ofSize: 17)
    }
    
}

// MARK: - Constraints

private extension InfoCharacterViewController {
    
    func setConstraints() {
        
        NSLayoutConstraint.activate([
           
        userInfoStackView.topAnchor.constraint(
            equalTo: view.safeAreaLayoutGuide.topAnchor,
            constant: 16
        ),
        userInfoStackView.leadingAnchor.constraint(
            equalTo: view.safeAreaLayoutGuide.leadingAnchor,
            constant: 16
        ),
        userInfoStackView.trailingAnchor.constraint(
            equalTo: view.safeAreaLayoutGuide.trailingAnchor,
            constant: -16
        ),
        
        ])
    }
}

// MARK: - Alert Controller

extension InfoCharacterViewController {
    enum AlertAction {
        case confirm
        case refuse
    }
    
    func showAlert(withTitle title: String,
                   andMessage message: String,
                   _ handler: @escaping (AlertAction) -> Void) {
        let alert = UIAlertController(title: title,
                                      message: message,
                                      preferredStyle: .alert)
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
// MARK: - Protocol
extension InfoCharacterViewController: ISendInfoAboutCharacterDelegate {
    
    func updateCharacterWallet(with newValue: Int) {
        //userNameLabel.text = newValue.description
    }
}
