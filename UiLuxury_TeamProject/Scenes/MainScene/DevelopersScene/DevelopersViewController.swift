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
    
    // MARK: - Private properties
    
    /// Скролл Вью для перехода между раработчиками
    private var scrollView = UIScrollView()
    
    /// Пейдж Контрол
    private let pageControl = UIPageControl()
    
    /// КонтейнерВью для тени
    private var containerViewOne = UIView()
    private var containerViewTwo = UIView()
    private var containerViewThree = UIView()
    private var containerViewFour = UIView()
    private var containerViewFive = UIView()
    
    /// Изображение разработчика
    private var developerImageViewOne = UIImageView()
    private var developerImageViewTwo = UIImageView()
    private var developerImageViewThree = UIImageView()
    private var developerImageViewFour = UIImageView()
    private var developerImageViewFive = UIImageView()
    
    /// Кнопка перехода в Telegram
    private var telegramButtonOne = UIButton()
    private var telegramButtonTwo = UIButton()
    private var telegramButtonThree = UIButton()
    private var telegramButtonFour = UIButton()
    private var telegramButtonFive = UIButton()
    
    /// Лейбл с именем разработчика
    
    private var nameLabelOne = UILabel()
    private var nameLabelTwo = UILabel()
    private var nameLabelThree = UILabel()
    private var nameLabelFour = UILabel()
    private var nameLabelFive = UILabel()
    
    /// Текущая Telegram-ссылка разработчика
    private var currentURL: String!  //DevelopersInfo.contacts[0]
    
    /// Массив с именами разработчиков
    //private var names: [String]!
    
    /// Массив ссылок на телеграмм разработчиков
    //private var contacts: [String]!
    
    /// Массив ролей разработчиков
    //private var roles: [String]!
    
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
    
    // MARK: - Lifecycle Methods
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupBinding()
        setupUI()
        addActions()
    }
    
    /// Делаем из нашего изображения круг
    override func viewWillLayoutSubviews() {
        let cornerRadiusReady = developerImageViewOne.layer.frame.height / 2
        
        developerImageViewOne.layer.cornerRadius = cornerRadiusReady
        developerImageViewTwo.layer.cornerRadius = cornerRadiusReady
        developerImageViewThree.layer.cornerRadius = cornerRadiusReady
        developerImageViewFour.layer.cornerRadius = cornerRadiusReady
        developerImageViewFive.layer.cornerRadius = cornerRadiusReady
    }
    
    // MARK: - Private Methods
    
    //    /// Метод настройки карточки разработчика
    //    @objc private func showDeveloperInfo() {
    //        let selectedSegmentIndex = developerSegments.selectedSegmentIndex
    //        guard selectedSegmentIndex < names.count else { return }
    //        segmentIndex = selectedSegmentIndex
    //
    //        guard let developerImage = UIImage(named: String(segmentIndex)) else { return }
    //        developerImageView.image = developerImage
    //
    //        let developerContact = contacts[segmentIndex]
    //        currentURL = developerContact
    //
    //        let developerRole = roles[segmentIndex]
    //        roleLabel.text = developerRole
    //    }
    
    /// Метод перехода в Telegram
    @objc private func openURL() {
        guard let url = URL(string: currentURL) else { return }
        UIApplication.shared.open(url)
    }
    
    /// Метод показывает нужную картинку в зависимости от того, какую страницу
    /// выбрал пользователь на пейдж индикаторе
    // Важно! Пользователь не может нажать на конкретную точку на пейдж индикаторе
    // То, что мы можем с эмулятора это сделать не означает, что на айфоне у пользователя
    // есть в принципе физически сделать такое т.к сначала пейдж индикатор выделяется, а
    // потом уже пользователь проводит этим пальцем из стороны в сторону в поисках нужного
    // экрана.
    @objc func pageControlTapped(sender: UIPageControl) {
        scrollView.setContentOffset(
            CGPoint(
                x: UIScreen.main.bounds.width * CGFloat(sender.currentPage),
                y: 0
            ),
            animated: true)
        
        setupURL(with: sender.currentPage)
    }
    
    /// Тут мы изменяем ссылку на актульную
    private func setupURL(with position: Int) {
        currentURL = viewModel.getContacts()[position]
    }
    
}

// MARK: - SetupBinding

private extension DevelopersViewController {
    
    func setupBinding() {
        viewModel = DevelopersViewModel()
//        names = viewModel.getNames()
//        contacts = viewModel.getContacts()
//        currentURL = contacts[0]
//        roles = viewModel.getRoles()
    }
}

// MARK: - Configure UI

private extension DevelopersViewController {
    
    /// Метод настройки пользовательского интерфейса
    func setupUI() {
        setupView()
        // TODO: попробовать перенести в setupView
        setupScrollView()
        //        setupDeveloperImageView()
        //        setupTelegramButton()
        //        setupRoleLabel()
        
        addSubviews()
        setConstraints()
        addActions()
    }
}

// MARK: - Setup UI

private extension DevelopersViewController {
    
    /// Метод настройки главного экрана
    func setupView() {
        navigationController?.navigationBar.isHidden = true
        view.addQuadroGradientLayer()
        
        setupPageControl()
        setupLabels()
        setupDeveloperImages()
        setupTelegramButtons()
    }

    // MARK: Page control
    
    /// Метод настройки пейдж контроллера
        func setupPageControl() {
            pageControl.numberOfPages = viewModel.getTeamCount()
        }

    // MARK: Developer image
    
    /// Метод настройки изображения пользователя
    func setupLabels() {
        var nameLabels = [
            nameLabelOne,
            nameLabelTwo,
            nameLabelThree,
            nameLabelFour,
            nameLabelFive
        ]
        
        for i in 0..<viewModel.getNames().count {
            nameLabels[i] = addLabel(position: CGFloat(i))
        }
    }
    
    /// Устанавливаем изображения + контейнер вью как тень
    func setupDeveloperImages() {
        developerImageViewOne = addDeveloperImage(
            imageNamed: 0,
            position: 0,
            containerView: containerViewOne
        )
        developerImageViewTwo = addDeveloperImage(
            imageNamed: 1,
            position: 1,
            containerView: containerViewTwo
        )
        developerImageViewThree = addDeveloperImage(
            imageNamed: 2,
            position: 2,
            containerView: containerViewThree
        )
        developerImageViewFour = addDeveloperImage(
            imageNamed: 3,
            position: 3,
            containerView: containerViewFour
        )
        developerImageViewFive = addDeveloperImage(
            imageNamed: 4,
            position: 4,
            containerView: containerViewFive
        )
    }
    
    // MARK: Telegram button
    
    /// Метод настройки изображения кнопки перехода в Telegram
    func setupTelegramButtons() {
        telegramButtonOne = addTelegramButton(position: 0)
        telegramButtonTwo = addTelegramButton(position: 1)
        telegramButtonThree = addTelegramButton(position: 2)
        telegramButtonFour = addTelegramButton(position: 3)
        telegramButtonFive = addTelegramButton(position: 4)
    }
    
    // MARK: Scroll View
    
    ///  Настройка скролл вью
    //  В контент сайзе мы указываем высоту как 1 для того, чтобы отключить вертикальный скролл
    //  И мы пользовались только свайпами вправо-влево
    func setupScrollView() {
        scrollView.contentSize = CGSize(
            width: Int(UIScreen.main.bounds.width) * viewModel.getTeamCount(),
            height: 1
        )
        
        scrollView.isPagingEnabled = true
        scrollView.showsHorizontalScrollIndicator = false
        
        scrollView.delegate = self
    }
    
    // MARK: Add labels
    /// Добавляем лейблы на каждую из страниц
    func addLabel(position: CGFloat) -> UILabel {
        let actualName = viewModel.getNames()[Int(position)]
        let nameLabel = UILabel().setupDeveloperNameLabels(with: actualName)
        let screenWidth: CGFloat = UIScreen.main.bounds.width
        
        scrollView.contentInsetAdjustmentBehavior = .never
        scrollView.addSubview(nameLabel)
        
        NSLayoutConstraint.activate([
            nameLabel.topAnchor.constraint(
                equalToSystemSpacingBelow: scrollView.topAnchor,
                multiplier: 32
            ),
            nameLabel.leadingAnchor.constraint(
                equalTo: scrollView.leadingAnchor,
                constant: screenWidth * position
            ),
            nameLabel.widthAnchor.constraint(
                equalToConstant: screenWidth
            )
        ])
        
        return nameLabel
    }
    
    /// Добавляем Изображения на каждую из страниц
    // ImageNames - это название изображения в Ассетах. Изображения под номерами 0-6
    // Position - это по факту страница. Т.е номер страницы, на которых располагаются данные
    // ContainerView - это контейнер, который выполняет роль тени здесь. Просто добавить
    // тень к изображению мы не можем т.к он обрезает все лишнее
    // Это должен быть один метод, иначе imageView и containerView не знают друг о друге
    // А значит имедж не сможет стать сабвью контейнера. А это фатал еррор.
    func addDeveloperImage(imageNamed: Int, position: CGFloat, containerView: UIView) -> UIImageView {
        let imageView = UIImageView().setupDeveloperImage(imageNamed: imageNamed)
        let containerView = UIView()
        let screenWidth: CGFloat = UIScreen.main.bounds.width
        
        imageView.clipsToBounds = true
        
        containerView.layer.shadowColor = UIColor.black.cgColor
        containerView.layer.shadowOpacity = 0.8
        containerView.layer.shadowRadius = 10
        
        scrollView.addSubview(containerView)
        containerView.addSubview(imageView)
        containerView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            containerView.centerXAnchor.constraint(
                equalTo: scrollView.centerXAnchor,
                constant: screenWidth * position
            ),
            containerView.topAnchor.constraint(
                equalToSystemSpacingBelow: scrollView.topAnchor,
                multiplier: 8
            ),
            containerView.widthAnchor.constraint(
                equalToConstant: screenWidth / 2.25
            ),
            containerView.heightAnchor.constraint(
                equalTo: containerView.widthAnchor
            ),
            
            imageView.topAnchor.constraint(equalTo: containerView.topAnchor),
            imageView.leadingAnchor.constraint(equalTo: containerView.leadingAnchor),
            imageView.trailingAnchor.constraint(equalTo: containerView.trailingAnchor),
            imageView.bottomAnchor.constraint(equalTo: containerView.bottomAnchor)
        ])
        
        return imageView
    }
    
    /// Настраиваем кнопку телеграмма для каждого из разработчиков
    func addTelegramButton(position: CGFloat) -> UIButton {
        let telegramDeveloperButton = UIButton()
        let telegramImage = UIImage(named: Images.telegramLogo)
        let screenWidth: CGFloat = UIScreen.main.bounds.width
        
        telegramDeveloperButton.setImage(telegramImage, for: .normal)
        
        scrollView.addSubview(telegramDeveloperButton)
        telegramDeveloperButton.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            telegramDeveloperButton.topAnchor.constraint(
                equalToSystemSpacingBelow: scrollView.topAnchor,
                multiplier: 23
            ),
            telegramDeveloperButton.leadingAnchor.constraint(
                equalTo: scrollView.leadingAnchor,
                constant: screenWidth * position + screenWidth / 2 + screenWidth / 9
            ),
            telegramDeveloperButton.widthAnchor.constraint(
                equalToConstant: screenWidth / 9
            ),
            telegramDeveloperButton.heightAnchor.constraint(
                equalToConstant: screenWidth / 9
            )
        ])
        
        return telegramDeveloperButton
    }
    
    // MARK: Add subviews
    
    /// Метод добавления элементов интерфейса на главный экран и отключения масок AutoLayout
    func addSubviews() {
        view.addSubviews(
            scrollView,
            pageControl
        )
        view.disableAutoresizingMask(
            scrollView,
            pageControl
        )
    }

    // MARK: Actions
    
    /// Метод добавления действий  элементам интерфейса
    func addActions() {
        let buttons = [
            telegramButtonOne,
            telegramButtonTwo,
            telegramButtonThree,
            telegramButtonFour,
            telegramButtonFive
        ]
        
        buttons.forEach { button in
            button.addTarget(self, action: #selector(openURL), for: .touchUpInside)
        }
        
        pageControl.addTarget(self, action: #selector(pageControlTapped), for: .touchUpInside)
    }
}

// MARK: - Constraints

private extension DevelopersViewController {

    /// Метод установки констреинтов элементов интерфейса
    func setConstraints() {
        NSLayoutConstraint.activate([
            
            // MARK: ScrollView
            scrollView.topAnchor.constraint(equalTo: view.topAnchor),
            scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            scrollView.heightAnchor.constraint(equalToConstant: view.frame.height - 150),
            
            // MARK: PageControl
            pageControl.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -36),
            pageControl.centerXAnchor.constraint(equalTo: scrollView.centerXAnchor)
        ])
    }
}

//MARK: - ScrollViewDelegate
// Тут мы настраиваем логику свайпа. При свайпе изменяется контент и, что главное, мы устанавливаем значение для пейджКонтрола. Плюсом, в этом же методе, мы обновляем ссылку для кнопки телеграма.  В зависимости от страницы обновляется юрл.
extension DevelopersViewController: UIScrollViewDelegate {
    
    /// Метод настройки свайпа скроллвью
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        pageControl.currentPage = Int(scrollView.contentOffset.x / UIScreen.main.bounds.width)
        
        setupURL(with: pageControl.currentPage)
    }
}

// MARK: - Constants
// TODO: проверить необходимость
private extension DevelopersViewController {

    /// Изображения
    enum Images {
        static let telegramLogo = "logo_telegram"
    }
}
