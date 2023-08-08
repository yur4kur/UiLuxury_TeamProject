//
//  InfoCharacterViewController.swift
//  UiLuxury_TeamProject
//
//  Created by Бийбол Зулпукаров on 28/7/23.
//

import UIKit

class InfoCharacterViewController: UIViewController {
    
    @IBOutlet var userImageView: UIImageView!
    @IBOutlet var userNameLabel: UILabel!
    @IBOutlet var boughtItemsTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        boughtItemsTableView.dataSource = self
        boughtItemsTableView.delegate = self
        userImageView.image = UIImage.init(systemName: "swift")
        userNameLabel.text = "User"
    }
    
    
    
}

extension InfoCharacterViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        3
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = boughtItemsTableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        let content = cell.defaultContentConfiguration()
        cell.contentConfiguration = content
        return cell
    }
}

extension InfoCharacterViewController: UITableViewDelegate {
    
}
