//
//  ShadowedButton.swift
//  UiLuxury_TeamProject
//
//  Created by Юрий Куринной on 11.03.2024.
//

import UIKit


// MARK: - ShadowedButton

/// Rастомнвя кнопку с тенью и анимацией тряски
class ShadowedButton: UIButton {
    
    // MARK: - Initializers
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupButton()
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Public properties
    
    /// Метод устанавливает анимацию в виде потряхивания кнопки справа-налево.
    /// Можно использовать в соответствующем методе для анимирования кнопки при нажатии.
    func setShakeAnimation() {
        let shake = CABasicAnimation(keyPath: "position")
        shake.duration = 0.1
        shake.repeatCount = 2
        shake.autoreverses = true
        
        let fromPoint = CGPoint(x: center.x - 8, y: center.y)
        let fromValue = NSValue(cgPoint: fromPoint)
        
        let toPoint = CGPoint(x: center.x + 9, y: center.y)
        let toValue = NSValue(cgPoint: toPoint)
        
        shake.fromValue = fromValue
        shake.toValue = toValue
        
        layer.add(shake, forKey: "position")
    }
    
    // MARK: - Private methods
    
    /// Контейнер, в котором собираются все методы, настраивающие кнопку.
    private func setupButton() {
        setShadow()
    }
    
    /// Метод создает тень вокруг кнопки
    private func setShadow() {
        layer.shadowColor = UIColor.black.cgColor
        layer.shadowOffset = CGSize(width: 0, height: 6)
        layer.shadowRadius = 8
        layer.shadowOpacity = 0.5
        clipsToBounds = true
        layer.masksToBounds = false
    }
}
