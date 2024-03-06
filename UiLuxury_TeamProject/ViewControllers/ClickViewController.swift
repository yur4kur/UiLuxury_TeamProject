//
//  ClickViewController.swift
//  UiLuxury_TeamProject
//
//  Created by Бийбол Зулпукаров on 28/7/23.
//

import UIKit

class ClickViewController: UIViewController {
    
    // MARK: - IBOutlets
    private let walletLabel = UILabel()
    private let clickStackView = UIStackView()
    private let clickButton = UIButton()
    
    // MARK: - Public properties
    //let items: [Item] = DataSource.shared.gameItems
    let itemsSegueTest: [Item] = []
//    var userWallet = 0
    var delegate: ISendInfoAboutCharacterDelegate?
    
    // MARK: - Private properties
    private var user = User.shared
    private var score = 0
    private var clickModify = 1
    
    // MARK: - Public methods
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        modifySetup()
        
    }
    
    
    
    // MARK: - Private methods
    
    @objc private func tapOnFarmButton() {
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
        
        setConstraints()
    }
}

// MARK: - Setup UI

private extension ClickViewController {
    
    func addSubviews() {
        
        view.addSubview(clickStackView)
        
        clickStackView.addArrangedSubview(walletLabel)
        clickStackView.addArrangedSubview(clickButton)
    }
    
    func setupViews() {
        
        view.backgroundColor = .cyan
        
        // MARK: ClickStackView
        clickStackView.contentMode = .scaleToFill
        clickStackView.axis = .vertical
        clickStackView.alignment = .center
        clickStackView.spacing = 224
        clickStackView.translatesAutoresizingMaskIntoConstraints = false
        
        // MARK: WalletLabel
        walletLabel.contentMode = .left
        walletLabel.text = String(user.wallet)
        walletLabel.textAlignment = .natural
        walletLabel.lineBreakMode = .byTruncatingTail
        walletLabel.baselineAdjustment = .alignBaselines
        walletLabel.adjustsFontSizeToFitWidth = false
        walletLabel.translatesAutoresizingMaskIntoConstraints = false
        walletLabel.font = .systemFont(ofSize: 25)
        
        // MARK: ClickButton
        clickButton.contentMode = .scaleToFill
        clickButton.contentHorizontalAlignment = .center
        clickButton.contentVerticalAlignment = .center
        clickButton.translatesAutoresizingMaskIntoConstraints = false
        clickButton.titleLabel?.font = .systemFont(ofSize: 35)
        clickButton.setTitle("ClickButton", for: .normal)
        clickButton.addTarget(
            self,
            action: #selector(tapOnFarmButton),
            for: .touchUpInside
        )
    }
}

// MARK: - Constraints

private extension ClickViewController {
    
    func setConstraints() {
        NSLayoutConstraint.activate([
            clickStackView.centerXAnchor.constraint(
                equalTo: view.centerXAnchor
            ),
            clickStackView.centerYAnchor.constraint(
                equalTo: view.centerYAnchor
            )
        ])
    }
}
//extension ClickViewController: ISendInfoAboutCharacterDelegate {
//    func updateCharacterWallet(with newValue: Int) {
//        user.wallet += newValue
//        walletLabel.text = user.wallet.description
//    }
//}

