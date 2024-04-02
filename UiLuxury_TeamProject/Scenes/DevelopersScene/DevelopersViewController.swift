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
    
    private var developerImageViewOne = UIImageView()
    private var developerImageViewTwo = UIImageView()
    private var developerImageViewThree = UIImageView()
    private var developerImageViewFour = UIImageView()
    private var developerImageViewFive = UIImageView()
    private var developerImageViewSix = UIImageView()
    
    /// Шапка
    private let headerView = UIView()
    
    /// Графический слой изображения
    private let containerView = UIView()
    
    /// Кнопка перехода в Telegram
    private let telegramButton = UIButton()
    
    private var telegramButtonOne = UIButton()
    private var telegramButtonTwo = UIButton()
    private var telegramButtonThree = UIButton()
    private var telegramButtonFour = UIButton()
    private var telegramButtonFive = UIButton()
    private var telegramButtonSix = UIButton()
    
    /// Лейбл с именем разработчика
    private let nameLabel = UILabel()
    
    private var nameLabelOne = UILabel()
    private var nameLabelTwo = UILabel()
    private var nameLabelThree = UILabel()
    private var nameLabelFour = UILabel()
    private var nameLabelFive = UILabel()
    private var nameLabelSix = UILabel()
    
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
        
        pageControl.numberOfPages = DevelopersInfo.names.count
    }
    
    /// Скрываем нивгейшн бар
    override func viewWillAppear(_ animated: Bool) {
        navigationController?.navigationBar.isHidden = true
    }
    
    /// Делаем из нашего изображения круг
    override func viewWillLayoutSubviews() {
        let cornerRadiusReady = developerImageView.layer.frame.height / 2
        
        containerView.layer.cornerRadius = cornerRadiusReady
        developerImageView.layer.cornerRadius = cornerRadiusReady
        
        developerImageViewOne.layer.cornerRadius = cornerRadiusReady
        developerImageViewTwo.layer.cornerRadius = cornerRadiusReady
        developerImageViewThree.layer.cornerRadius = cornerRadiusReady
        developerImageViewFour.layer.cornerRadius = cornerRadiusReady
        developerImageViewFive.layer.cornerRadius = cornerRadiusReady
        developerImageViewSix.layer.cornerRadius = cornerRadiusReady
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
    
    /// Тут мы изменяем ссылку на актульную
    private func setupURL(with position: Int) {
        currentURL = DevelopersInfo.contacts[position]
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
    
    ///  Настройка скролл вью
    ///  В контент сайзе мы указываем высоту как 1 для того, чтобы отключить вертикальный скролл
    ///  И мы пользовались только свайпами вправо-влево
    func setupScrollView() {
        scrollView.contentSize = CGSize(
            width: Int(UIScreen.main.bounds.width) * DevelopersInfo.names.count,
            height: Int(1) //Int(view.frame.height - 200)
        )
        scrollView.isPagingEnabled = true
        scrollView.showsHorizontalScrollIndicator = false
        
        nameLabelOne = addLabel(title: DevelopersInfo.names[0], position: 0)
        nameLabelTwo = addLabel(title: DevelopersInfo.names[0], position: 1)
        nameLabelThree = addLabel(title: DevelopersInfo.names[2], position: 2)
        nameLabelFour = addLabel(title: DevelopersInfo.names[3], position: 3)
        nameLabelFive = addLabel(title: DevelopersInfo.names[4], position: 4)
        nameLabelSix = addLabel(title: DevelopersInfo.names[5], position: 5)
        
        developerImageViewOne = addDeveloperImage(imageNamed: 0, position: 0)
        developerImageViewTwo = addDeveloperImage(imageNamed: 1, position: 1)
        developerImageViewThree = addDeveloperImage(imageNamed: 2, position: 2)
        developerImageViewFour = addDeveloperImage(imageNamed: 3, position: 3)
        developerImageViewFive = addDeveloperImage(imageNamed: 4, position: 4)
        developerImageViewSix = addDeveloperImage(imageNamed: 5, position: 5)
        
        telegramButtonOne = addTelegramButton(position: 0)
        telegramButtonTwo = addTelegramButton(position: 1)
        telegramButtonThree = addTelegramButton(position: 2)
        telegramButtonFour = addTelegramButton(position: 3)
        telegramButtonFive = addTelegramButton(position: 4)
        telegramButtonSix = addTelegramButton(position: 5)
        
        scrollView.delegate = self
    }
    
    /// Добавляем лейблы на каждую из страниц
    func addLabel(title: String, position: CGFloat) -> UILabel {
        let testLabel = UILabel()
        testLabel.text = DevelopersInfo.names[Int(position)]
        testLabel.textAlignment = .center
        testLabel.font = UIFont.systemFont(ofSize: 25)
        
        scrollView.addSubview(testLabel)
        
        testLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            testLabel.topAnchor.constraint(equalTo: scrollView.topAnchor, constant: 125),
            testLabel.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor, constant: UIScreen.main.bounds.width * position),
            testLabel.widthAnchor.constraint(equalToConstant: UIScreen.main.bounds.width),
            testLabel.heightAnchor.constraint(equalToConstant: 200)
        ])
        
        return testLabel
    }
    
    /// Добавляем Изображения на каждую из страниц
    func addDeveloperImage(imageNamed: Int, position: CGFloat) -> UIImageView {
        let imageView = UIImageView()
        
        imageView.image = UIImage(named: String(imageNamed))
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        
        imageView.layer.borderWidth = 2
        imageView.layer.borderColor = UIColor.yellow.cgColor
        
        scrollView.addSubview(imageView)
        
        imageView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            imageView.centerXAnchor.constraint(equalTo: scrollView.centerXAnchor, constant: UIScreen.main.bounds.width * position),
            imageView.topAnchor.constraint(equalTo: scrollView.topAnchor, constant: 16),
            imageView.widthAnchor.constraint(equalToConstant: UIScreen.main.bounds.width / 2.25),
            imageView.heightAnchor.constraint(equalTo: imageView.widthAnchor)
        ])
        
        return imageView
    }
    
    /// Настраиваем кнопку телеграмма для каждого из разработчиков
    func addTelegramButton(position: CGFloat) -> UIButton {
        let telegramDeveloperButton = UIButton()
        
        guard let image = UIImage(named: Images.telegramLogo) else { return UIButton() }
        telegramDeveloperButton.setImage(image, for: .normal)
        
        scrollView.addSubview(telegramDeveloperButton)
        
        telegramDeveloperButton.translatesAutoresizingMaskIntoConstraints = false
        let screenWidth: CGFloat = UIScreen.main.bounds.width
        
        NSLayoutConstraint.activate([
            telegramDeveloperButton.topAnchor.constraint(equalTo: scrollView.topAnchor, constant: 140),
            telegramDeveloperButton.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor, constant: screenWidth * position + screenWidth / 2 + screenWidth / 9),
            telegramDeveloperButton.widthAnchor.constraint(equalToConstant: screenWidth / 9),
            telegramDeveloperButton.heightAnchor.constraint(equalToConstant: screenWidth / 9)
        ])
        
        return telegramDeveloperButton
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
        aboutMeLabel.text = ""
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
            containerView,
            nameLabel,
            aboutMeLabel
        )
        
        containerView.addSubviews(developerImageView, telegramButton)
    }
    
    /// Метод добавления действий  элементам интерфейса
    func addActions() {
        telegramButtonOne.addTarget(self, action: #selector(openURL), for: .touchUpInside)
        telegramButtonTwo.addTarget(self, action: #selector(openURL), for: .touchUpInside)
        telegramButtonThree.addTarget(self, action: #selector(openURL), for: .touchUpInside)
        telegramButtonFour.addTarget(self, action: #selector(openURL), for: .touchUpInside)
        telegramButtonFive.addTarget(self, action: #selector(openURL), for: .touchUpInside)
        telegramButtonSix.addTarget(self, action: #selector(openURL), for: .touchUpInside)
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
            
//            headerView.topAnchor.constraint(equalTo: view.topAnchor),
//            headerView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
//            headerView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
//            headerView.bottomAnchor.constraint(equalTo: containerView.centerYAnchor),
            
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
        
        setupURL(with: pageControl.currentPage)
    }
}

// MARK: - Constants

private extension DevelopersViewController {
    
    /// Информация о разработчиках
    enum DevelopersInfo {
        static let names = [
            "AlexDarkStalker98",
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
