//
//  StartViewController.swift
//  UiLuxury_TeamProject
//
//   Created by Юрий Куринной on 09.03.2024.
//

import UIKit

// MARK: - StartViewController

final class StartViewController: UIViewController {
    
    // MARK: Private properties
    
    /// Объект вью этого контроллера
    private let startView = StartView(frame: UIScreen.main.bounds)
    
    /// Вью-модель с данными пользователя
    private var viewModel: StartViewModelProtocol!
    
    /// Базовый координатор, управляющий этим контроллером
    private let coordinator: BaseCoordinatorProtocol!
    
    // MARK: - Initializers
    
    init(coordinator: BaseCoordinatorProtocol) {
        self.coordinator = coordinator
        super.init(nibName: nil, bundle: nil)
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError(GlobalConstants.fatalError)
    }
    
    // MARK: - Lifecycle methods
    
    override func loadView() {
        view = startView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupBinding()
        addActions()
    }
    
    // MARK: - Private methods
    
    /// Метода переход на игровой экран
    @objc private func startTapped() {
        coordinator.moveToGame()
    }
}

// MARK: - Setup Binding

private extension StartViewController {
    
    /// Метод связывает контроллер с вьюмоделью
    func setupBinding() {
        viewModel = StartViewModel()
    }
}


// MARK: - Actions

private extension StartViewController {
    
    /// Метод добавляет действия для активных элементов пользовательского интерфейса
    func addActions() {
        startView.startButton.addTarget(
            self,
            action: #selector(startTapped),
            for: .touchUpInside
        )
    }
}

