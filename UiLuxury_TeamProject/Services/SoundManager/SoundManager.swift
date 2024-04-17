//
//  SoundManager.swift
//  UiLuxury_TeamProject
//
//  Created by Эльдар Абдуллин on 19.03.2024.
//

import AVFoundation

// MARK: - Sound Manager

/// Класс реализации добавления звуков
final class SoundManager {

    // MARK: - Public Properties

    /// Свойство для запуска аудио-файла
    var audioPlayer: AVAudioPlayer?

    /// Точка доступа в Sound Manager
    static let shared = SoundManager()

    // MARK: - Private Initializers
    private init() {}

    // MARK: - Public Methods

    /// Метод, в который нужно передать имя mp3 файла
    func setupAudioPlayer(fromSound sound: String) {
        guard let soundURL = Bundle.main.url(forResource: sound, withExtension: Constants.fileExtension) else { return }

        do {
            audioPlayer = try AVAudioPlayer(contentsOf: soundURL)
            audioPlayer?.prepareToPlay()
        } catch {
            print("\(Constants.error) \(error.localizedDescription)")
        }
    }
}

// MARK: - Constants

enum Constants {
    static let fileExtension = "mp3"
    static let error = "Error loading sound file:"
}

