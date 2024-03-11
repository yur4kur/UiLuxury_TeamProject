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
    
    private let greetingLabel = UILabel()
    private let startButton = ShadowedButton()
    
    // TODO: Удалить, если не потребуются в ВМ
//    var nameTextField: UITextField!
//    var user = User.shared
    
    // MARK: - Lifecycle methods
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    // MARK: - Private methods
    
    @objc private func startTapped() {
        let vc = GameTabBarController()
        vc.modalPresentationStyle = .fullScreen
        present(vc, animated: true)
    }
    
}

// MARK: -  Configure UI

private extension StartViewController {
    func setupUI() {
        addSubviews()
        setupViews()
        addActions()
        setConstraints()
    }
}

// MARK: - Setup UI

private extension StartViewController {
    
    // MARK: Add subviews
    func addSubviews() {
        view.addSubviews(
        greetingLabel,
        startButton
        )
    }
    
    // MARK: Setup views
    func setupViews() {
        view.addQuadroGradientLayer()
        
        view.disableAutoresizingMask(
        greetingLabel,
        startButton
        )
        
        setupGreetingLabel()
        setupStartButton()
    }
    
    // MARK: Greeting label
    func setupGreetingLabel() {
        greetingLabel.text = Constants.greetingText
        greetingLabel.font = UIFont.systemFont(ofSize: 30)
        greetingLabel.textColor = .white
        greetingLabel.textAlignment = .center
        greetingLabel.numberOfLines = 5
    }
    
    // MARK: Start button
    func setupStartButton() {
        startButton.backgroundColor = UIColor(red: 0, green: 0.7, blue: 1, alpha: 1)
        
        startButton.setTitle(Constants.startButtonTitle, for: .normal)
        startButton.setTitleColor(.white, for: .normal)
        
        startButton.layer.cornerRadius = 10
        startButton.layer.borderWidth = 3
        startButton.layer.borderColor = UIColor.darkGray.cgColor
        //startButton.configuration?.cornerStyle = .capsule
    }
    
    // MARK: Actions
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
    
    func setConstraints() {
        NSLayoutConstraint.activate([
            
            // MARK: Greeting label
            greetingLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            greetingLabel.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            greetingLabel.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.8),
            greetingLabel.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.5),
            
            // MARK: Start button
            startButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            startButton.widthAnchor.constraint(equalToConstant: 120),
            startButton.heightAnchor.constraint(equalToConstant: 40),
            startButton.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -80)
        ])
    }
}

// MARK: - Constants

private extension StartViewController {
    
    enum Constants {
        static let greetingText = "Вперед за золотом! Дави на кнопку, зарабатывай монеты!"
        static let startButtonTitle = "Вперед!"
    }
}
