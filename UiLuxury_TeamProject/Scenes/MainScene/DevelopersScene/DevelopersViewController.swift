//
//  DevelopersViewController.swift
//  UiLuxury_TeamProject
//
//  Created by Eldar Abdullin on 7/3/24
//

import UIKit

// MARK: - DevelopersViewController

/// ViewController отображения информации о разработчиках
final class DevelopersViewController: UIViewController {

    // MARK: Private properties

    /// Сегмент-контроллер для переключения между карточками о разработчиках
    private lazy var developerSegments = UISegmentedControl()

    /// Изображение разработчика
    private let developerImageView = UIImageView()

    /// Кнопка перехода в Telegram
    private let telegramButton = UIButton()
    
    private let roleLabel = UILabel()

    /// Текущий индекс сегмента
    private var segmentIndex = 0

    /// Текущая Telegram-ссылка разработчика
    private var currentURL: String!  //DevelopersInfo.contacts[0]
    
    /// Массив с именами разработчиков
    private var names: [String]!
    
    /// Массив ссылок на телеграмм разработчиков
    private var contacts: [String]!
    
    /// Массив ролей разработчиков
    private var roles: [String]!
    
    /// Координатор контроллера
    private let coordinator: TabCoordinatorProtocol!
    
    /// Вью-модель контроллера
    private var viewModel: DevelopersViewModelProtocol!

    // MARK: - Initializers
    
    init(coordinator: TabCoordinatorProtocol) {
        self.coordinator = coordinator
        super.init(nibName: nil, bundle: nil)
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError(GlobalConstants.fatalError)
    }
    
    // MARK: Lifecycle Methods

    override func viewDidLoad() {
        super.viewDidLoad()
        setupBinding()
        setupUI()
        addActions()
    }

    // MARK: Private Methods

    /// Метод настройки карточки разработчика
    @objc private func showDeveloperInfo() {
        let selectedSegmentIndex = developerSegments.selectedSegmentIndex
        guard selectedSegmentIndex < names.count else { return }
        segmentIndex = selectedSegmentIndex

        guard let developerImage = UIImage(named: String(segmentIndex)) else { return }
        developerImageView.image = developerImage
        
        let developerContact = contacts[segmentIndex]
        currentURL = developerContact
        
        let developerRole = roles[segmentIndex]
        roleLabel.text = developerRole
    }

    /// Метод перехода в Telegram
    @objc private func openURL() {
        guard let url = URL(string: currentURL) else { return }
        UIApplication.shared.open(url)
    }
}

// MARK: - SetupBinding

private extension DevelopersViewController {
    
    func setupBinding() {
        viewModel = DevelopersViewModel()
        names = viewModel.getNames()
        contacts = viewModel.getContacts()
        currentURL = contacts[0]
        roles = viewModel.getRoles()
    }
}

// MARK: - Configure UI

private extension DevelopersViewController {

    /// Метод настройки пользовательского интерфейса
    func setupUI() {
        setupView()
        setupDeveloperSegments()
        setupDeveloperImageView()
        setupTelegramButton()
        setupRoleLabel()

        addSubviews()
        setConstraints()
        addActions()
    }
}

// MARK: - Setup UI

private extension DevelopersViewController {

    /// Метод настройки главного экрана
    func setupView() {
        view.addQuadroGradientLayer()
    }

    // MARK: Segmented control
    
    /// Метод настройки сегмент-контроллера
    func setupDeveloperSegments() {
        developerSegments = UISegmentedControl(items: names)
        developerSegments.selectedSegmentIndex = segmentIndex
        showDeveloperInfo()
    }

    // MARK: Developer image
    
    /// Метод настройки изображения пользователя
    func setupDeveloperImageView() {
        developerImageView.contentMode = .scaleAspectFill
        developerImageView.layer.cornerRadius = 8
        developerImageView.clipsToBounds = true
    }

    // MARK: Telegram button
    
    /// Метод настройки изображения кнопки перехода в Telegram
    func setupTelegramButton() {
        guard let image = UIImage(named: Images.telegramLogo) else { return }
        telegramButton.setImage(image, for: .normal)
    }
    
    // MARK: Role label
    
    /// Метод настройка лейбла с ролью разработчика
    func setupRoleLabel() {
        roleLabel.font = .boldSystemFont(ofSize: 17)
        roleLabel.textColor = .black
        roleLabel.textAlignment = .center
    }

    // MARK: Add subviews
    
    /// Метод добавления элементов интерфейса на главный экран и отключения масок AutoLayout
    func addSubviews() {
        view.addSubviews(
            developerSegments,
            developerImageView,
            telegramButton,
            roleLabel
        )

        view.disableAutoresizingMask(
            developerSegments,
            developerImageView,
            telegramButton,
            roleLabel
        )
    }

    // MARK: Actions
    
    /// Метод добавления действий  элементам интерфейса
    func addActions() {
        developerSegments.addTarget(
            self,
            action: #selector(showDeveloperInfo),
            for: .valueChanged
        )

        telegramButton.addTarget(
            self,
            action: #selector(openURL),
            for: .touchUpInside
        )
    }
}

// MARK: - Constraints

private extension DevelopersViewController {

    /// Метод установки констреинтов элементов интерфейса
    func setConstraints() {
        NSLayoutConstraint.activate([
            
            // MARK: Segmented control
            developerSegments.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20),
            developerSegments.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            developerSegments.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            developerSegments.heightAnchor.constraint(equalToConstant: 32),

            // MARK: Developer image
            developerImageView.topAnchor.constraint(equalTo: developerSegments.bottomAnchor, constant: 20),
            developerImageView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            developerImageView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            developerImageView.widthAnchor.constraint(equalTo: developerImageView.heightAnchor, multiplier: 1),

            // MARK: Telegram button
            telegramButton.trailingAnchor.constraint(equalTo: developerImageView.trailingAnchor, constant: -16),
            telegramButton.bottomAnchor.constraint(equalTo: developerImageView.bottomAnchor, constant: -16),
            telegramButton.heightAnchor.constraint(equalToConstant: 30),
            telegramButton.widthAnchor.constraint(equalToConstant: 30),
            
            // MARK: Role label
            roleLabel.topAnchor.constraint(equalTo: developerImageView.bottomAnchor, constant: 20),
            roleLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        ])
    }
}

// MARK: - Constants

private extension DevelopersViewController {

    /// Изображения
    enum Images {
        static let telegramLogo = "logo_telegram"
    }
}
