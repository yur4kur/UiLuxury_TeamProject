//
//  UIView+.swift
//  UIKitProgramming
//
//  Created by Евгений Сычёв on 21.06.2023.
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
    
    /// Метод добавляет вертикальный градиент с неизменяемыми цветами
    func addQuadroGradientLayer() {
        let gradient = CAGradientLayer()
        gradient.frame = bounds
        gradient.colors = [
            UIColor.systemCyan.cgColor,
            UIColor.systemMint.cgColor,
            UIColor.systemBlue.cgColor,
            UIColor.systemIndigo.cgColor
        ]
        gradient.locations = [0.0, 1.0]
        gradient.startPoint = CGPoint(x: 0, y: 0)
        gradient.endPoint = CGPoint(x: 0, y: 1)
        layer.insertSublayer(gradient, at: 0)
    }
}

