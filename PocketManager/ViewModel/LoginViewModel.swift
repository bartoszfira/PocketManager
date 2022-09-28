//
//  LoginViewModel.swift
//  PocketManager
//
//  Created by Bartek Fira on 26/09/2022.
//

import Foundation
import FirebaseAuth

final class LoginViewModel {
    var credencials = Credentials()
    weak var presenter: LoginPresenter?
    
    init(presenter: LoginPresenter) {
        self.presenter = presenter
    }

    func viewDidLoad() {
        // TODO: --
//        AuthService.shared.logIn(withEmail: "barfira321@gmail.com",
//                                 password: "admin1") { [weak self] result, error in
//            if error != nil { return }
//            self?.presenter?.navigateToDashboard()
//        }
    }
}

extension LoginViewModel {
    public func updateCredentials(with username: String?, and password: String?) {
        credencials.username = username ?? ""
        credencials.password = password ?? ""
    }
}

extension LoginViewModel {
    @objc func didSelectPasswordReset() {
        print("Did select password reset")
    }
    
    @objc func didSelectLogin() {
        Auth.auth().signIn(
            withEmail: credencials.username,
            password: credencials.password
        ) { [weak self] result, error in
            if error != nil { return }

            self?.presenter?.navigateToDashboard()
        }
    }
    
    @objc func didSelectRegister() {
        presenter?.navigateToRegister()
    }
}
