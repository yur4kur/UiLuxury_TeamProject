//
//  InfoCharacterViewController.swift
//  UiLuxury_TeamProject
//
//  Created by Eldar Abdullin on 7/3/24
//

import UIKit
import AVFoundation

// MARK: - InfoCharacter ViewController

/// ViewController отображения информации о персонаже
final class InfoCharacterViewController: UIViewController {

    // MARK: - Public properties
    // var delegate: ISendInfoAboutCharacterDelegate?
    // var items: [Item] = DataSource.shared.gameItems
    // var userWallet = 0

    // MARK: - Private properties

    /// Изображение пользователя
    private var userImageView = UIImageView()

    /// Отображение количества кредитов
    private let userCreditsLabel = UILabel()

    /// Таблица отображения купленных предметов
    private let userItemsTableView = UITableView()

    /// Точка доступа к SoundManager
    private let soundManager = SoundManager.shared

    /// Экземпляр модели User
    private var user = User.shared

    /// Текущий уровень пользователя
    private var userStage = 0

    // MARK: - Lifecycle methods

    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        updateCreditsValue()
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        updateUserImage()
    }

    // MARK: - Private methods

    /// Метод обновления изображения пользователя с анимацией и воспроизведением звука
    private func updateUserImage() {
        let credits = user.wallet
        let previousUserStage = userStage

        userStage = calculateUserStage(from: credits)

        let stageImage = StageImages.images[userStage]
        guard let userImage = UIImage(named: stageImage) else { return }
        userImageView.image = userImage

        UIView.transition(with: userImageView,
                          duration: 0.5,
                          options: .transitionCrossDissolve,
                          animations: { [weak self] in
            self?.userImageView.image = userImage
        },
                          completion: nil)

        if userStage > previousUserStage {
            play(sound: Sounds.levelUp)
        } else if userStage < previousUserStage {
            play(sound: Sounds.levelDown)
        }
    }

    /// Метод определения уровня пользователя
    private func calculateUserStage(from credits: Int) -> Int {
        switch credits {
        case 0...1499:
            return 0
        case 1500...2999:
            return 1
        case 3000...4499:
            return 2
        default:
            return 3
        }
    }

    /// Метод отображения обновленной информации о кредитах в таблице
    private func updateCreditsValue() {
        DispatchQueue.main.async {
            self.userItemsTableView.reloadData()
            self.userCreditsLabel.text = "CREDITS: \(self.user.wallet)"
        }
    }

    /// Метод настройки и воспроизведения звука
    private func play(sound: String) {
        soundManager.setupAudioPlayer(fromSound: sound)
        soundManager.audioPlayer?.play()
    }
}

// MARK: - Configure UI

private extension InfoCharacterViewController {

    /// Метод настройки пользовательского интерфейса
    func setupUI() {
        setupView()
        setupUserImageView()
        setupWalletLabel()
        setupUserItemsTableView()

        addSubviews()
        setConstraints()
    }
}

// MARK: - Setup UI

private extension InfoCharacterViewController {

    /// Метод настройки главного экрана
    func setupView() {
        view.addQuadroGradientLayer()
    }

    /// Метод настройки изображения пользователя
    func setupUserImageView() {
        userImageView.contentMode = .scaleAspectFit
        userImageView.layer.shadowColor = UIColor.black.cgColor
        userImageView.layer.shadowRadius = 5
        userImageView.layer.shadowOpacity = 0.15
        userImageView.layer.shadowOffset = CGSize(width: 5, height: 5)
    }

    /// Метод настройки отображения количества кредитов
    func setupWalletLabel() {
        userCreditsLabel.font = .boldSystemFont(ofSize: 17)
        userCreditsLabel.textColor = .black
        userCreditsLabel.textAlignment = .center
    }

    /// Метод настройки таблицы купленных предметов
    func setupUserItemsTableView() {
        userItemsTableView.dataSource = self
        userItemsTableView.delegate = self
        userItemsTableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")

        userItemsTableView.backgroundColor = .clear
        userItemsTableView.separatorStyle = .none
        userItemsTableView.layer.cornerRadius = 8
    }

    /// Метод добавления элементов интерфейса на главный экран и отключения масок AutoLayout
    func addSubviews() {
        view.addSubviews(
            userImageView,
            userCreditsLabel,
            userItemsTableView
        )

        view.disableAutoresizingMask(
            userImageView,
            userCreditsLabel,
            userItemsTableView
        )
    }
}

// MARK: - Constraints

private extension InfoCharacterViewController {

    /// Метод установки констреинтов элементов интерфейса
    func setConstraints() {
        NSLayoutConstraint.activate([
            userImageView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20),
            userImageView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            userImageView.heightAnchor.constraint(equalToConstant: 150),
            userImageView.widthAnchor.constraint(equalToConstant: 150),

            userCreditsLabel.topAnchor.constraint(equalTo: userImageView.bottomAnchor, constant: 32),
            userCreditsLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            userCreditsLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            userCreditsLabel.heightAnchor.constraint(equalToConstant: 22),

            userItemsTableView.topAnchor.constraint(equalTo: view.centerYAnchor),
            userItemsTableView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            userItemsTableView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            userItemsTableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -20)
        ])
    }
}

// MARK: - TableView DataSource

extension InfoCharacterViewController: UITableViewDataSource {

    /// Метод определения количества секций таблицы
    func numberOfSections(in tableView: UITableView) -> Int {
        user.items.count
    }

    /// Метод присвоения названий секциям таблицы
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        user.items[section].title
    }

    /// Метод определения количества ячеек внутри одной секции таблицы
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        1
    }

    /// Метод настройки ячейки таблицы
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = userItemsTableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)

        var content = cell.defaultContentConfiguration()
        content.text = user.items[indexPath.section].description
        content.secondaryText = "Sell: \(user.items[indexPath.section].price)"

        cell.backgroundColor = .white
        cell.layer.cornerRadius = 8
        cell.layer.maskedCorners = [.layerMaxXMaxYCorner, .layerMinXMaxYCorner]

        cell.contentConfiguration = content

        return cell
    }
}

// MARK: - TableView Delegate

extension InfoCharacterViewController: UITableViewDelegate {

    /// Метод настройки отображения хедера секции
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let itemNameLabel = UILabel(frame: CGRect(x: 17, y: 3, width: tableView.frame.width, height: 20))
        itemNameLabel.text = "\(user.items[section].title)"
        itemNameLabel.font = UIFont.boldSystemFont(ofSize: 17)
        itemNameLabel.textColor = .gray

        let contentView = UIView()
        contentView.layer.cornerRadius = 8
        contentView.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        contentView.addSubview(itemNameLabel)

        return contentView
    }

    /// Метод настройки фона хедера секции
    func tableView(_ tableView: UITableView, willDisplayHeaderView view: UIView, forSection section: Int) {
        view.backgroundColor = .tertiarySystemGroupedBackground
    }

    /// Метод настройки поведения приложения при нажатии на ячейку таблицы
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let cell = tableView.cellForRow(at: indexPath) {
            cell.selectedBackgroundView?.layer.cornerRadius = 8
            cell.selectedBackgroundView?.layer.maskedCorners = [.layerMinXMaxYCorner, .layerMaxXMaxYCorner]
        }

        showAlert(withTitle: "Sell this item", andMessage: "Do you really want to sell it?") { [weak self] action in
            switch action {
            case .confirm:
                guard let itemPrice = self?.user.items[indexPath.section].price else { return }
                self?.user.wallet += itemPrice
                self?.user.items.remove(at: indexPath.section)
                self?.updateUserImage()
                self?.updateCreditsValue()
            case .refuse:
                tableView.deselectRow(at: indexPath, animated: true)
            }
        }
    }
}

// MARK: - Alert Controller

private extension InfoCharacterViewController {

    /// Действия алерт-контроллера
    enum AlertAction {
        case confirm
        case refuse
    }

    /// Метод настройки алерт-контроллера
    func showAlert(withTitle title: String, andMessage message: String, _ handler: @escaping (AlertAction) -> Void) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)

        let confirmAction = UIAlertAction(title: "Confirm", style: .default) { _ in
            handler(.confirm)
        }
        let refuseAction = UIAlertAction(title: "Refuse", style: .destructive) { _ in
            handler(.refuse)
        }

        alert.addAction(confirmAction)
        alert.addAction(refuseAction)

        present(alert, animated: true)
    }
}

// MARK: - Constants

private extension InfoCharacterViewController {

    /// Имена изображений
    enum StageImages {
        static let images = [
            "stage01",
            "stage02",
            "stage03",
            "stage04"
        ]
    }

    /// Имена звуков
    enum Sounds {
        static let levelUp = "levelUp"
        static let levelDown = "levelDown"
    }
}

// TODO: - InfoCharacter ViewController Protocol

extension InfoCharacterViewController: ISendInfoAboutCharacterDelegate {

    /// Метод обновления количества кредитов
    func updateCharacterWallet(with newValue: Int) {
        //userNameLabel.text = newValue.description
    }
}
