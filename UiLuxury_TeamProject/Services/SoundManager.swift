//
//  SoundManager.swift
//  UiLuxury_TeamProject
//
//  Created by Эльдар Абдуллин on 19.03.2024.
//

import AVFoundation

/// Класс реализации применения звуков
final class SoundManager {
    var audioPlayer: AVAudioPlayer?

    static let shared = SoundManager()
    private init() {}

    /// Метод, в который нужно передать имя mp3 файла
    func setupAudioPlayer(fromSound sound: String) {
        guard let soundURL = Bundle.main.url(forResource: sound, withExtension: "mp3") else { return }

        do {
            audioPlayer = try AVAudioPlayer(contentsOf: soundURL)
            audioPlayer?.prepareToPlay()
        } catch {
            print("Error loading sound file: \(error.localizedDescription)")
        }
    }
}
