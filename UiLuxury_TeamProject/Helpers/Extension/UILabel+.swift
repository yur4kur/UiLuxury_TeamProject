//
//  UILabel+.swift
//  UiLuxury_TeamProject
//
//  Created by Акира on 06.04.2024.
//

import UIKit

extension UILabel {
    
    func setupDeveloperNameLabels(with name: String) -> UILabel {
        let nameLabel = UILabel()
        
        nameLabel.text = name
        nameLabel.textAlignment = .center
        nameLabel.font = UIFont.systemFont(ofSize: 25)
        nameLabel.translatesAutoresizingMaskIntoConstraints = false
        
        return nameLabel
    }
    
}
