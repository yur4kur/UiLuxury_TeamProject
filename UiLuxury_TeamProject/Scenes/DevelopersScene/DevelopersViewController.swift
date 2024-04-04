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
    
    /// Шапка
    private let headerView = UIView()
    
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
        viewModel.getTelegramURL { url in
            self.currentURL = url[position]
        }
    }
}

// MARK: - Configure UI

private extension DevelopersViewController {
    
    /// Метод настройки пользовательского интерфейса
    func setupUI() {
        setupView()
        setupScrollView()

        setupHeader()
        
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
        var developersNames = [""]
        
        viewModel.getNames { names in
            developersNames = names
        }
        
        scrollView.contentSize = CGSize(
            width: Int(UIScreen.main.bounds.width) * developersNames.count,
            height: Int(1) //Int(view.frame.height - 200)
        )
        scrollView.isPagingEnabled = true
        scrollView.showsHorizontalScrollIndicator = false
        
        nameLabelOne = addLabel(title: developersNames[0], position: 0)
        nameLabelTwo = addLabel(title: developersNames[0], position: 1)
        nameLabelThree = addLabel(title: developersNames[2], position: 2)
        nameLabelFour = addLabel(title: developersNames[3], position: 3)
        nameLabelFive = addLabel(title: developersNames[4], position: 4)
        nameLabelSix = addLabel(title: developersNames[5], position: 5)
        
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
        let nameLabel = UILabel()
        var actualName = ""
        
        viewModel.getNames { names in
            actualName = names[Int(position)]
        }
        
        nameLabel.text = actualName
        nameLabel.textAlignment = .center
        nameLabel.font = UIFont.systemFont(ofSize: 25)
        
        scrollView.addSubview(nameLabel)
        
        nameLabel.translatesAutoresizingMaskIntoConstraints = false
        let screenWidth: CGFloat = UIScreen.main.bounds.width
        NSLayoutConstraint.activate([
            nameLabel.topAnchor.constraint(equalTo: scrollView.topAnchor, constant: 190),
            nameLabel.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor, constant: screenWidth * position),
            nameLabel.widthAnchor.constraint(equalToConstant: screenWidth),
            nameLabel.heightAnchor.constraint(equalToConstant: 300)
        ])
        return nameLabel
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
        let screenWidth: CGFloat = UIScreen.main.bounds.width
        
        NSLayoutConstraint.activate([
            imageView.centerXAnchor.constraint(equalTo: scrollView.centerXAnchor, constant: screenWidth * position),
            imageView.topAnchor.constraint(equalTo: scrollView.topAnchor, constant: 116),
            imageView.widthAnchor.constraint(equalToConstant: screenWidth / 2.25),
            imageView.heightAnchor.constraint(equalTo: imageView.widthAnchor)
        ])
        
        return imageView
    }
    
    /// Настраиваем кнопку телеграмма для каждого из разработчиков
    func addTelegramButton(position: CGFloat) -> UIButton {
        let telegramDeveloperButton = UIButton()
        var telegramImage = UIImage()
        
        viewModel.getTelegramImage { image in
            telegramImage = UIImage(named: image) ?? UIImage()
        }

        telegramDeveloperButton.setImage(telegramImage, for: .normal)
        
        scrollView.addSubview(telegramDeveloperButton)
        
        telegramDeveloperButton.translatesAutoresizingMaskIntoConstraints = false
        let screenWidth: CGFloat = UIScreen.main.bounds.width
        
        NSLayoutConstraint.activate([
            telegramDeveloperButton.topAnchor.constraint(equalTo: scrollView.topAnchor, constant: 240),
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
    
    /// Метод добавления элементов интерфейса на главный экран и отключения масок AutoLayout
    func addSubviews() {
        view.addSubviews(
            scrollView,
            pageControl
        )
        
        view.disableAutoresizingMask(
            scrollView,
            headerView,
            pageControl
        )
        
        scrollView.addSubviews(
            headerView
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
            scrollView.topAnchor.constraint(equalTo: view.topAnchor),
            scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            scrollView.heightAnchor.constraint(equalToConstant: view.frame.height - 150),
            
            pageControl.topAnchor.constraint(equalTo: scrollView.bottomAnchor, constant: 32),
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
