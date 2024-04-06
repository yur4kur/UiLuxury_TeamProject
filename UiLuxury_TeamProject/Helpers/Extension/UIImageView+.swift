//
//  UIImageView.swift
//  UiLuxury_TeamProject
//
//  Created by Акира on 06.04.2024.
//

import UIKit

extension UIImageView {
    func setupDeveloperImage(imageNamed: Int) -> UIImageView {
        let imageView = UIImageView()
        
        imageView.image = UIImage(named: String(imageNamed))
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.layer.borderWidth = 2
        imageView.layer.borderColor = UIColor.yellow.cgColor
        imageView.translatesAutoresizingMaskIntoConstraints = false
        
        return imageView
    }
}
