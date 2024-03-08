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
    private let coinImage = UIImage(named: Constants.coinImage)
    
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
        view.addSubviews(
            walletLabel,
            clickButton
        )
        
    }
    
    func setupViews() {
        view.addQuadroGradientLayer()
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
        if #available(iOS 17.0, *) {
            walletLabel.font = .preferredFont(forTextStyle: .extraLargeTitle)
            walletLabel.font = .preferredFont(forTextStyle: .largeTitle)
        } else {
            // Fallback on earlier versions
        }
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
            action: #selector(buttonDidTap),
            for: .touchUpInside
        )
    }
}

// MARK: - Constraints

private extension ClickViewController {
    
    func setConstraints() {
        NSLayoutConstraint.activate([
            walletLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            walletLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: 100),
            
            clickButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            clickButton.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -200)
        ])
    }
}

// MARK: - Constants

private extension ClickViewController {
    
    enum Constants {
        static let coinImage = "plainCoin"
        static let clickButtonTitle = "X1"
    }
}


