//
//  HapticFeedbackManager.swift
//  UiLuxury_TeamProject
//
//  Created by Эльдар Абдуллин on 07.04.2024.
//

import UIKit

// MARK: - HapticFeedbackManager

/// Класс реализации тактильной отдачи
final class HapticFeedbackManager {

    // MARK: - Public Properties

    /// Точка доступа в Haptic Feedback Manager
    static let shared = HapticFeedbackManager()

    // MARK: - Private Initializers

    private init() {}

    // MARK: - Public Methods
    
    /// Точка доступа в Haptic Feedback Manager
    func enableFeedback() {
        let generator = UIImpactFeedbackGenerator(style: .soft)
        generator.impactOccurred()
    }
}
