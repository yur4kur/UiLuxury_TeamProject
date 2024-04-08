//
//  UIImageView.swift
//  UiLuxury_TeamProject
//
//  Created by Акира on 06.04.2024.
//

import UIKit

/// Делаем расширение для UIImageView. для удобства в работе
extension UIImageView {
    /// Тут мы устанавливаем изображение, устанавливаем рамку и цвет рамки, после чего
    /// возвращаем его в контроллер готовым к дальнейшей работе
    func setupDeveloperImage(imageNamed: Int) -> UIImageView {
        let imageView = UIImageView()
        
        imageView.image = UIImage(named: String(imageNamed))
        imageView.contentMode = .scaleAspectFill
        imageView.layer.borderWidth = 2
        imageView.layer.borderColor = UIColor.white.cgColor
        imageView.translatesAutoresizingMaskIntoConstraints = false
        
        return imageView
    }
}
