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
    @IBOutlet var userNameLabel: UILabel!
    @IBOutlet var boughtItemsTableView: UITableView!
    
    // MARK: - Bought items property
    let items: [Item] = DataSource.shared.gameItems
    //var delegate = ""
    
    // MARK: - Override methods
    override func viewDidLoad() {
        super.viewDidLoad()
        boughtItemsTableView.dataSource = self
        boughtItemsTableView.delegate = self
        userImageView.image = UIImage.init(systemName: "swift")
        userNameLabel.text = "User"
    }
}

// MARK: - TableView Extensions
extension InfoCharacterViewController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        items.count
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        items[section].title
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = boughtItemsTableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        
        var content = cell.defaultContentConfiguration()
        content.text = items[indexPath.section].description
        content.secondaryText = "Price: \(items[indexPath.row].price)"
        
        cell.contentConfiguration = content
        
        return cell
    }
}

extension InfoCharacterViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView,
                            viewForHeaderInSection section: Int) -> UIView? {
        let itemNameLabel = UILabel(
        frame: CGRect(
            x: 16,
            y: 3,
            width: tableView.frame.width,
            height: 20))
        itemNameLabel.text = "\(items[section].title)"
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
}
