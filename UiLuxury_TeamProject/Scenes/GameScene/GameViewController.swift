//
//  GameViewController.swift
//  UiLuxury_TeamProject
//
//  Created by Юрий Куринной on 19.08.2023.
//

import UIKit

// MARK: - ClickViewController

final class GameViewController: UIViewController {
    
    // MARK: - Private properties
    
    // MARK: Views
    
    /// Лейбл с игровым счетом
    private let scoreLabel = UILabel()
    
    /// Основная игровая кнопка
    private let clickButton = UIButton()
    
    /// Картинка с монетой
    private let coinImage = UIImage(named: Constants.coinImage)
    
    // MARK: Animation
    
    /// Рандомайзер, чтобы монетки разлетались по разному
    private let randomizer = Float.random(in: 0.0...1.0)
    
    /// Динамическая анимация
    private var animator: UIDynamicAnimator!
    
    /// Имитация силы тяжести
    private var gravity: UIGravityBehavior!
    
    /// Поведение анимируемых объектов
    private var itemBehavior: UIDynamicItemBehavior!
    
    /// Поведение при столкновении
    private var collider: UICollisionBehavior!
    
    /// Картинка анимируемых объектов
    private var coinImageView: UIImageView!
  
    /// Экземпляр вью модели
    private let viewModel = GameViewModel()
    
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
    
    /// Метод запускает анимацию нажатия кнопки, анимирует падающие монеты и увеличивает счет игры
    @objc private func clickButtonTapped() {
        animate()
        viewModel.score += viewModel.clickModify
        updateCharacterWallet(with: viewModel.score)
    }
    // TODO: весь блок по возможности перенести во вьюмодель
    private func modifySetup() {
        viewModel.user.items.forEach { item in
            switch item.actionOperator{
            case .add:
                viewModel.clickModify += item.modifier
            case .multiply:
                viewModel.clickModify *= item.modifier
            case .assets:
                return
            }
        }
    }
    
    private func updateCharacterWallet(with newValue: Int) {
        viewModel.user.wallet += newValue
        scoreLabel.text = viewModel.user.wallet.description
    }
}

// MARK: - Configure UI

private extension GameViewController {
    
    /// Метод собирает в себе настройки вьюх и анимации и устанавливает констрейнты вьюх
    func setupUI() {
        setupViews()
        addSubviews()
        addActions()
        setupAnimation()
        setConstraints()
    }
    
    /// Метод собирает в себе анимации, запускающиеся при нажатии кнопки
    func animate() {
        clickButton.shakeButton()
        dropCoin()
    }
}

// MARK: - Setup UI

private extension GameViewController {
    
    // MARK: Setup views
    
    /// Метод настраивает основное вью и запускает методы настройки сабвьюх
    func setupViews() {
        view.addQuadroGradientLayer()
        navigationItem.title = Constants.navigationScoreTitle
        
        view.disableAutoresizingMask(
            scoreLabel,
            clickButton
        )
        
        setupScoreLabel()
        setupClickButton()
    }
    
    // MARK: Add subviews
    
    /// Метод добавляет вьюхи на основное вью в качестве сабвьюх
    func addSubviews() {
        view.addSubviews(
            scoreLabel,
            clickButton
        )
    }
    
    // MARK: WalletLabel
    
    /// Метод настраивает лейбл
    func setupScoreLabel() {
        scoreLabel.text = String(viewModel.user.wallet)
        scoreLabel.textColor = .black
        scoreLabel.font = .preferredFont(forTextStyle: .largeTitle)
        scoreLabel.textAlignment = .natural
    }
    
    // MARK: ClickButton
    
    /// Метод настраивает игровую кнопку
    func setupClickButton() {
        // TODO: Проанализировать возможность заверстать кнопку фреймом
//        clickButton = UIButton(frame: CGRect(x: 90, y: 540, width: 250, height: 175))
        clickButton.setImage(coinImage, for: .normal)
        clickButton.imageView?.contentMode = .scaleAspectFit
        clickButton.setShadow()
    }

    
    // MARK: Actions
    
    /// Метод добавляет действия для активных элементов пользовательского интерфейса
    func addActions() {
        clickButton.addTarget(
            self,
            action: #selector(clickButtonTapped),
            for: .touchUpInside
        )
    }
}

 // MARK: - Setup Animation

private extension GameViewController {
    
    // MARK: Add animation
    
    /// Метод запускает анимацию с падающей монеткой
    func dropCoin() {
        let item = setupCoinImageView()
        gravity?.addItem(item)
        collider?.addItem(item)
        itemBehavior?.addItem(item)
    }
    
    // MARK: Coin Image
    
    /// Метод задает картинку монетки падающему объекту
    func setupCoinImageView() -> UIImageView {
        coinImageView = UIImageView(image: coinImage)
        coinImageView.frame = CGRect(x: Int.random(in: 10...300), y: 0, width: 75, height: 75)
        
        // Subview добавляется каждый раз при нажатии кнопки, поэтому addSubview применяем здесь
        view.addSubview(coinImageView)
        return coinImageView
    }
    
    // MARK: Setup animation
    
    /// Метод настраивает внутреннюю логику анимации
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
    
    /// Метод настраивает элементы экрана, участвющие в столкновении
    func setupCollider() {
        //делаем границы вью физическими границами для айтемов
        collider?.translatesReferenceBoundsIntoBoundary = true
        collider?.collisionMode = .items
    }
    
    // MARK: Item behavior
    
    /// Метод настраивает парамеметры анимируемых объектов, от которых зависит их поведение на экране
    func setupItemBehavior() {
        itemBehavior?.elasticity = 4
        itemBehavior?.density = CGFloat(randomizer)
        itemBehavior?.allowsRotation = true
    }
    
    // MARK: Animator
    
    /// Метод добавляет виды анимируемого поведения
    func setupAnimator() {
        animator = UIDynamicAnimator(referenceView: self.view)
        animator?.addBehavior(gravity)
        animator?.addBehavior(collider)
        animator?.addBehavior(itemBehavior)
    }
}

// MARK: - Constraints

private extension GameViewController {
    
    /// Метод задает констрейнты для вьюх
    func setConstraints() {
        NSLayoutConstraint.activate([
            
            // MARK: Wallet label
            scoreLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            scoreLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: 200),
            
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

private extension GameViewController {
    
    enum Constants {
        static let coinImage = "plainCoin"
        static let navigationScoreTitle = "Счет: "
    }
}

