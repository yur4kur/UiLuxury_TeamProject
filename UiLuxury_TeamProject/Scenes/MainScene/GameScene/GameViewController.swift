//
//  GameViewController.swift
//  UiLuxury_TeamProject
//
//  Created by Юрий Куринной on 19.08.2023.
//

import UIKit

// MARK: - ViewState

/// Состояние вью
enum ViewState: Comparable {
    case loaded
    case gaming
    case background
}

// MARK: - ClickViewController

final class GameViewController: UIViewController {
    
    // MARK: - Private properties
    
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
    
    /// Точка доступа к HapticFeedbackManager
    private let hapticFeedbackManager: FeedbackManagerProtocol
    
    /// Точка доступа к SoundManager
    private let soundManager: SoundManager
  
   // MARK: View model
    
    /// Экземпляр вью модели
    private var viewModel: (any GameViewModelProtocol)?
    
    /// Координатор контроллера
    private var coordinator: GameServicesProtocol!
    
    private var state: ViewState! {
        didSet {
            scoreLabel.text = viewModel?.transform(input: state)
        }
    }
    
    // MARK: - Initializers
    
    init(coordinator: GameServicesProtocol, viewModel:any GameViewModelProtocol) {
        self.coordinator = coordinator
        self.viewModel = viewModel
        hapticFeedbackManager = HapticFeedbackManager()
        soundManager = SoundManager.shared
        super.init(nibName: nil, bundle: nil)
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError(GlobalConstants.fatalError)
    }
    
    // MARK: - Lifecycle methods
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setupAudioPlayer()
        state = .loaded
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        state = .background
    }
    
    // MARK: - Private methods
    
    /// Метод запускает анимацию нажатия кнопки, анимирует падающие монеты и увеличивает счет игры
    @objc private func clickButtonTapped() {
        state = .gaming
        animate()
    }
    
    /// Тактильная отдача кнопки
    private func enableFeedback() {
        hapticFeedbackManager.enableFeedback()
    }
    
    /// Настройка аудиоплеера
    private func setupAudioPlayer() {
        DispatchQueue.global().async {
            self.soundManager.setupAudioPlayer(fromSound: Constants.buttonPressed)
        }
    }
    
    /// Озвучка падения монеты
    private func playSound() {
        DispatchQueue.global(qos: .default).async {
            self.soundManager.audioPlayer?.stop()
            self.soundManager.audioPlayer?.currentTime = 0
            self.soundManager.audioPlayer?.play()
        }
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
        enableFeedback()
        dropCoin()
        playSound()
    }
}

// MARK: - Setup UI

private extension GameViewController {
    
    // MARK: Setup views
    
    /// Метод настраивает основное вью и запускает методы настройки сабвьюх
    func setupViews() {
        view.addQuadroGradientLayer()
        navigationItem.title = Constants.navigationTitle
        
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
    
    // MARK: ScoreLabel
    
    /// Метод настраивает лейбл
    func setupScoreLabel() {
        //scoreLabel.text = Constants.nullScore
        scoreLabel.textColor = .black
        scoreLabel.font = .preferredFont(forTextStyle: .largeTitle)
        scoreLabel.textAlignment = .natural
    }
    
    // MARK: ClickButton
    
    /// Метод настраивает игровую кнопку
    func setupClickButton() {
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
            for: .touchDown
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
            scoreLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: 230),
            
            // MARK: Click button
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
    
    /// Текстовые элементы, используемые в коде
    enum Constants {
        static let coinImage = "plainCoin"
        static let navigationTitle = "Жми на кнопку!"
        static let nullScore = "0"
        static let buttonPressed = "coin"
    }
}


