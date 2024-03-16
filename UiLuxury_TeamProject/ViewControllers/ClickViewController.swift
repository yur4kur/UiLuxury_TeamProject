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
    
    // MARK: Views
    private let walletLabel = UILabel()
    private let clickButton = UIButton()
    private let coinImage = UIImage(named: Constants.coinImage)
    
    // MARK: Animation
    private let randomizer = Float.random(in: 0.0...1.0)
    private var animator: UIDynamicAnimator!
    private var gravity: UIGravityBehavior!
    private var itemBehavior: UIDynamicItemBehavior!
    private var collider: UICollisionBehavior!
    private var coinImageView: UIImageView!
  
    // TODO: вынести во вьюмодель
    private var user = User.shared
    private var score = 0
    private var clickModify = 1
    
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
        animate()
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
        setupAnimation()
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
        // TODO: Проанализировать возможность заверстать кнопку фреймом
//        clickButton = UIButton(frame: CGRect(x: 90, y: 540, width: 250, height: 175))
        clickButton.setImage(coinImage, for: .normal)
        clickButton.imageView?.contentMode = .scaleAspectFit
        clickButton.setShadow()
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

 // MARK: - Setup Animation

private extension ClickViewController {
    
    // MARK: Add animation
    func animate() {
        let item = setupCoinImageView()
        gravity?.addItem(item)
        collider?.addItem(item)
        itemBehavior?.addItem(item)
    }
    
    // MARK: Coin Image
    func setupCoinImageView() -> UIImageView {
        coinImageView = UIImageView(image: coinImage)
        coinImageView.frame = CGRect(x: Int.random(in: 10...300), y: 0, width: 75, height: 60)
        
        // Subview добавляется каждый раз при нажатии кнопки, поэтому addSubview применяем здесь
        view.addSubview(coinImageView)
        return coinImageView
    }
    
    // MARK: Setup animation
    func setupAnimation() {
        animator = UIDynamicAnimator(referenceView: view)
        gravity = UIGravityBehavior()
        collider = UICollisionBehavior()
        itemBehavior = UIDynamicItemBehavior()
        setupCollider()
        setupItemBehavior()
        setupAnimator()
    }
    
    // MARK: Collider
    func setupCollider() {
        //делаем границы вью физическими границами для айтемов
        collider?.translatesReferenceBoundsIntoBoundary = true
        collider?.collisionMode = .items
    }
    
    // MARK: Item behavior
    func setupItemBehavior() {
        itemBehavior?.elasticity = 4
        itemBehavior?.density = CGFloat(randomizer)
        itemBehavior?.allowsRotation = true
    }
    
    // MARK: Animator
    func setupAnimator() {
        animator = UIDynamicAnimator(referenceView: self.view)
        animator?.addBehavior(gravity)
        animator?.addBehavior(collider)
        animator?.addBehavior(itemBehavior)
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


