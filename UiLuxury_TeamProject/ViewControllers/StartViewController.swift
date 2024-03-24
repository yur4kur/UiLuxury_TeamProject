//
//  StartViewController.swift
//  UiLuxury_TeamProject
//
//   Created by Юрий Куринной on 09.03.2024.
//

import UIKit

// MARK: - StartViewController

final class StartViewController: UIViewController {
    
    // MARK: - Private properties
    
    /// Лейбл с приветственной надписью
    private let greetingLabel = UILabel()
    
    /// Кнопка, переводящая на игровой экран
    private let startButton = UIButton()
    
    // TODO: Удалить, если не потребуются в ВМ
//    var nameTextField: UITextField!
//    var user = User.shared
    
    // MARK: - Lifecycle methods
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    // MARK: - Private methods
    
    /// Метода переход на игровой экран
    @objc private func startTapped() {
        let vc = GameTabBarController()
        vc.modalPresentationStyle = .fullScreen
        present(vc, animated: true)
    }
    
}

// MARK: -  Configure UI

private extension StartViewController {
    
    /// Метод собирает в себе настройки вьюх и анимации и устанавливает констрейнты вьюх
    func setupUI() {
        setupViews()
        addSubviews()
        addActions()
        setConstraints()
    }
}

// MARK: - Setup UI

private extension StartViewController {
    
    // MARK: Setup views
    
    /// Метод настраивает основное вью и запускает методы настройки сабвьюх
    func setupViews() {
        view.addQuadroGradientLayer()
        
        view.disableAutoresizingMask(
        greetingLabel,
        startButton
        )
        
        setupGreetingLabel()
        setupStartButton()
    }
    
    // MARK: Add subviews
    
    /// Метод добавляет вьюхи на основное вью в качестве сабвьюх
    func addSubviews() {
        view.addSubviews(
        greetingLabel,
        startButton
        )
    }
    
    // MARK: Greeting label
    
    /// Метод настраивает лейбл с приветственной надписью
    func setupGreetingLabel() {
        greetingLabel.text = Constants.greetingText
        greetingLabel.font = UIFont(name: Constants.gameFont, size: 30)
        greetingLabel.textColor = .white
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
    
    // MARK: Actions
    
    /// Метод добавляет действия для активных элементов пользовательского интерфейса
    func addActions() {
        startButton.addTarget(
            self,
            action: #selector(startTapped),
            for: .touchUpInside
        )
    }
}

// MARK: - Constraints

private extension StartViewController {
    
    /// Метод задает констрейнты для вьюх
    func setConstraints() {
        NSLayoutConstraint.activate([
            
            // MARK: Greeting label
            greetingLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            greetingLabel.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            greetingLabel.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.8),
            greetingLabel.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.5),
            
            // MARK: Start button
            startButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            startButton.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.5),
            startButton.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.08),
            startButton.bottomAnchor.constraint(
                greaterThanOrEqualTo: view.safeAreaLayoutGuide.bottomAnchor,
                constant: -80
            )
                
        ])
    }
}

// MARK: - Constants

private extension StartViewController {
    
    /// Текстовые элементы, используемые в коде
    enum Constants {
        static let greetingText = "Вперед за золотом! Дави на кнопку, зарабатывай монеты!"
        static let startButtonTitle = "Вперед!"
        static let gameFont = "AvenirNext-DemiBold"
    }
}
