//
//  User.swift
//  UiLuxury_TeamProject
//
//  Created by Юрий Куринной on 19.08.2023.
//

import UIKit

// MARK: - ClickViewController

final class ClickViewController: UIViewController {
    
    // MARK: - Private properties
    
    private let walletLabel = UILabel()
    private let clickStackView = UIStackView()
    private let clickButton = ShadowedButton()
    private let coinImage = UIImage(named: Constants.coinImage)
    
    // TODO: вынести во вьюмодель
    private var user = User.shared
    private var score = 0
    private var clickModify = 1
    
    // MARK: - Public properties
    // TODO: вынести во вьюмодель или удалить
    let itemsSegueTest: [Item] = []
    var delegate: ISendInfoAboutCharacterDelegate?
    
    // MARK: - Lifecycle methods
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    // TODO: Проверить необходимость в методе после создания вьюмодели
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        modifySetup()
    }
    
    // MARK: - Private methods
    
    // TODO: весь блок по возможности перенести во вьюмодель
    @objc private func clickButtonTapped() {
        clickButton.setShakeAnimation()
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
        setupViews()
        addActions()
        addSubviews()
        setConstraints()
    }
}

// MARK: - Setup UI

private extension ClickViewController {
    
    // MARK: Add subviews
    func addSubviews() {
        view.addSubviews(
            walletLabel,
            clickButton
        )
    }
    
    // MARK: Setup views
    func setupViews() {
        view.addQuadroGradientLayer()
        navigationItem.title = Constants.navigationTitle
        
        view.disableAutoresizingMask(
            walletLabel,
            clickButton
        )
        
        setupWalletLabel()
        setupClickButton()
    }
    
    // MARK: WalletLabel
    func setupWalletLabel() {
        walletLabel.text = String(user.wallet)
        walletLabel.textColor = .black
        walletLabel.font = .preferredFont(forTextStyle: .largeTitle)
        walletLabel.textAlignment = .natural
    }
    
    // MARK: ClickButton
    func setupClickButton() {
        clickButton.setImage(coinImage, for: .normal)
        clickButton.imageView?.contentMode = .scaleAspectFit
    }

    
    // MARK: Actions
    func addActions() {
        clickButton.addTarget(
            self,
            action: #selector(clickButtonTapped),
            for: .touchUpInside
        )
    }
}

// MARK: - Constraints

private extension ClickViewController {
    func setConstraints() {
        NSLayoutConstraint.activate([
            
            // MARK: Wallet label
            walletLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            walletLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: 200),
            
            // TODO: Удалить, если кастомная кнопка будет заверстана фреймом
            clickButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            clickButton.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.5),
            clickButton.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.2),
            clickButton.bottomAnchor.constraint(
                greaterThanOrEqualTo: view.safeAreaLayoutGuide.bottomAnchor,
                constant: -80
            )
            
        ])
    }
}

// MARK: - Constants

private extension ClickViewController {
    
    enum Constants {
        static let coinImage = "plainCoin"
        static let navigationTitle = "Счет: "
    }
}


