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
    
    /// Вью модель
    private let viewModel = DevelopersViewModel()
    
    /// Скролл Вью для перехода между раработчиками
    private var scrollView = UIScrollView()
    
    /// Пейдж Контрол
    private let pageControl = UIPageControl()
    
    /// Изображение разработчика
    private var developerImageViewOne = UIImageView()
    private var developerImageViewTwo = UIImageView()
    private var developerImageViewThree = UIImageView()
    private var developerImageViewFour = UIImageView()
    private var developerImageViewFive = UIImageView()
    private var developerImageViewSix = UIImageView()
    
    /// Кнопка перехода в Telegram
    private var telegramButtonOne = UIButton()
    private var telegramButtonTwo = UIButton()
    private var telegramButtonThree = UIButton()
    private var telegramButtonFour = UIButton()
    private var telegramButtonFive = UIButton()
    private var telegramButtonSix = UIButton()
    
    /// Лейбл с именем разработчика
    
    private var nameLabelOne = UILabel()
    private var nameLabelTwo = UILabel()
    private var nameLabelThree = UILabel()
    private var nameLabelFour = UILabel()
    private var nameLabelFive = UILabel()
    private var nameLabelSix = UILabel()
    
    /// Текущая Telegram-ссылка разработчика. Это свойство постоянно обновляется в методах
    /// setupURL и openURL. Присваивается новая юрла другого разработчика.
    private var currentURL = ""
    
    // MARK: Lifecycle Methods
    
    /// Настройка вью и вызов всех методов для этого
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        addActions()
        
        pageControl.numberOfPages = viewModel.getNamesCount()
    }
    
    /// Скрываем нивгейшн бар
    override func viewWillAppear(_ animated: Bool) {
        navigationController?.navigationBar.isHidden = true
    }
    
    /// Делаем из нашего изображения круг
    override func viewWillLayoutSubviews() {
        let cornerRadiusReady = developerImageViewOne.layer.frame.height / 2
        
        developerImageViewOne.layer.cornerRadius = cornerRadiusReady
        developerImageViewTwo.layer.cornerRadius = cornerRadiusReady
        developerImageViewThree.layer.cornerRadius = cornerRadiusReady
        developerImageViewFour.layer.cornerRadius = cornerRadiusReady
        developerImageViewFive.layer.cornerRadius = cornerRadiusReady
        developerImageViewSix.layer.cornerRadius = cornerRadiusReady
    }
    
    // MARK: Private Methods
    
    /// Метод перехода в Telegram
    @objc private func openURL() {
        guard let url = URL(string: currentURL) else { return }
        UIApplication.shared.open(url)
    }
    
    /// Тут мы изменяем ссылку на актульную
    private func setupURL(with position: Int) {
        currentURL = viewModel.getTelegramURL()[position]
    }
}

// MARK: - Configure UI

private extension DevelopersViewController {
    /// Метод настройки пользовательского интерфейса
    func setupUI() {
        setupView()
        setupScrollView()
        
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
        
        setupLabels()
        setupDeveloperImages()
        setupTelegramButtons()
    }
    
    /// Устанавливаем лейблы
    func setupLabels() {
        let developersNames = viewModel.getNames()
        
        nameLabelOne = addLabel(position: 0)
        nameLabelTwo = addLabel(position: 1)
        nameLabelThree = addLabel(position: 2)
        nameLabelFour = addLabel(position: 3)
        nameLabelFive = addLabel(position: 4)
        nameLabelSix = addLabel(position: 5)
    }
    
    /// Устанавливаем изображения
    func setupDeveloperImages() {
        developerImageViewOne = addDeveloperImage(imageNamed: 0, position: 0)
        developerImageViewTwo = addDeveloperImage(imageNamed: 1, position: 1)
        developerImageViewThree = addDeveloperImage(imageNamed: 2, position: 2)
        developerImageViewFour = addDeveloperImage(imageNamed: 3, position: 3)
        developerImageViewFive = addDeveloperImage(imageNamed: 4, position: 4)
        developerImageViewSix = addDeveloperImage(imageNamed: 5, position: 5)
    }
    
    /// Устанавливаем ссылки на телеграм для кнопок
    func setupTelegramButtons() {
        telegramButtonOne = addTelegramButton(position: 0)
        telegramButtonTwo = addTelegramButton(position: 1)
        telegramButtonThree = addTelegramButton(position: 2)
        telegramButtonFour = addTelegramButton(position: 3)
        telegramButtonFive = addTelegramButton(position: 4)
        telegramButtonSix = addTelegramButton(position: 5)
    }
    
    ///  Настройка скролл вью
    ///  В контент сайзе мы указываем высоту как 1 для того, чтобы отключить вертикальный скролл
    ///  И мы пользовались только свайпами вправо-влево
    func setupScrollView() {
        scrollView.contentSize = CGSize(
            width: Int(UIScreen.main.bounds.width) * viewModel.getNamesCount(),
            height: Int(1)
        )
        
        scrollView.isPagingEnabled = true
        scrollView.showsHorizontalScrollIndicator = false
        
        scrollView.delegate = self
    }
    
    /// Добавляем лейблы на каждую из страниц
    func addLabel(position: CGFloat) -> UILabel {
        let actualName = viewModel.getNames()[Int(position)]
        let nameLabel = UILabel().setupDeveloperNameLabels(with: actualName)
        let screenWidth: CGFloat = UIScreen.main.bounds.width

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
    /// ImageNames - это название изображения в Ассетах. Изображения под номерами 0-6
    /// Position - это по факту страница. Т.е номер страницы, на которых располагаются данные
    func addDeveloperImage(imageNamed: Int, position: CGFloat) -> UIImageView {
        let imageView = UIImageView().setupDeveloperImage(imageNamed: imageNamed)
        let screenWidth: CGFloat = UIScreen.main.bounds.width
        
        scrollView.addSubview(imageView)
        
        NSLayoutConstraint.activate([
            imageView.centerXAnchor.constraint(
                equalTo: scrollView.centerXAnchor,
                constant: screenWidth * position
            ),
            imageView.topAnchor.constraint(
                equalToSystemSpacingBelow: scrollView.topAnchor,
                multiplier: 8
            ),
            imageView.widthAnchor.constraint(
                equalToConstant: screenWidth / 2.25
            ),
            imageView.heightAnchor.constraint(
                equalTo: imageView.widthAnchor
            )
        ])
        
        return imageView
    }
    
    /// Настраиваем кнопку телеграмма для каждого из разработчиков
    func addTelegramButton(position: CGFloat) -> UIButton {
        let telegramDeveloperButton = UIButton()
        let telegramImage = UIImage(named: viewModel.getTelegramImage())
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
            scrollView.topAnchor.constraint(
                equalTo: view.topAnchor
            ),
            scrollView.leadingAnchor.constraint(
                equalTo: view.leadingAnchor
            ),
            scrollView.trailingAnchor.constraint(
                equalTo: view.trailingAnchor
            ),
            scrollView.heightAnchor.constraint(
                equalToConstant: view.frame.height - 150
            ),
            
            pageControl.topAnchor.constraint(
                equalTo: scrollView.bottomAnchor,
                constant: 32
            ),
            pageControl.centerXAnchor.constraint(
                equalTo: scrollView.centerXAnchor
            )
        ])
    }
}

extension DevelopersViewController: UIScrollViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        pageControl.currentPage = Int(scrollView.contentOffset.x / UIScreen.main.bounds.width)
        
        setupURL(with: pageControl.currentPage)
    }
}
