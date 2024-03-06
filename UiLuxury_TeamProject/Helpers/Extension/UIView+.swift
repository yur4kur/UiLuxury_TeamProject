//
//  ClickViewController.swift
//  UiLuxury_TeamProject
//
//  Created by Юрий Куринной on 06.03.2024.
//

import UIKit

extension UIView {
    /// Метод позволяет добавлять вьюхи на экран, в одном скоупе, через запятую
    func addSubviews(_ views: UIView...) {
        views.forEach { addSubview($0) }
    }
    
    ///  Метод отключает маски у всех вьюх
    func disableAutoresizingMask(_ views: UIView...) {
        views.forEach { $0.translatesAutoresizingMaskIntoConstraints = false }
        
    }
}

