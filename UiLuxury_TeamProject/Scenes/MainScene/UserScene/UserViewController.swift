//
//  UserViewController.swift
//  UiLuxury_TeamProject
//
//  Created by Eldar Abdullin on 7/3/24
//

import UIKit

// MARK: - User ViewController

/// ViewController отображения информации о персонаже
final class UserViewController: UIViewController {
    
    // MARK: - Private properties
    
    /// Название стадии
    private let userStageLabel = UILabel()
    
    /// Изображение пользователя
    private var userImageView = UIImageView()
    
    /// Количество кредитов
    private let userCreditsLabel = UILabel()
    
    /// Таблица купленных предметов
    private let userItemsTableView = UITableView()

    /// Координатор контроллера
    private let coordinator: TabCoordinatorProtocol!

    /// Экземпляр вью модели
    private var viewModel: UserViewModelProtocol!

    // MARK: - Initializers

    // MARK: - Initializers
    
    init(coordinator: TabCoordinatorProtocol) {
        self.coordinator = coordinator
        super.init(nibName: nil, bundle: nil)
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError(GlobalConstants.fatalError)
    }
    
    // MARK: - Lifecycle methods
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupBinding()
        setupUI()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        updateUI()
    }
    
    // MARK: - Private Methods
    
    /// Метод обновления изображения пользователя со звуковым оповещением
    private func updateUserStage() {
        guard let stageImage = UIImage(named: viewModel.userStageImageName) else { return }
        userImageView.image = stageImage
        
        UIView.transition(
            with: userImageView,
            duration: 0.5,
            options: .transitionCrossDissolve,
            animations: { [weak self] in
                self?.userImageView.image = stageImage
            },
            completion: nil
        )
        
        viewModel.playSound()
    }
    
    /// Метод обновления внешнего вида сцены
    private func updateUI() {
        userStageLabel.text = Text.currentStage + viewModel.userStageName
        updateUserStage()
        userCreditsLabel.text = viewModel.userCreditsLabelText
        userItemsTableView.reloadData()
    }
}

// MARK: - TableView DataSource

extension UserViewController: UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        viewModel.numberOfSections
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        viewModel.numberOfRowsInSection
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = userItemsTableView.dequeueReusableCell(withIdentifier: Text.cellIdentifier, for: indexPath)
        
        var content = cell.defaultContentConfiguration()
        content.text = viewModel.getText(indexPath: indexPath)
        content.secondaryText = "\(Text.tableViewSecondaryText): $\(viewModel.getSecondaryText(indexPath: indexPath))"
        content.secondaryTextProperties.font = .boldSystemFont(ofSize: 17)
        
        setupUserItemsTableViewCell(cell)
        cell.contentConfiguration = content
        
        return cell
    }
}

// MARK: - TableView Delegate

extension UserViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let itemNameLabel = UILabel(frame: CGRect(x: 17, y: 3, width: tableView.frame.width, height: 20))
        itemNameLabel.text = viewModel.getTitleHeader(section: section)
        itemNameLabel.font = UIFont.boldSystemFont(ofSize: 17)
        itemNameLabel.textColor = .darkGray
        
        let contentView = UIView()
        contentView.layer.cornerRadius = 8
        contentView.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        contentView.addSubview(itemNameLabel)
        
        return contentView
    }
    
    func tableView(_ tableView: UITableView, willDisplayHeaderView view: UIView, forSection section: Int) {
        view.backgroundColor = .tertiarySystemGroupedBackground
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let cell = tableView.cellForRow(at: indexPath) {
            cell.selectedBackgroundView?.layer.cornerRadius = 8
            cell.selectedBackgroundView?.layer.maskedCorners = [.layerMinXMaxYCorner, .layerMaxXMaxYCorner]
        }
        
        showAlert(withTitle: Text.alertTitle, andMessage: Text.alertMessage) { [weak self] action in
            switch action {
            case .confirm:
                self?.viewModel.sellItem(indexPath: indexPath)
                self?.updateUI()
            case .refuse:
                tableView.deselectRow(at: indexPath, animated: true)
            }
        }
    }
}

// MARK: - Setup Binding

private extension UserViewController {
    
    /// Метод инициализации вью модели
    func setupBinding() {
        viewModel = UserViewModel(userData: coordinator.userData)
    }
}

// MARK: - Configure setupUI Method

private extension UserViewController {
    
    /// Метод настройки пользовательского интерфейса
    func setupUI() {
        setupView()
        setupStageLabel()
        setupUserImageView()
        setupWalletLabel()
        setupUserItemsTableView()

        addSubviews()
        setConstraints()
    }
}

// MARK: - Setup UI

private extension UserViewController {

    /// Метод настройки главного экрана
    func setupView() {
        navigationController?.navigationBar.isHidden = true
        view.addQuadroGradientLayer()
    }

    // MARK: Stage Label
    /// Метод настройки текста стадии
    func setupStageLabel() {
        userStageLabel.font = .boldSystemFont(ofSize: 17)
        userStageLabel.textColor = .black
        userStageLabel.textAlignment = .center
    }

    // MARK: User Image
    /// Метод настройки изображения пользователя
    func setupUserImageView() {
        userImageView.contentMode = .scaleAspectFit
        userImageView.layer.shadowColor = UIColor.black.cgColor
        userImageView.layer.shadowRadius = 8
        userImageView.layer.shadowOpacity = 0.5
        userImageView.layer.shadowOffset = CGSize(width: 0, height: 6)
    }

    // MARK: Wallet Label
    /// Метод настройки отображения количества кредитов
    func setupWalletLabel() {
        userCreditsLabel.font = .boldSystemFont(ofSize: 17)
        userCreditsLabel.textColor = .black
        userCreditsLabel.textAlignment = .center
    }

    // MARK: Items table
    /// Метод настройки таблицы купленных предметов
    func setupUserItemsTableView() {
        userItemsTableView.dataSource = self
        userItemsTableView.delegate = self
        userItemsTableView.register(UITableViewCell.self, forCellReuseIdentifier: Text.cellIdentifier)
        
        userItemsTableView.backgroundColor = .clear
        userItemsTableView.separatorStyle = .none
        userItemsTableView.layer.cornerRadius = 8
    }
    
    /// Метод настройки ячейки таблицы
    func setupUserItemsTableViewCell(_ cell: UITableViewCell) {
        cell.backgroundColor = .clear
        cell.layer.cornerRadius = 8
        cell.layer.maskedCorners = [.layerMaxXMaxYCorner, .layerMinXMaxYCorner]
        cell.layer.borderWidth = 2
        cell.layer.borderColor = CGColor(red: 1, green: 1, blue: 1, alpha: 1)
    }

    // MARK: Add subviews
    /// Метод добавления элементов интерфейса на главный экран и отключения масок AutoLayout
    func addSubviews() {
        view.addSubviews(
            userStageLabel,
            userImageView,
            userCreditsLabel,
            userItemsTableView
        )
        
        view.disableAutoresizingMask(
            userStageLabel,
            userImageView,
            userCreditsLabel,
            userItemsTableView
        )
    }
}

// MARK: - Constraints

private extension UserViewController {
    
    /// Метод установки констреинтов элементов интерфейса
    func setConstraints() {
        NSLayoutConstraint.activate([
            
            // MARK: User Stage label
            userStageLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 40),
            userStageLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            userStageLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            userStageLabel.heightAnchor.constraint(equalToConstant: 22),

            // MARK: User Image
            userImageView.topAnchor.constraint(equalTo: userStageLabel.bottomAnchor, constant: 32),
            userImageView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            userImageView.heightAnchor.constraint(equalToConstant: 150),
            userImageView.widthAnchor.constraint(equalToConstant: 150),

            // MARK: User Credits Label
            userCreditsLabel.topAnchor.constraint(equalTo: userImageView.bottomAnchor, constant: 32),
            userCreditsLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            userCreditsLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            userCreditsLabel.heightAnchor.constraint(equalToConstant: 22),

            // MARK: User Items Table
            userItemsTableView.topAnchor.constraint(equalTo: userCreditsLabel.bottomAnchor, constant: 32),
            userItemsTableView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            userItemsTableView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            userItemsTableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -20)
        ])
    }
}

// MARK: - Alert Controller

private extension UserViewController {
    
    /// Действия алерт-контроллера
    enum AlertAction {
        case confirm
        case refuse
    }
    
    /// Метод настройки алерт-контроллера
    func showAlert(withTitle title: String, andMessage message: String, _ handler: @escaping (AlertAction) -> Void) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        
        let confirmAction = UIAlertAction(title: Text.alertConfirmTitle, style: .default) { _ in
            handler(.confirm)
        }
        let refuseAction = UIAlertAction(title: Text.alertRefuseTitle, style: .destructive) { _ in
            handler(.refuse)
        }
        
        alert.addAction(confirmAction)
        alert.addAction(refuseAction)
        
        present(alert, animated: true)
    }
}

// MARK: - Constants

private extension UserViewController {
    
    /// Текстовые константы
    enum Text {
        static let cellIdentifier = "cell"
        static let currentStage = "СТАДИЯ: "
        static let tableViewSecondaryText = "Продать:"
        
        static let alertTitle = "Продать?"
        static let alertMessage = ""
        static let alertConfirmTitle = "Да"
        static let alertRefuseTitle = "Нет"
    }
}
