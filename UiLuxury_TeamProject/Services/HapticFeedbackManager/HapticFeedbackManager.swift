//
//  HapticFeedbackManager.swift
//  UiLuxury_TeamProject
//
//  Created by Эльдар Абдуллин on 07.04.2024.
//

import UIKit

protocol FeedbackManagerProtocol {
    
    /// Метод генерации тактильной отдачи
    func enableFeedback()
}

// MARK: - HapticFeedbackManager

/// Класс реализации тактильной отдачи
final class HapticFeedbackManager: FeedbackManagerProtocol {

    // MARK:  Public Methods
    
    func enableFeedback() {
        let generator = UIImpactFeedbackGenerator(style: .soft)
        generator.impactOccurred()
    }
}
