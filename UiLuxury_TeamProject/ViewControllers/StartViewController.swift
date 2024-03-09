//
//  StartViewController.swift
//  UiLuxury_TeamProject
//
//   Created by Юрий Куринной on 09.03.2024.
//

import UIKit

// MARK: - StartViewController

class StartViewController: UIViewController{
    
    // MARK: - Private properties
    
    private let greetingsLabel = UILabel()
    private let startButton = UIButton()
    
    // TODO: Удалить, если не потребуются в ВМ
//    var nameTextField: UITextField!
//    var user = User.shared
    
    // MARK: - Lifecycle methods
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    // MARK: - Private methods
    
    @objc private func startGame() {
        let vc = GameTabBarController()
        vc.modalPresentationStyle = .fullScreen
        present(vc, animated: true)
    }
    
}

// MARK: -  Configure UI

private extension StartViewController {
    func setupUI() {
        setupViews()
        addActions()
        addSubviews()
        setConstraints()
    }
}

// MARK: - Setup UI

private extension StartViewController {
    
    func addSubviews() {
        view.addSubviews(
        
        )
    }
    
    func setupViews() {
        view.addQuadroGradientLayer()
        
        view.disableAutoresizingMask(
        
        )
    }
    
    func addActions() {
        
    }
}

// MARK: - Constraints

private extension StartViewController {
    
    func setConstraints() {
        
    }
}
