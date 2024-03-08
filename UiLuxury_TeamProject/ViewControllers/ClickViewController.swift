//
//  User.swift
//  UiLuxury_TeamProject
//
//  Created by Юрий Куринной on 19.08.2023.
//

import UIKit

// MARK: - ClickViewController

class ClickViewController: UIViewController {
    
    // MARK: - Private properties
    
    private let walletLabel = UILabel()
    private let clickStackView = UIStackView()
    private let clickButton = UIButton()
    
    // TODO: вынести во вьюмодель
    private var user = User.shared
    private var score = 0
    private var clickModify = 1
    
    // MARK: - Public properties
    
    let itemsSegueTest: [Item] = []
    var delegate: ISendInfoAboutCharacterDelegate?
    
    // MARK: - Lifecycle methods
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
    }
    
//    override func viewWillLayoutSubviews() {
//        roundClickButton()
//    }
    
    // TODO: Проверить необходимость в методе после создания вьюмодели
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        modifySetup()
    }
    
    // MARK: - Private methods
    
    // TODO: весь блок по возможности перенести во вьюмодель
    @objc private func buttonDidTap() {
        score += clickModify
        updateCharacterWallet(with: score)
    }
    
    private func modifySetup() {
        user.items.forEach { item in
            switch item.actionOperator{
            case .add:
                clickModify += item.modifier
            case .multiply:
                clickModify *= item.modifier
            case .assets:
                return
            }
        }
    }
    
    private func updateCharacterWallet(with newValue: Int) {
        user.wallet += newValue
        walletLabel.text = user.wallet.description
    }
}

// MARK: - Configure UI

private extension ClickViewController {
    
    func setupUI() {
        addSubviews()
        setupViews()
        addActions()
        setConstraints()
    }
}

// MARK: - Setup UI

private extension ClickViewController {
    
    // MARK: Add & setup views
    func addSubviews() {
        view.addSubview(clickStackView)
        
    }
    
    func setupViews() {
        view.addQuadroGradientLayer()
        view.disableAutoresizingMask(
            clickStackView,
            walletLabel,
            clickButton
        )
        
        setupStackView()
        setupWalletLabel()
        setupClickButton()
    }
    
    // MARK: ClickStackView
    func setupStackView() {
        clickStackView.axis = .vertical
        clickStackView.alignment = .center
        clickStackView.distribution = .fill
        clickStackView.spacing = 250
        
        clickStackView.addArrangedSubview(walletLabel)
        clickStackView.addArrangedSubview(clickButton)
    }
    
    // MARK: WalletLabel
    func setupWalletLabel() {
        walletLabel.text = String(user.wallet)
        walletLabel.textColor = .systemYellow
        walletLabel.font = .preferredFont(forTextStyle: .largeTitle)
        walletLabel.textAlignment = .natural
    }
    
    // MARK: ClickButton
    func setupClickButton() {
        clickButton.configuration = setupButtonConfiguration()
        clickButton.setTitle(Constants.clickButtonTitle, for: .normal)
        clickButton.setTitleColor(.black, for: .normal)
        clickButton.layer.cornerRadius = 25
        clickButton.layer.borderColor = UIColor.black.cgColor
        clickButton.layer.borderWidth = 2
        
    }
    
    func setupButtonConfiguration() -> UIButton.Configuration {
        var configuration = UIButton.Configuration.borderedTinted()
        configuration.baseForegroundColor = .yellow
        configuration.cornerStyle = .capsule
        configuration.buttonSize = .large
        
        return configuration
    }
    
    func roundClickButton() {
        clickButton.layer.bounds.size.width = 200
        clickButton.layer.cornerRadius = clickButton.bounds.size.width / 2
    }
    
    // MARK: Actions
    func addActions() {
        clickButton.addTarget(
            self,
            action: #selector(buttonDidTap),
            for: .touchUpInside
        )
    }
}

// MARK: - Constraints

private extension ClickViewController {
    
    func setConstraints() {
        NSLayoutConstraint.activate([
            clickStackView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            clickStackView.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        ])
    }
}

// MARK: - Constants

private extension ClickViewController {
    
    enum Constants {
        static let clickButtonTitle = "X1"
    }
}


