//
//  RegisterViewController.swift
//  PocketManager
//
//  Created by Bartek Fira on 12/07/2022.
//

import UIKit

class RegisterViewController: UIViewController {
    @IBOutlet weak var registerView: RegisterView!

    var viewModel: RegisterViewModel?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.hideKeyboardWhenTappedAround()
        self.navigationController?.setNavigationBarHidden(false, animated: false)
        viewModel = RegisterViewModel(presenter: self)

        setupActions()
    }
    
    func setupActions() {
        registerView.ctaButton.addTarget(
            self,
            action: #selector(didSelectRegister),
            for: .touchUpInside
        )
    }

    @objc func didSelectRegister() {
        viewModel?.updateCredentials(
            .init(
                email: registerView.mailView.dataTextField.text,
                name: registerView.nameView.dataTextField.text,
                surname: registerView.surnameView.dataTextField.text,
                password: registerView.passwordView.dataTextField.text
            )
        )

        viewModel?.didSelectRegister()
    }
    
}

extension RegisterViewController: RegisterPresenter {
    func navigateToLogin() {
        self.navigationController?.popViewController(animated: true)
    }
}
