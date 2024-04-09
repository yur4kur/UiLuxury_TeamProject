//
//  UILabel+.swift
//  UiLuxury_TeamProject
//
//  Created by Акира on 06.04.2024.
//

import UIKit

/// Расширение для UILabel для более удобной работы
extension UILabel {
    /// Метод настройки лейблов с заранее предустановленными значениями.
    /// Текст берем из модели
    func setupDeveloperNameLabels(with name: String) -> UILabel {
        let nameLabel = UILabel()
        
        nameLabel.text = name
        nameLabel.textAlignment = .center
        nameLabel.font = UIFont.systemFont(ofSize: 25)
        nameLabel.translatesAutoresizingMaskIntoConstraints = false
        
        return nameLabel
    }
}
