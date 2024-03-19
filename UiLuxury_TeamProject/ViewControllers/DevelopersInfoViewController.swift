//
//  DevelopersInfoViewController.swift
//  UiLuxury_TeamProject
//
//  Created by Eldar Abdullin on 7/3/24
//

import UIKit

// MARK: - DevelopersInfo ViewController

/// ViewController отображения информации о разработчиках
final class DevelopersInfoViewController: UIViewController {
    
    // MARK: - Private properties
    
    /// Сегмент-контроллер для переключения между карточками о разработчиках
    private var developerSegments = UISegmentedControl()
    
    /// Изображение разработчика
    private let developerImageView = UIImageView()
    
    /// Кнопка перехода в Telegram
    private let telegramButton = UIButton()
    
    /// Текущий индекс сегмента
    private var segmentIndex = 0
    
    /// Текущая Telegram-ссылка разработчика
    private var currentURL = "https://t.me/AkiraReiTyan"
    
    // MARK: - Lifecycle methods
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        setupBinding()
    }
    
    // MARK: - Private Methods
    
    /// Метод настройки карточки разработчика
    @objc private func showDeveloperInfo() {
        let selectedSegmentIndex = developerSegments.selectedSegmentIndex
        guard selectedSegmentIndex < DevelopersInfo.names.count else { return }
        segmentIndex = selectedSegmentIndex
        
        guard let developerImage = UIImage(named: String(segmentIndex)) else { return }
        let developerContact = DevelopersInfo.contacts[segmentIndex]
        
        developerImageView.image = developerImage
        currentURL = developerContact
    }
    
    /// Метод перехода в Telegram
    @objc private func openURL() {
        guard let url = URL(string: currentURL) else { return }
        UIApplication.shared.open(url)
    }
}

// MARK: - Configure UI

private extension DevelopersInfoViewController {
    
    /// Метод настройки пользовательского интерфейса
    func setupUI() {
        setupView()
        setupDeveloperSegments()
        setupDeveloperImageView()
        setupTelegramButton()
        
        addSubviews()
        setConstraints()
    }
    
    /// Метод добавления действий  элементам интерфейса
    func setupBinding() {
        developerSegments.addTarget(self, action: #selector(showDeveloperInfo), for: .valueChanged)
        telegramButton.addTarget(self, action: #selector(openURL), for: .touchUpInside)
    }
}

// MARK: - Setup UI

private extension DevelopersInfoViewController {
    
    /// Метод настройки главного экрана
    func setupView() {
        view.addQuadroGradientLayer()
    }
    
    /// Метод настройки сегмент-контроллера
    func setupDeveloperSegments() {
        developerSegments = UISegmentedControl(items: DevelopersInfo.names)
        developerSegments.selectedSegmentIndex = segmentIndex
        showDeveloperInfo()
    }
    
    /// Метод настройки изображения пользователя
    func setupDeveloperImageView() {
        developerImageView.contentMode = .scaleAspectFill
        developerImageView.layer.cornerRadius = 8
        developerImageView.clipsToBounds = true
    }
    
    /// Метод настройки изображения кнопки перехода в Telegram
    func setupTelegramButton() {
        guard let image = UIImage(named: "logo_telegram") else { return }
        telegramButton.setImage(image, for: .normal)
    }
    
    /// Метод добавления элементов интерфейса на главный экран и отключения масок AutoLayout
    func addSubviews() {
        view.addSubviews(
            developerSegments,
            developerImageView,
            telegramButton
        )
        
        view.disableAutoresizingMask(
            developerSegments,
            developerImageView,
            telegramButton
        )
    }
}

// MARK: - Constraints

private extension DevelopersInfoViewController {
    
    /// Метод установки констреинтов элементов интерфейса
    func setConstraints() {
        NSLayoutConstraint.activate([
            developerSegments.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20),
            developerSegments.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            developerSegments.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            developerSegments.heightAnchor.constraint(equalToConstant: 32),
            
            developerImageView.topAnchor.constraint(equalTo: developerSegments.bottomAnchor, constant: 20),
            developerImageView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            developerImageView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            developerImageView.widthAnchor.constraint(equalTo: developerImageView.heightAnchor, multiplier: 1),
            
            telegramButton.trailingAnchor.constraint(equalTo: developerImageView.trailingAnchor, constant: -16),
            telegramButton.bottomAnchor.constraint(equalTo: developerImageView.bottomAnchor, constant: -16),
            telegramButton.heightAnchor.constraint(equalToConstant: 30),
            telegramButton.widthAnchor.constraint(equalToConstant: 30)
        ])
    }
}

// MARK: - Constants

private extension DevelopersInfoViewController {
    
    /// Информация о разработчиках
    enum DevelopersInfo {
        static let names = [
            "Миша",
            "Кирилл",
            "Юра",
            "Бийбол",
            "Эльдар",
            "Рустам"
        ]
        
        static let contacts = [
            "https://t.me/AkiraReiTyan",
            "https://t.me/kizi_mcfly",
            "https://t.me/Radiator074",
            "https://t.me/zubi312",
            "https://t.me/eldarovsky",
            "https://t.me/hellofox"
        ]
    }
}
