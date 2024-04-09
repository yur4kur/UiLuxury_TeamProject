//
//  StartView.swift
//  UiLuxury_TeamProject
//
//  Created by Юрий Куринной on 02.04.2024.
//

import UIKit

// MARK: - StartView

final class StartView: UIView {
    
    // MARK: Private properties
    
    /// Лейбл с приветственной надписью
   private let greetingLabel = UILabel()
    
    // MARK: - Public properties
    
    /// Кнопка, переводящая на игровой экран
    let startButton = UIButton()

    /// UIImageView для фонового изображения
    private let backgroundImageView = UIImageView()

    // MARK: - Initializer
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError(GlobalConstants.fatalError)
    }
}

// MARK: -  Configure UI

private extension StartView {
    
    /// Метод собирает в себе настройки вьюх и анимации и устанавливает констрейнты вьюх
    func setupUI() {
        setupViews()
        addSubviews()
        setConstraints()
    }
}

// MARK: - Setup UI

private extension StartView {
    
    // MARK: Setup views
    
    /// Метод настраивает основное вью и запускает методы настройки сабвьюх
    func setupViews() {
        setupBackgroundImageView()

        disableAutoresizingMask(
        greetingLabel,
        startButton
        )
        
        setupGreetingLabel()
        setupStartButton()
    }
    
    // MARK: Add subviews
    
    /// Метод добавляет вьюхи на основное вью в качестве сабвьюх
    func addSubviews() {
        addSubviews(
        greetingLabel,
        startButton
        )
    }
    
    // MARK: Greeting label
    
    /// Метод настраивает лейбл с приветственной надписью
    func setupGreetingLabel() {
        greetingLabel.text = Constants.greetingText
        greetingLabel.font = UIFont(name: Constants.gameFont, size: 30)
        greetingLabel.textColor = .darkGray
        greetingLabel.textAlignment = .center
        greetingLabel.numberOfLines = 5
    }
    
    // MARK: Start button
    
    /// Метод настраивает стартовую кнопку
    func setupStartButton() {
        startButton.backgroundColor = UIColor(red: 0, green: 0.8, blue: 1, alpha: 1)
        startButton.setShadow()
        
        startButton.setTitle(Constants.startButtonTitle, for: .normal)
        startButton.setTitleColor(.white, for: .normal)
        startButton.titleLabel?.font = UIFont(name: Constants.gameFont, size: 25)
        
        startButton.layer.cornerRadius = 10
        startButton.layer.borderWidth = 1
        startButton.layer.borderColor = UIColor.darkGray.cgColor
    }

    /// Метод настраивает фон
    func setupBackgroundImageView() {
        backgroundImageView.image = UIImage(named: "backgroundImage")
        backgroundImageView.contentMode = .scaleAspectFill
        backgroundImageView.clipsToBounds = true
        backgroundImageView.translatesAutoresizingMaskIntoConstraints = false
        addSubview(backgroundImageView)
        sendSubviewToBack(backgroundImageView)
    }
}

// MARK: - Constraints

private extension StartView {
    
    /// Метод задает констрейнты для вьюх
    func setConstraints() {
        NSLayoutConstraint.activate([
            
            // MARK: Greeting label
            greetingLabel.centerXAnchor.constraint(equalTo: centerXAnchor),
            greetingLabel.centerYAnchor.constraint(equalTo: centerYAnchor),
            greetingLabel.widthAnchor.constraint(equalTo: widthAnchor, multiplier: 0.8),
            greetingLabel.heightAnchor.constraint(equalTo: heightAnchor, multiplier: 0.5),
            
            // MARK: Start button
            startButton.centerXAnchor.constraint(equalTo: centerXAnchor),
            startButton.widthAnchor.constraint(equalTo: widthAnchor, multiplier: 0.5),
            startButton.heightAnchor.constraint(equalTo: heightAnchor, multiplier: 0.08),
            startButton.bottomAnchor.constraint(
                greaterThanOrEqualTo: safeAreaLayoutGuide.bottomAnchor,
                constant: -80
            ),

            // MARK: Background ImageView
            backgroundImageView.topAnchor.constraint(equalTo: topAnchor),
            backgroundImageView.leadingAnchor.constraint(equalTo: leadingAnchor),
            backgroundImageView.trailingAnchor.constraint(equalTo: trailingAnchor),
            backgroundImageView.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
    }
}

// MARK: - Constants

private extension StartView {
    
    /// Текстовые элементы, используемые в коде
    enum Constants {
        static let greetingText = "Вперед за золотом! Дави на кнопку, зарабатывай монеты!"
        static let startButtonTitle = "Вперед!"
        static let gameFont = "AvenirNext-DemiBold"
    }
}
