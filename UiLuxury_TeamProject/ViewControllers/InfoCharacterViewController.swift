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
        tableView.deselectRow(at: indexPath, animated: false)
    }
}
    
// MARK: - Protocol
extension InfoCharacterViewController: ISendInfoAboutCharacterDelegate {
    
    func updateCharacterWallet(with newValue: Int) {
        //userNameLabel.text = newValue.description
    }
}
