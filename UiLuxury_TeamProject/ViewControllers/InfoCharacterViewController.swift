//
//  InfoCharacterViewController.swift
//  UiLuxury_TeamProject
//
//  Created by Бийбол Зулпукаров on 28/7/23.
//

import UIKit

final class InfoCharacterViewController: UIViewController {
    
    // MARK: - IBOutlets
    @IBOutlet var userImageView: UIImageView!
    @IBOutlet var walletLabel: UILabel!
    @IBOutlet var boughtItemsTableView: UITableView!
    
    // MARK: - Public properties
    //var items: [Item] = DataSource.shared.gameItems
    var userWallet: Int!
    var delegate: ISendInfoAboutCharacterDelegate!
    
    // MARK: - Private properties
    private var user = User.shared

    // MARK: - Override methods
    override func viewDidLoad() {
        super.viewDidLoad()
        boughtItemsTableView.dataSource = self
        boughtItemsTableView.delegate = self
        userImageView.image = UIImage.init(systemName: "swift")
        navigationItem.title = user.name
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        walletLabel.text = "Credits: \(user.wallet)"
    }
}


// MARK: TableViewDataSource
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

// MARK: TableViewDelegate
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
                self?.user.items.remove(at: indexPath.section)
                DispatchQueue.main.async {
                    self?.boughtItemsTableView.reloadData()
                }
            case .refuse:
                tableView.deselectRow(at: indexPath, animated: true)
            }
        }
    }
}
   
// MARK: - Alert
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
