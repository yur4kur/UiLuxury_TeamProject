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
//    private var developerSegments = UISegmentedControl()
    
    /// Заглушка
    private var pagesCount = ["one", "two", "Three"]
    
    /// Скролл Вью для перехода между раработчиками
    private var scrollView = UIScrollView()
    
    /// Пейдж Контрол
    private let pageControl = UIPageControl()

    /// Изображение разработчика
    private let developerImageView = UIImageView()
    
    /// Шапка
    private let headerView = UIView()
    
    /// Графический слой изображения
    private let containerView = UIView()

    /// Кнопка перехода в Telegram
    private let telegramButton = UIButton()
    
    /// Лейбл с именем разработчика
    private let nameLabel = UILabel()
    
    /// Текст о себе
    private let aboutMeLabel = UILabel()

    /// Текущий индекс сегмента
    private var segmentIndex = 0

    /// Текущая Telegram-ссылка разработчика
    private var currentURL = DevelopersInfo.contacts[0]

    // MARK: Lifecycle Methods

    /// Настройка вью и вызов всех методов для этого
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        addActions()
        nameLabel.isHidden = true
        
        pageControl.numberOfPages = pagesCount.count
        scrollView.backgroundColor = .red
    }
    
    /// Скрываем нивгейшн бар
    override func viewWillAppear(_ animated: Bool) {
        navigationController?.navigationBar.isHidden = true
    }
    
    /// Делаем из нашего изображения круг
    override func viewWillLayoutSubviews() {
        containerView.layer.cornerRadius = developerImageView.layer.frame.height / 2
        developerImageView.layer.cornerRadius = developerImageView.layer.frame.height / 2
    }

    // MARK: Private Methods
   

    /// Метод настройки карточки разработчика
//    @objc private func showDeveloperInfo() {
//        let selectedSegmentIndex = developerSegments.selectedSegmentIndex
//        guard selectedSegmentIndex < DevelopersInfo.names.count else { return }
//        segmentIndex = selectedSegmentIndex
//
//        guard let developerImage = UIImage(named: String(segmentIndex)) else { return }
//        let developerContact = DevelopersInfo.contacts[segmentIndex]
//
//        developerImageView.image = developerImage
//        currentURL = developerContact
//    }

    /// Метод перехода в Telegram
    @objc private func openURL() {
        guard let url = URL(string: currentURL) else { return }
        UIApplication.shared.open(url)
    }
}

// MARK: - Configure UI

private extension DevelopersViewController {

    /// Метод настройки пользовательского интерфейса
    func setupUI() {
        setupView()
        setupScrollView()
//        setupDeveloperSegments()
        setupDeveloperImageView()
        setupTelegramButton()
        setupContainerView()
        setupHeader()
        setupNameLabel()
        setupAboutMeLabel()

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
    
    /// Настройка скролл вью
    ///  В контент сайзе мы указываем высоту как 1 для того, чтобы отключить вертикальный скролл
    ///  И мы пользовались только свайпами вправо-влево
    func setupScrollView() {
        scrollView.contentSize = CGSize(
            width: Int(UIScreen.main.bounds.width) * pagesCount.count,
            height: Int(1) //Int(view.frame.height - 200)
        )
        scrollView.isPagingEnabled = true
        
        addLabel(title: pagesCount[0], position: 0)
        addLabel(title: pagesCount[1], position: 1)
        addLabel(title: pagesCount[2], position: 2)
        
        scrollView.delegate = self
    }
    
    func addLabel(title: String, position: CGFloat) {
        let testLabel = UILabel()
        testLabel.text = title
        testLabel.textAlignment = .center
        
        scrollView.addSubview(testLabel)
        
        let screenWidth = UIScreen.main.bounds.width
        testLabel.frame = CGRect(
            x: screenWidth * position,
            y: 100,
            width: screenWidth,
            height: 200)
    }
    
    /// Настройка шапки
    func setupHeader() {
        headerView.backgroundColor = .white
    }

    /// Метод настройки сегмент-контроллера
//    func setupDeveloperSegments() {
//        developerSegments = UISegmentedControl(items: DevelopersInfo.names)
//        developerSegments.selectedSegmentIndex = segmentIndex
//        showDeveloperInfo()
//    }

    /// Метод настройки изображения пользователя
    func setupDeveloperImageView() {
        developerImageView.contentMode = .scaleAspectFill
        developerImageView.clipsToBounds = true
        
        developerImageView.layer.borderWidth = 2
        developerImageView.layer.borderColor = UIColor.white.cgColor
    }
    
    /// Настройка графического слоя под картинкой
    func setupContainerView() {
        containerView.layer.shadowColor = UIColor.black.cgColor
        containerView.layer.shadowOpacity = 0.5
        containerView.layer.shadowRadius = 10
    }

    /// Метод настройки изображения кнопки перехода в Telegram
    func setupTelegramButton() {
        guard let image = UIImage(named: Images.telegramLogo) else { return }
        telegramButton.setImage(image, for: .normal)
    }
    
    /// Настройка имени разработчика
    func setupNameLabel() {
        nameLabel.text = "Акира Рей"
//        nameLabel.textColor = .darkGray
        nameLabel.textAlignment = .center
        nameLabel.font = UIFont.boldSystemFont(ofSize: 29)
    }
    
    /// Информация о разработчике
    func setupAboutMeLabel() {
    //TODO: - из модели подгружать данные о разработчиках
        aboutMeLabel.text = " aasdsadsadsadsadsadsadsadsadasdasdsadasdsadaaaaaaaaaasdaaasdsadsadsadsadsadsadsadsadasdasdsadasdsadaaaaaaaaaasdaaasdsadsadsadsadsadsadsadsadasdasdsadasdsadaaaaaaaaaasdaaasdsadsadsadsadsadsadsadsadasdasdsadasdsadaaaaaaaaaasdaaasdsadsadsadsadsadsadsadsadasdasdsadasdsadaaaaaaaaaasdaaasdsadsadsadsadsadsadsadsadasdasdsadasdsadaaaaaaaaaasdaaasdsadsadsadsadsadsadsadsadasdasdsadasdsadaaaaaaaaaasdaaasdsadsadsadsadsadsadsadsadasdasdsadasdsadaaaaaaaaaasdaaasdsadsadsadsadsadsadsadsadasdasdsadasdsadaaaaaaaaaasdaaasdsadsadsadsadsadsadsadsadasdasdsadasdsadaaaaaaaaaasdaaasdsadsadsadsadsadsadsadsadasdasdsadasdsadaaaaaaaaaasdaaasdsadsadsadsadsadsadsadsadasdasdsadasdsadaaaaaaaaaasdaaasdsadsadsadsadsadsadsadsadasdasdsadasdsadaaaaaaaaaasdaaasdsadsadsadsadsadsadsadsadasdasdsadasdsadaaaaaaaaaasda"
        aboutMeLabel.textAlignment = .center
        aboutMeLabel.numberOfLines = .max
        
    }

    /// Метод добавления элементов интерфейса на главный экран и отключения масок AutoLayout
    func addSubviews() {
        view.addSubviews(
            scrollView,
            pageControl
        )

        view.disableAutoresizingMask(
            scrollView,
//            developerSegments,
            developerImageView,
            telegramButton,
            containerView,
            headerView,
            nameLabel,
            aboutMeLabel,
            pageControl
        )
        
        scrollView.addSubviews(
            headerView,
//            developerSegments,
            containerView,
            nameLabel,
            aboutMeLabel
        )
        
        // TODO: - Поместить их в один метод
        containerView.addSubviews(developerImageView, telegramButton)
    }

    /// Метод добавления действий  элементам интерфейса
    func addActions() {
//        developerSegments.addTarget(
//            self,
//            action: #selector(showDeveloperInfo),
//            for: .valueChanged
//        )

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
            scrollView.topAnchor.constraint(equalTo: view.topAnchor),
            scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            scrollView.heightAnchor.constraint(equalToConstant: view.frame.height - 150),
            
            headerView.topAnchor.constraint(equalTo: view.topAnchor),
            headerView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            headerView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            headerView.bottomAnchor.constraint(equalTo: containerView.centerYAnchor),
            
//            developerSegments.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20),
//            developerSegments.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
//            developerSegments.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
//            developerSegments.heightAnchor.constraint(equalToConstant: 32),
            
            containerView.topAnchor.constraint(equalTo: scrollView.topAnchor, constant: 16),
            containerView.centerXAnchor.constraint(equalTo: scrollView.centerXAnchor),
            containerView.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.45),
            containerView.heightAnchor.constraint(equalTo: containerView.widthAnchor),

            developerImageView.topAnchor.constraint(equalTo: containerView.topAnchor),
            developerImageView.centerXAnchor.constraint(equalTo: containerView.centerXAnchor),
            developerImageView.widthAnchor.constraint(equalTo: containerView.widthAnchor),
            developerImageView.heightAnchor.constraint(equalTo: containerView.heightAnchor),

            telegramButton.trailingAnchor.constraint(equalTo: developerImageView.trailingAnchor, constant: -16),
            telegramButton.bottomAnchor.constraint(equalTo: developerImageView.bottomAnchor, constant: -16),
            telegramButton.heightAnchor.constraint(equalToConstant: 40),
            telegramButton.widthAnchor.constraint(equalToConstant: 40),
            
            nameLabel.topAnchor.constraint(equalTo: containerView.bottomAnchor, constant: 16),
            nameLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            nameLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            
            aboutMeLabel.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: 16),
            aboutMeLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 32),
            aboutMeLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -32),
          aboutMeLabel.heightAnchor.constraint(equalTo: scrollView.heightAnchor, multiplier: 0.2),
//            aboutMeLabel.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor, constant: 50),
            
            pageControl.topAnchor.constraint(equalTo: scrollView.bottomAnchor, constant: 16),
            pageControl.centerXAnchor.constraint(equalTo: scrollView.centerXAnchor)
        ])
    }
}

extension DevelopersViewController: UIScrollViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        pageControl.currentPage = Int(scrollView.contentOffset.x / UIScreen.main.bounds.width)
    }
}

// MARK: - Constants

private extension DevelopersViewController {

    /// Информация о разработчиках
    enum DevelopersInfo {
        static let names = [
            "Миша",
            "Кирилл",
            "Юра",
            "Бийбол",
            "Эльдар",
            "Рустам"
        ]

        static let contacts = [
            "https://t.me/AkiraReiTyan",
            "https://t.me/kizi_mcfly",
            "https://t.me/Radiator074",
            "https://t.me/zubi312",
            "https://t.me/eldarovsky",
            "https://t.me/hellofox"
        ]
    }

    /// Изображения
    enum Images {
        static let telegramLogo = "logo_telegram"
    }
}
