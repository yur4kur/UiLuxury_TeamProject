//
//  DevelopersInfoViewController.swift
//  UiLuxury_TeamProject
//
//  Created by Eldar Abdullin on 7/3/24
//

import UIKit

// MARK: - DevelopersInfo ViewController
final class DevelopersInfoViewController: UIViewController {

    // MARK: - Private properties
    private let mainLabel = UILabel()
    private var developerSegments = UISegmentedControl()
    private let developerImageView = UIImageView()
    private let developerContactLabel = UILabel()

    private var segmentIndex = 0

    // MARK: - Lifecycle methods
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        setupBinding()
    }

    // MARK: - Private Methods
    @objc private func showDeveloperInfo() {
        let selectedSegmentIndex = developerSegments.selectedSegmentIndex
        guard selectedSegmentIndex < DevelopersInfo.names.count else { return }
        segmentIndex = selectedSegmentIndex

        guard let developerImage = UIImage(named: String(segmentIndex)) else { return }
        let developerContact = DevelopersInfo.contacts[segmentIndex]

        developerImageView.image = developerImage
        developerContactLabel.text = developerContact
    }
}

// MARK: - Configure UI
private extension DevelopersInfoViewController {
    func setupUI() {
        setupView()
        setupMainLabel()
        setupDeveloperSegments()
        setupDeveloperImageView()
        setupDeveloperContactLabel()

        addSubviews()
        setConstraints()
    }

    func setupBinding() {
        developerSegments.addTarget(self, action: #selector(showDeveloperInfo), for: .valueChanged)
    }
}

// MARK: - Setup UI
private extension DevelopersInfoViewController {
    func setupView() {
        view.backgroundColor = .white
    }

    func setupMainLabel() {
        mainLabel.text = "Developers"
        mainLabel.font = UIFont.boldSystemFont(ofSize: 17)
        mainLabel.textColor = .black
        mainLabel.textAlignment = .center
    }

    func setupDeveloperSegments() {
        developerSegments = UISegmentedControl(items: DevelopersInfo.names)
        developerSegments.selectedSegmentIndex = segmentIndex
        showDeveloperInfo()
    }

    func setupDeveloperImageView() {
        developerImageView.contentMode = .scaleAspectFill
        developerImageView.layer.cornerRadius = 8
        developerImageView.clipsToBounds = true
    }

    func setupDeveloperContactLabel() {
        developerContactLabel.font = UIFont.systemFont(ofSize: 17)
        developerContactLabel.textColor = .black
        developerContactLabel.textAlignment = .left
    }

    func addSubviews() {
        view.addSubviews(mainLabel, developerSegments, developerImageView, developerContactLabel)
        view.disableAutoresizingMask(mainLabel, developerSegments, developerImageView, developerContactLabel)
    }
}

// MARK: - Constraints
private extension DevelopersInfoViewController {
    func setConstraints() {
        NSLayoutConstraint.activate([
            mainLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20),
            mainLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            mainLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            mainLabel.heightAnchor.constraint(equalToConstant: 22),

            developerSegments.topAnchor.constraint(equalTo: mainLabel.bottomAnchor, constant: 20),
            developerSegments.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            developerSegments.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            developerSegments.heightAnchor.constraint(equalToConstant: 32),

            developerImageView.topAnchor.constraint(equalTo: developerSegments.bottomAnchor, constant: 20),
            developerImageView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            developerImageView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            developerImageView.widthAnchor.constraint(equalTo: developerImageView.heightAnchor, multiplier: 1),

            developerContactLabel.topAnchor.constraint(equalTo: developerImageView.bottomAnchor, constant: 20),
            developerContactLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            developerContactLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            developerContactLabel.heightAnchor.constraint(equalToConstant: 22)
        ])
    }
}

// MARK: - Constants
private extension DevelopersInfoViewController {
    enum DevelopersInfo {
        static let names = [
            "Misha",
            "Yuriy",
            "Kirill",
            "Biibol",
            "Rustam",
            "Eldar"
        ]

        static let contacts = [
            "https://t.me/AkiraReiTyan",
            "https://t.me/Radiator074",
            "https://t.me/kizi_mcfly",
            "https://t.me/zubi312",
            "https://t.me/hellofox",
            "https://t.me/eldarovsky"
        ]
    }
}
