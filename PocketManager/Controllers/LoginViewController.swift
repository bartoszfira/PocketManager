//
//  LoginViewController.swift
//  PocketManager
//
//  Created by Bartek Fira on 12/07/2022.
//

import UIKit
import FirebaseAuth

class LoginViewController: UIViewController {
    @IBOutlet weak var loginView: LoginView!
    
    var viewModel: LoginViewModel?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel = LoginViewModel(presenter: self)

        hideKeyboardWhenTappedAround()
        setupActions()

        viewModel?.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.setNavigationBarHidden(true, animated: true)
    }
    
    func setupActions() {
        loginView.passwordResetButton.addTarget(
            viewModel,
            action: #selector(viewModel?.didSelectPasswordReset),
            for: .touchUpInside
        )
        loginView.registerButton.addTarget(
            viewModel,
            action: #selector(viewModel?.didSelectRegister),
            for: .touchUpInside
        )
        loginView.loginButton.addTarget(
            self,
            action: #selector(loginSelected),
            for: .touchUpInside
        )
    }

    @objc func loginSelected() {
        viewModel?.updateCredentials(
            with: loginView.loginView.dataTextField.text,
            and: loginView.passwordView.dataTextField.text
        )

        viewModel?.didSelectLogin()
    }
}

extension LoginViewController: LoginPresenter {
    func navigateToDashboard() {
        DispatchQueue.main.async { [weak self] in
            self?.navigationController?.replaceWith(UITabBarController.instantiate(controllerId: "MainTabBarController"))
        }
    }
    
    func navigateToRegister() {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: "RegisterViewController") as! RegisterViewController
        self.navigationController?.pushViewController(vc, animated: true)
    }

}
